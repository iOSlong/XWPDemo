//
//  PDValueSlider.swift
//  PDemo
//
//  Created by xw.long on 2021/3/19.
//

import UIKit

/*
 slider 曲线图——映射坐标公式：
 [ ax + b = y ]
 a -- lineA
 
 
 */
class PDValueSlider: UIView {
    
    var vSliderBlock:((_ vSlider:PDValueSlider) -> ())?
    
    private var _a:Float = 1 //default
    private var _b:Float = 0 //deftult

    lazy var slider:UISlider = quickSlider(3)
    lazy var labelVal:UILabel = quickLabel(0)
    lazy var labelRef:UILabel = quickLabel(1)

    private(set) var refValue: CGFloat = 1.0  //将set私有，实现只读属性。
    private(set) var oriValue: CGFloat = 0.5
    private(set) var oriMark: String = ""

    private func quickLabel(_ index:Int)->UILabel {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return label
    }

    private func quickSlider(_ index:Int)->UISlider{
        let locationY = index * 40 + Int(navigationSizeHeight()) + 10
        let sliderW = UIScreen.main.bounds.width - 20;
        let slider = UISlider.init(frame: CGRect.init(x: 10, y: locationY, width: Int(sliderW), height: 30))
        slider.value = 0.5
        slider.addTarget(self, action: #selector(valueChangeSlider(_:)), for: .valueChanged)
        return slider
    }

    private func buildSlidItems()  {
        self.addSubview(self.slider)
        self.addSubview(self.labelRef);
        self.addSubview(self.labelVal)
        self.labelVal.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp_leftMargin)
            maker.centerY.equalTo(self.snp_centerYWithinMargins)
            maker.right.equalTo(self.slider.snp_leftMargin).offset(-10)
        }
        self.slider.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(self.snp_centerYWithinMargins)
            maker.right.equalTo(self.labelRef.snp_leftMargin).offset(-10)
        }
        self.labelRef.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(self.snp_centerYWithinMargins)
            maker.right.equalTo(self.snp_rightMargin)
        }
    }
    
    
    @objc private func valueChangeSlider(_ slider:UISlider) {
        self.reloadLabelValue()
        if (self.vSliderBlock != nil) {
            self.vSliderBlock!(self)
        }
    }
    
    public func setRefrenceValueConfig(halfRefV:Float,topRefV:Float) {
        self._a = (topRefV - halfRefV) * 2.0
        self._b = topRefV - self._a;
        print("halfRefY:\(halfRefV), topRefY:\(topRefV) ==>")
        print(self.oriMark,"[ax + b = y] :","[\(self._a)x+(\(self._b)) = y]")
    }

    public func setRefrenceValue(ref_mapVal:Float){
        let oriY = (ref_mapVal - self._b)/self._a;
        self.slider.value = oriY
        self.reloadLabelValue()
    }
    
    public func reloadLabelValue()  {
        let valY = self.slider.value * self._a + self._b;
        self.oriValue = CGFloat(self.slider.value);
        self.refValue = CGFloat(valY);
        self.labelRef.text = String.init(format:"%.2f",valY)
        self.labelVal.text = String.init(format:self.oriMark+":"+"%.2f",self.slider.value)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildSlidItems()
    }
    
    init(frame: CGRect, oriMark:String) {
        super.init(frame: frame)
        self.oriMark = oriMark
        self.buildSlidItems()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
