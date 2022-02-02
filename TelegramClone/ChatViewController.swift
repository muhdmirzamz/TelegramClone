//
//  ChatViewController.swift
//  TelegramClone
//
//  Created by Muhd Mirza on 29/1/22.
//

import UIKit

import FirebaseAuth
import FirebaseDatabase

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textfield: UITextField!
    
    var testArr = ["Hello", "bye", "yoo"]
    
    var otherUserID: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.hidesBottomBarWhenPushed = true
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        print("User id: \(otherUserID)")
        
        self.textfield.becomeFirstResponder()
        
    }
    
    @IBAction func sendMessage() {
        let ref = Database.database().reference()
        
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        
        
        guard let chatID = ref.child("/chats").childByAutoId().key else {
           return
        }
        
        let chatDict: NSMutableDictionary = [
            "chatName": "",
            "chatDescription": "",
        ]
        
        // set the general chats database first
        ref.child("/chats").child("\(chatID)").setValue(chatDict)
        
        // set the user specific chats
        ref.child("/userChats").child(userID).setValue(chatID)
        
        guard let messageID = ref.child("/messages/\(chatID)").childByAutoId().key else {
           return
        }
        
        guard let message = self.textfield.text else {
            return
        }
        
        let messageDict: NSMutableDictionary = [
            "sender": userID,
            "content": message,
        ]
        
        ref.child("/messages/\(chatID)/\(messageID)").setValue(messageDict)
        
        
        
        
        
        

        // set the user specific chats
        ref.child("/userChats").child(otherUserID).setValue(chatID)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.testArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()

        // Configure content.
        content.text = self.testArr[indexPath.row]

        cell.contentConfiguration = content
        
        return cell
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
