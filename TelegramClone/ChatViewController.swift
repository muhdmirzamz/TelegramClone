//
//  ChatViewController.swift
//  TelegramClone
//
//  Created by Muhd Mirza on 29/1/22.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textfield: UITextField!
    
    var testArr = ["Hello", "bye", "yoo"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.hidesBottomBarWhenPushed = true
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.textfield.becomeFirstResponder()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.testArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! UITableViewCell
        
        
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
