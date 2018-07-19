//
//  addClothesViewController.swift
//  LaundryDay
//
//  Created by MBP03 on 2018. 4. 27..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit
import ProgressHUD


class AddClothesViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var uploadButton: UIButton!
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture =  UITapGestureRecognizer(target: self, action: #selector(self.handleSelectImage))
        productImageView.addGestureRecognizer(tapGesture)
        productImageView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }

    @objc func handleSelectImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "카메라", style: .default, handler: {(action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                pickerController.sourceType = .camera
                self.present(pickerController,animated: true, completion: nil)
            } else {
                print("카메라가 비활성화 되어있습니다.")
            }
            }))
        actionSheet.addAction(UIAlertAction(title: "앨범", style: .default, handler: {(action: UIAlertAction) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController,animated: true,completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(actionSheet,animated: true,completion: nil)
        
    }
    
    @IBAction func uploadButton_TUI(_ sender: Any) {
        ProgressHUD.show("Waiting")
        if let productImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(productImg, 0.1) {
            HelperService.updataToServer(data: imageData, productName: productNameTextField.text!, onSuccess: {
//                if (self.delegate != nil) {
//                    self.delegate?.changeClosetIdToAll(id: "All")
//                }
//
//                ClosetListViewController.removeViewController(childVC: self)
                TimeDelay.runThisAfterDelay(seconds: 0.5){
                    self.dismiss(animated: true, completion: nil)
                }
                //self.dismiss(animated: true, completion: nil)
                })
            
        } else {
            ProgressHUD.showError("Profile Image should be selected.")
        }
    
        
    }
    
    
    //추가하기 창 취소
    @IBAction func cancelButton_TUI(_ sender: Any) {
        //ClosetListViewController.removeViewController(childVC: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    var delegate: AddClothesViewControllerDelegate?
    

    

}
protocol AddClothesViewControllerDelegate {
    func changeClosetIdToAll(id: String)
}

extension AddClothesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = image
            productImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}



