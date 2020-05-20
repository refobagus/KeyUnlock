//
//  TableViewController.swift
//  KeyUnlock
//
//  Created by Refo Yudhanto on 5/2/20.
//  Copyright © 2020 Refo Yudhanto. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    var dataitems: [NSManagedObject] = []
    var selectedRow: Int = 0
    var key: Int = 0
    var iv: Int = 0
    var passw: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.tableView.rowHeight = 60
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.backgroundView = nil;
        self.tableView.backgroundColor = .darkGray
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        datainsertoverride(counter: 0)
        datainsertoverride(counter: 1)
        datainsertoverride(counter: 2)
        dataitems = getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar on the this view controller
        dataitems = getData()
        tableView.reloadData()
    }
    func datainsertoverride(counter:Int){
        let webNameArr = ["Facebook", "Twitter", "Google"]
        let webLinkArr = ["Facebook.com", "Twitter.com", "Google.com"]
        let name: String = webNameArr[counter]
        let pic = name.lowercased()+".jpeg"
        let uname = "spongebob"
        let passw = "patrick"
        let link: String = webLinkArr[counter]
        let data = addItem(name: name, picture: pic, uname: uname, passw: passw, link: link)
        dataitems.append(data)
        tableView.reloadData()
    }
    func addItem(name:String, picture:String, uname:String, passw:String, link:String)-> NSManagedObject {
    let item = NSEntityDescription.insertNewObject(forEntityName:
    "Item", into: self.managedObjectContext)
    item.setValue(name, forKey: "name")
    item.setValue(picture, forKey: "icon")
    item.setValue(uname, forKey: "username")
    item.setValue(passw, forKey: "password")
    item.setValue(link, forKey: "website")
    self.appDelegate.saveContext() // In AppDelegate.swift
    return item
    }
    // MARK: - Table view data source
    func getData() -> [NSManagedObject]{
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Item")
        var items: [NSManagedObject]!
        
        do {
        items = try self.managedObjectContext.fetch(fetchRequest) }
        catch {
        print("getData error: \(error)")
            
        }
        return items
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataitems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "websiteCell", for: indexPath) as! WebsiteCell
        
        let row = indexPath.row
        let name = dataitems[row]
        cell.webName?.text = name.value(forKey: "name") as? String
        let pic = name.value(forKey: "icon") as? String
        cell.webPic?.image = UIImage(named: pic!)

        return cell
    }
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
    // Delete the row from the data source first
        let row = indexPath.row
        let data = dataitems[row]
        dataitems.remove(at: row)
        removeItem(data)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    } }
    func removeItem(_ item:NSManagedObject) {
        managedObjectContext.delete(item)
        appDelegate.saveContext()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row // retain for prepareForSegue
        performSegue(withIdentifier: "infosegue", sender: nil);
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "infosegue") {
            let whichdata = segue.destination as! DataInfoViewController;
            whichdata.num = self.selectedRow;
            whichdata.pass = passw;
        }
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
