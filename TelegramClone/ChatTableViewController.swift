//
//  ChatTableViewController.swift
//  TelegramClone
//
//  Created by Muhd Mirza on 31/12/21.
//

import UIKit

import FirebaseAuth
import FirebaseDatabase

class ChatTableViewController: UITableViewController, UISearchResultsUpdating {

    var searchController: UISearchController?
    
//    var filteredItemsArray = []()
    
    var randomArr = ["Hello", "Bye", "Yo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.registerTableViewCell()
        
        self.searchController = UISearchController.init(searchResultsController: nil)
        self.searchController?.searchResultsUpdater = self
        
//        self.searchController?.dimsBackgroundDuringPresentation = false
        self.searchController?.definesPresentationContext = true
        self.tableView.tableHeaderView = self.searchController?.searchBar
    }

    func registerTableViewCell() {
        let chatTableViewCell = UINib.init(nibName: "ChatTableViewCell", bundle: nil)
        
        self.tableView.register(chatTableViewCell, forCellReuseIdentifier: "ChatTableViewCell")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.randomArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell") as? ChatTableViewCell {
//            return cell
//        }

        // Configure the cell...

        return cell
    }
    
    
    public func updateSearchResults(for searchController: UISearchController) {
        
        let ref = Database.database().reference()
//        let userID = Auth.auth().currentUser?.uid
        
        ref.child("/profile").observeSingleEvent(of: .value) { (snapshot) in
            
//            print("\(snapshot)")
            
            if let profilesDict = snapshot.value as? Dictionary<String, Any> {
                
                print("\(profilesDict)")
                
                for profile in profilesDict {
                    
                    if let profileObj = profile.value as? Dictionary<String, Any> {
                        guard let username = profileObj["username"] as? String else {
                            return
                        }
                        
                        print(username)
                    }
                    
                }
                
//                for i in listsDict {
//
//                    let list = List()
//
//                    list.key = i.key
//
//
//                    if let listNameDict = i.value as? Dictionary<String, Any> {
//
//                        guard let listName = listNameDict["listName"] as? String else {
//                            return
//                        }
//
//                        list.listName = listName
//
//                        guard let timestamp = listNameDict["timestamp"] as? String else {
//                            return
//                        }
//
//                        list.timestamp = timestamp
//
//                        self.listArray.append(list)
//                    }
//                }
            }
            
//            self.listArray.sort(by: {$0.timestamp! > $1.timestamp!})
            
//            self.tableView.reloadData()
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
//        self.filteredItemsArray = self.itemsArray.filter{items in
//            let convertedItems = items as? Item
//
//            let convertedItemName = (convertedItems?.name?.lowercased())!
//
//            return (convertedItemName.contains(searchController.searchBar.text!.lowercased()))
//        }
//
//
//        self.tableView.reloadData()
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
