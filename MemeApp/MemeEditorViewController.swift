//
//  MemeEditorViewController.swift
//  MemeApp
//
//  Created by Fabiola Ramirez on 4/8/17.
//  Copyright © 2017 Fabiola Ramirez. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController {
    
    
    @IBOutlet weak var tabBar: UIToolbar!
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButtonItem: UIBarButtonItem!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var meme : Meme!
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSStrokeWidthAttributeName: -3.0,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButtonItem.isEnabled = false
        
        configure(textField: topTextField, text: "TOP", defaultAttributes: memeTextAttributes)
        configure(textField: bottomTextField, text: "BOTTOM", defaultAttributes: memeTextAttributes)
    }
    
    func configure(textField: UITextField, text: String, defaultAttributes: [String:Any]){
        textField.delegate = self
        textField.defaultTextAttributes = defaultAttributes
        textField.textAlignment = NSTextAlignment.center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    @IBAction func pickaAnImage(_ sender: Any) {
        presentImagePickerWith(sourceType: .photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        presentImagePickerWith(sourceType: .camera)
    }
    
    
    func save(){
        if imagePickerView.image != nil {            
            meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
            appDelegate.memes.append(meme)
            //UIImageWriteToSavedPhotosAlbum(meme.memedImage, nil, nil, nil)
        }
        
        
    }
    
    func generateMemedImage() -> UIImage{
        
        toogleBars(hide: true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toogleBars(hide: false)
        
        return memedImage
        
    }
    
    func toogleBars(hide: Bool) {
        navigationController?.isNavigationBarHidden = hide
        tabBar.alpha = hide ? 0 : 1
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func shareImage(_ sender: Any) {
        if imagePickerView.image != nil {
            let shareItems:[Any] = [generateMemedImage()]
            let activityViewController = UIActivityViewController(activityItems: shareItems,
                                                                  applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            activityViewController.completionWithItemsHandler = {
                (_, success, _, _) in
                if success{
                    self.save()
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
            present(activityViewController, animated: true, completion: nil)
        }
    }
}

extension MemeEditorViewController : UITextFieldDelegate {
    
    // MARK: - TextField Delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            topTextField.text = ""
        } else {
            bottomTextField.text = ""
        }
    }
    
    
    
    // Move the view when the keyboard covers the textfield
    
    func keyboardWillShow(_ notification:Notification) {
        
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
    //other
    
    func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
}

extension MemeEditorViewController: UINavigationControllerDelegate {
    
}

extension MemeEditorViewController: UIImagePickerControllerDelegate {
    
    func presentImagePickerWith(sourceType: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    //   MARK: - imagePickerController Delegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            shareButtonItem.isEnabled = true
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}



