//
//  AddDataViewController.swift
//  KeyUnlock
//
//  Created by Refo Yudhanto on 5/2/20.
//  Copyright © 2020 Refo Yudhanto. All rights reserved.
//

import UIKit
import CoreData

class AddDataViewController: UIViewController {
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    @IBOutlet weak var passw: UITextField!
    @IBOutlet weak var weblink: UITextField!
    @IBOutlet weak var webname: UITextField!
    @IBOutlet weak var username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard));
        passw.isSecureTextEntry = true
            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        //view.addGestureRecognizer(tap)
            // Do any additional setup after loading the view.
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        }
        //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
            //Causes the view (or one of its embedded text fields) to resign the first responder status.
            view.endEditing(true)
    }
    
    @IBAction func save(_ sender: UIButton) {
        let name = webname.text!
        let pic = webname.text!.lowercased()+".jpeg"
        let uname = username.text!
        let password = passw.text!
        let link = weblink.text!
        addItem(name: name, picture: pic, uname: uname, passw: password, link: link)
        self.navigationController?.popViewController(animated:true);
    }
    
    func addItem(name:String, picture:String, uname:String, passw:String, link:String){
    let item = NSEntityDescription.insertNewObject(forEntityName:
    "Item", into: self.managedObjectContext)
    item.setValue(name, forKey: "name")
    item.setValue(picture, forKey: "icon")
    item.setValue(uname, forKey: "username")
    item.setValue(passw, forKey: "password")
    item.setValue(link, forKey: "website")
    self.appDelegate.saveContext() // In AppDelegate.swift
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
