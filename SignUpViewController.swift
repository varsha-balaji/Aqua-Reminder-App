//
//  SignUpViewController.swift
//  Aqua Hydrate
//
//  Created by Varsha Balaji on 8/16/20.
//  Copyright © 2020 Varsha Balaji. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var FirstNameText: UITextField!
    
    @IBOutlet weak var LastNameText: UITextField!
    
    @IBOutlet weak var EmailText: UITextField!
    
    @IBOutlet weak var PasswordText: UITextField!
    
    @IBOutlet weak var SignUpButton: UIButton!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Do any additional setup after loading the view.
        setUpElements()
    }
    
    
    func setUpElements(){
        //hides the error until we need it to show up
        ErrorLabel.alpha = 0;
        
        //style the elements
        Utilities.styleTextField(FirstNameText)
        Utilities.styleTextField(LastNameText)
        Utilities.styleTextField(EmailText)
        Utilities.styleTextField(PasswordText)
        Utilities.styleFilledButton(SignUpButton)
        
    }

    //method to validate the fields
    //checks the fields to make sure data is correct-->if correct method returns nill.
    //if incorrect--> method returns error message
    func validateFields() -> String?{
        
        //Check that all fields are filled in
        //gets rid of white spaces and new lines
        //? means you are not sure if there is text, because in this case they could have not filled it in
        if FirstNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            LastNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            EmailText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        //Check if password is secure
        //! means you are sure there is text since it passed through the initial if statement above
        let cleanedPassword = PasswordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //this method in Utilities.swift uses a sysetm to check if it has the proper specifications
        if Utilities.isPasswordValid(cleanedPassword) == false{
            return "Please make sure your password is at least 8 characters, contains a special character, and a number."
        }
        
        return nil
    }
    
    @IBAction func SignUpTapped(_ sender: Any) {
        
        //Validate the fields
        let error = validateFields()
        if error != nil{
            //there was an error with the fields
            showError(error!)
        }
        
        else{
            //create cleaned versions of the data
            let firstName = FirstNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = LastNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = EmailText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = PasswordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            //the user uid that is created in teh authentification place will be returned in result
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                
                //Check for errors
                //if theere are no errors the error parameter should be nil
                if error != nil{
                    //there was an error creating the user because it is not nil
                    self.showError("Error creating user.")
                }
                else{
                    //User was created successfully, now store the first and last name
                    //db is reference to firestore object
                    let db = Firestore.firestore()
                    
                    //users because thats our collection name in the Firebase directory
                    //dictionary
                    db.collection("users").addDocument(data:  ["firstname":firstName,"lastname":lastName, "uid":result!.user.uid]) { (error) in
                        
                        //have to do this since error is an optional
                        if error != nil{
                            //show error message
                            self.showError("Error saving user data.")
                        }
                    }
                    
                    //transition to home screen
                    self.transitiontoHome()
                    
                }
            }
            
        }
    }
    
    
    func showError(_ message:String){
           ErrorLabel.text = message
           ErrorLabel.alpha = 1
           
       }
    
    //first give the home screen a Storyboard ID
    //create a new swift file in Helpers folder
    func transitiontoHome(){
        //this returns a viewController so have to cast as a HomeViewController
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        //to swap the screens and change the root
        view.window?.rootViewController = homeViewController
        //this shows the HomeViewController as the root instead
        view.window?.makeKeyAndVisible()
    }
        
}
