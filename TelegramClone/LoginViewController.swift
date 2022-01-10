//
//  LoginViewController.swift
//  TelegramClone
//
//  Created by Muhd Mirza on 11/1/22.
//

import UIKit

import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login() {
        guard let email = self.emailTextfield.text else {
            return
        }
        
        guard let password = self.passwordTextfield.text else {
            return
        }
        
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let result = result {
                print(result.user.uid)
                print(result.user.email!)
                
                DispatchQueue.main.async {
                    let tabBarVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainTabViewController") as? UITabBarController
                    tabBarVC?.selectedIndex = 1
                    
                    tabBarVC?.modalPresentationStyle = .fullScreen
                    
                    self.present(tabBarVC!, animated: true, completion: nil)
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
