//
//  ChatTableViewController.swift
//  TelegramClone
//
//  Created by Muhd Mirza on 31/12/21.
//

import UIKit

import FirebaseAuth
import FirebaseDatabase

class ChatListTableViewController: UITableViewController, UISearchResultsUpdating {

    var searchController: UISearchController?
    
//    var filteredItemsArray = []()
    
    var randomArr = ["Hello", "Bye", "Yo"]
    
    var usersArr: [String] = []
    var userIDArr: [String] = []
    var filteredUsersArr: [String] = []
    
//    var userChats: [String] = []
    
    var userChatsArr: [Chat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.registerTableViewCell()
        self.registerUserTableViewCell()
        
        self.searchController = UISearchController.init(searchResultsController: nil)
        self.searchController?.searchResultsUpdater = self
        
//        self.searchController?.dimsBackgroundDuringPresentation = false
        self.searchController?.definesPresentationContext = true
        self.tableView.tableHeaderView = self.searchController?.searchBar
    }
    
    func getUserProfiles() {
        self.userIDArr.removeAll()
        self.usersArr.removeAll()
        
        let ref = Database.database().reference()
        
        ref.child("/profile").observeSingleEvent(of: .value) { (snapshot) in
            
            
        
            if let profilesDict = snapshot.value as? Dictionary<String, Any> {
                
                // for every profile
                for profileObj in profilesDict {
                    
//                    print("key: \(profileObj.key)")
                    
                    self.userIDArr.append(profileObj.key)

                    if let profileInfo = profileObj.value as? Dictionary<String, Any> {
                        
//                        print("ProfileInfo: \(profileInfo)")
                        
                        // get the username
                        guard let username = profileInfo["username"] as? String else {
                            return
                        }
                        
                        self.usersArr.append(username)
                    }

                }
                
                for i in self.usersArr {
                    print("User: \(i)")
                }

            }

        }
    }

    func getUserChats() {
        self.userChatsArr.removeAll()
        
        let ref = Database.database().reference()
        let currentUserID = Auth.auth().currentUser?.uid
        
        ref.child("/userChats/\(currentUserID!)").observeSingleEvent(of: .value) { (snapshot) in
            
            if let userChatArr = snapshot.value as? Dictionary<String, Any> {
                
                for userChat in userChatArr {
                    
                    let chat = Chat()
                    
                    print("User chat value: \(userChat.value)")
                    
                    guard let chatID = userChat.value as? String else {
                        return
                    }
                    
                    chat.chatID = chatID
                    
                    ref.child("/chats/\(userChat.value)").observeSingleEvent(of: .value) { (snapshot) in
                        if let chatProperties = snapshot.value as? Dictionary<String, Any> {
                            print("Chat properties: \(chatProperties)")
                            
                            guard let chatName = chatProperties["chatName"] as? String else {
                                return
                            }
                            
                            guard let chatDescription = chatProperties["chatDescription"] as? String else {
                                return
                            }
                            
                            chat.chatName = chatName
                            chat.chatDescription = chatDescription
                            
                            self.userChatsArr.append(chat)
                            
                            print("User chats arr count: \(self.userChatsArr.count)")
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getUserProfiles()
        getUserChats()
    }

    func registerTableViewCell() {
        let chatTableViewCell = UINib.init(nibName: "ChatTableViewCell", bundle: nil)
        
        self.tableView.register(chatTableViewCell, forCellReuseIdentifier: "ChatTableViewCell")
    }
    
    func registerUserTableViewCell() {
        let userTableViewCell = UINib.init(nibName: "UserTableViewCell", bundle: nil)
        
        // since there is no interface for this unlike the ChatTableViewCell, we just give it a custom name
        // for the "forCellReuseIdentifier" field
        self.tableView.register(userTableViewCell, forCellReuseIdentifier: "UserTableViewCell")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.searchController?.isActive == true && self.searchController?.searchBar.text?.isEmpty == false {
            return self.filteredUsersArr.count
        }
        
        return self.userChatsArr.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.searchController?.isActive == true && self.searchController?.searchBar.text?.isEmpty == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
            
            cell.usernameLabel.text = self.filteredUsersArr[indexPath.row]
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell

        // Configure the cell...
        cell.chatNameLabel.text = self.userChatsArr[indexPath.row].chatName
        cell.chatDescriptionLabel.text = self.userChatsArr[indexPath.row].chatDescription

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.searchController?.isActive == true && self.searchController?.searchBar.text?.isEmpty == false {
            let cell = tableView.cellForRow(at: indexPath)
            
            if cell is UserTableViewCell {
                guard let chatViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else {
                    return
                }
                

                let username = self.filteredUsersArr[indexPath.row]
                print("username: \(username)")
                
                let indexOfUsername = self.usersArr.firstIndex(of: username)
                
                
                print("Username before: \(self.userIDArr[indexOfUsername!])")
                
                chatViewController.otherUserID = self.userIDArr[indexOfUsername!]
                chatViewController.hidesBottomBarWhenPushed = true
                
                self.searchController?.isActive = false
                
                self.navigationController?.pushViewController(chatViewController, animated: true)
            }
        }
    }
    
    
    public func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text?.lowercased() else {
            return
        }
        
        self.filteredUsersArr = self.usersArr.filter { username in
            return username.contains(searchText)
        }
        
        print("filtered array count: \(self.filteredUsersArr.count)")
        
        self.tableView.reloadData()

    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
