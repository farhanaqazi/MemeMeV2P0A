//
//  MemeEditorViewController.swift
//  MemeMeV1P0A
//
//  Created by Farhan Qazi on 7/23/18.
//  Copyright © 2018 Farhan Qazi. All rights reserved.
//


import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    // MARK: Step 0: Sets Appdelegate as Shared File
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    ////****************** Start-THE OUTLETS BLOCK  ***************************
    
    // MARK: Step 1a: The Outlets for both of the Textfields
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    // MARK: Step1b: The Outlets for the Toolbar, ImagePickerView and the CameraButton
    @IBOutlet weak var Toolbar: UIToolbar!
    @IBOutlet weak var ImagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    // MARK: Step 1c: The Outlet for the Navigational Bar
    @IBOutlet weak var navigationalBar: UINavigationBar!
    
    ////****************** End-THE OUTLETS BLOCK  ***************************
    
    /// @@@@@@@@@@@@@@@@@@@@@  Start: Meme Text MANIPULATION BLOCK @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    
    // MARK: Step: 3a: Define the new Dictionary for the text attributes to be added for this Meme V1.0 app
    
    let memeTextV1:[String: Any] = [
        NSAttributedString.Key.strokeColor.rawValue: UIColor.black,
        NSAttributedString.Key.foregroundColor.rawValue: UIColor.white,
        NSAttributedString.Key.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,NSAttributedString.Key.strokeWidth.rawValue: -6]
    
    
    
    // MARK: Step: 3b:When a user presses return, the keyboard should be dismissed.
    //resignFirstResponder is a method that is defined in a class UIResponder. As textfield are created out of subclass of UITextfield. bottomtextfield or toptextfield are using a method, not from its parent class UITextfield, but a method from outside its class, i-e from class UIResponder. you can check the parent of UITextField by rightclick on the UITextField and choose Jump to Definition you will see UITextField extends UIControl UIControl extends UIView UIView extends UIResponder, that's the reason why we can use resignFirstRespond for the UITextField. So in other words, UIResponder is subclass of UIView who is subclass of UIControl which ends up being a parent class of UITextfield.
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        topText.resignFirstResponder()
        bottomText.resignFirstResponder()
        return true;
    }
    
    // MARK: Step: 3c: When a user taps inside a textfield, the default text should clear.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //        topText.text = ""
        //        bottomText.text = ""
        
        if topText.text == "TOP" {
            topText.text = ""}
        if bottomText.text == "BOTTOM" {
            bottomText.text = ""}
    }
    /////**************************************** END:  Textfield manipulation block  **********************************************************
    
    
    // MARK: Step4.1:  viewDidLoad Called with both textfield delegates, code to enable camera button & Text Attribute
    override func viewDidLoad() {
        super.viewDidLoad()
        topText.delegate = self
        bottomText.delegate = self
        
        configureTextFields(textField: topText, text: "TOP TEXT")
        configureTextFields(textField: bottomText, text: "BOTTOM TEXT")
        
        print("View Did Load- Camera Button hss been disabled")
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        ImagePickerView.contentMode = .scaleAspectFit
        
    }
    //MARK: Step4.2: Configuring text fields function, Handles and assigns default
    // text attrubutes to newly defined text attribute Dictionary in Step 2
    
    func configureTextFields(textField: UITextField, text: String!){
        textField.defaultTextAttributes = convertToNSAttributedStringKeyDictionary(memeTextV1)
        textField.textAlignment = .center
        textField.borderStyle = UITextField.BorderStyle.none
        textField.backgroundColor = UIColor.clear
        textField.text = text
    }
    
    /////********************************************Start *********************************************************
    
    // MARK: Step5:  Code for Keyboard Adjustments
    
    //This method subscribe to keyboard notifications will be called in view will appear:
    // In this block of code, the view controller is signing up for the notification
    // when the" . UIKeyboardWillshow/hide " will be coming up
    
    func subscribeToKeyboardNotifications() {
        //Keyboard will show
        NotificationCenter.default.addObserver(self, selector:
            #selector(MemeEditorViewController.keyboardWillShow), name:
            UIResponder.keyboardWillShowNotification, object: nil)
        //Keyboard will hide
        NotificationCenter.default.addObserver(self, selector:
            #selector(MemeEditorViewController.keyboardWillHide), name:
            UIResponder.keyboardWillHideNotification, object: nil)
    }
    // MARK: Step6:  viewWillAppear. Disabling the camera button for non camera devices ,Subscribing to keyboard notification
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //// This will disable the camera button
        print("View Will Apear Camera Button hss been disabled")
        cameraButton.isEnabled =
            UIImagePickerController.isSourceTypeAvailable(.camera)
        //// This will show Keyboard notification
        subscribeToKeyboardNotifications()
        print("Subscribed to Keyboard Called")
        
    }
    // MARK: Step7a: This method being created,Un-subscribes  to keyboard notifications will be called in view will disappear
    
    func unsubscribeFromKeyboardNotifications() {
        print("Unsubscribed from keyboard called")
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
    }
    
    // MARK: Step7b: viewWillDisappear This method ,Un-subscribes  to keyboard notifications
    override func viewWillDisappear(_ animated: Bool) {
        print("View Will Disappear called")
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    
    // MARK: Step7c:  This method gets the keyboard height
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect()
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: Step7d: Shows KeyBoard and calls the method defined earlier getkeyboardheight
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomText.isFirstResponder{
            
            view.frame.origin.y -= getKeyboardHeight(notification: notification as NSNotification)
        }
    }
    // MARK: Step7e: This method Hides the keyboard
    @objc func keyboardWillHide(notification: NSNotification)
        
    {
        view.frame.origin.y = 0
    }
    //// @@@@@@@@@@@@@@@@@@@@@  End: KEYBOARD MANIPULATION BLOCK @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    
    /////**************************************************Start ********************************************
    
    
    
    //MARK: Step 2a: A new Method to be used for both picture album and camera import
    func imageSelector(ofType type: UIImagePickerController.SourceType!) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = type
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    // MARK: Step: 2b: IBACTION: imagePickerController for delegate. ImagePickerControllerDelegate methods in order to get access to an image chosen from the Photo library
    
    //    at first we use UIImagePickerController to pick the photo
    //
    //    afterwords, this controller will return data of the image in UIImage type, the image was already in the dictionary.
    //
    //    info[UIImagePickerControllerOriginalImage] as? UIImage
    //
    //    but the type of the image in the dictionary is any so we need to cast any to the image. We use pickerController.delegate = self to tell the picker controller that we want to get the data of the image in current View Controller. The value in the info dictionary is optional because sometime we can't get the data due to the permission etc. Therefore, we have to downcast the value to UIImage because the type of info is [String: any].
    
    @IBAction func PickAnImage(_ sender: Any) {
        print("***PhotoLib Button Pressed***")
        imageSelector(ofType: .photoLibrary)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        
        
        // The dictionary key for the original version of the selected image: retreives image from the image picker, puts in your imagePickerView
        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage {
            ImagePickerView.image = image /// NOw, the Outlet is going to have the picked image, image displayed.
            // Happy Face
        } else {
            // Sad Face
        }
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: Step: 2c IBACTION :Image Picker action from Camera, ImagePickerControllerDelegate methods
    
    @IBAction func CameraInput(_ sender: Any) {
        print("***Camera Button Pressed***")
        imageSelector(ofType: .camera)
    }
    
    
    // MARK: Step: 2d: Calling 2nd of the 2 optional methods of the Delegate method that dismisses the choice.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
        // dismisses the image picker
        self.dismiss(animated: true, completion: nil)
    }
    
    /////**************************************** END  **********************************************************
    
    
    
    
    
    
    func generateMemedImage() -> UIImage {
        
        //hides toolbar and navbar
        self.Toolbar.isHidden = true
        self.navigationalBar.isHidden = true
        
        // Renders view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //shows toolbar and navbar
        self.Toolbar.isHidden = false
        self.navigationalBar.isHidden = false
        return memedImage
    }
    // MARK: Step 2e: App Delegate Line gets added up here
    // Below is a method that initializes a Meme model object
    func save() {
        // Saves the Meme just created, using the Structure Meme defined earlier.
        let meme = Meme(topText: topText.text!, botText: bottomText.text!,
                        editedImage: ImagePickerView.image!, memedImage: generateMemedImage())
        
        // (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
        
        
        // Add it to the memes array in the Application Delegate
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
       
    }

    
    
    
    /// Share button Action for Meme Generator:
    @IBAction func shareButton(_ sender: UIButton) {
        let memedImage = generateMemedImage()
        
        let activityViewController = UIActivityViewController(activityItems:
            [memedImage], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
        
        /// UIActivityViewController class has a completionWithItemsHandler property.
        /// In the completion handler you can specify methods you would like to be called
        /// once an activity, like sharing a meme, has been completed.
        
        activityViewController.completionWithItemsHandler = { any_activity, ok , any, any_error in
            if ok {
                self.save()
                
                //Dismiss the Activity View. Finally, after the Meme object has been saved the activity view will dismiss itself.
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        print("Share Button Pressed")
        
    }
    /// ************************* End Meme Handler object  *********************
    
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        ImagePickerView.image = nil
        print("User cancelled the image picking action")
    }
}



// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
