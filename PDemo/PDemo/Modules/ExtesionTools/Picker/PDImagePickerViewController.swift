//
//  PDImagePickerViewController.swift
//  PDemo
//
//  Created by xw.long on 2021/3/27.
//

import UIKit

class PDImagePickerViewController: PDViewController , UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.showNoneNavigationBackButton()
        self.showRightButton(title: "Picker")
        
        self.showUIImagePickerViewController()
        
    }
    
    override func rightButtonClick(_: UIButton) {
        self.showUIImagePickerViewController()
    }

    //MARK:UIImagePickerViewController
    func showUIImagePickerViewController() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            // 4.
            imagePicker.delegate = self
            // get full access, otherwise use .savedPhotosAlbum
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            // Starts up the UIImagePickerController
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //UIImagePickerControllerDelegate & UINavigationControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        self.backgroundImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
}
