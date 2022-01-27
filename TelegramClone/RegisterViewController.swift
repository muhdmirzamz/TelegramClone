//
//  RegisterViewController.swift
//  TelegramClone
//
//  Created by Muhd Mirza on 9/1/22.
//

import UIKit

import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var phoneNumberTextfield: UITextField!
    @IBOutlet var nameTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var usernameTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func register() {
        guard let email = self.emailTextfield.text else {
            return
        }

        guard let phoneNumber = self.phoneNumberTextfield.text else {
            return
        }
        
        guard let name = self.nameTextfield.text else {
            return
        }
        
        guard let username = self.usernameTextfield.text else {
            return
        }
        
        guard let password = self.passwordTextfield.text else {
            return
        }
        


        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let result = result {
                print(result.user.uid)
                print(result.user.email!)
                
                let ref = Database.database().reference()
                let userID = result.user.uid
                
                let listDict: NSMutableDictionary = [
                    "number": phoneNumber,
                    "bio": "",
                    "status": "",
                    "username": username,
                    "name": name,
                ]
                
                // .child auto creates an entry too apparently
                ref.child("/profile").child(userID).setValue(listDict)
                

                let alert = UIAlertController.init(title: "Great!", message: "Sign up successful", preferredStyle: .alert)
                let okAction = UIAlertAction.init(title: "OK", style: .default) { (action) in
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }

                alert.addAction(okAction)

                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
