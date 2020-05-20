//
//  DataInfoViewController.swift
//  KeyUnlock
//
//  Created by Refo Yudhanto on 5/2/20.
//  Copyright © 2020 Refo Yudhanto. All rights reserved.
//

import UIKit
import CoreData
import CryptoKit

class DataInfoViewController: UIViewController {
    var dataitems: [NSManagedObject] = []
    var num:Int = 0
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var weblink: UILabel!
    @IBOutlet weak var passw: UILabel!
    @IBOutlet weak var uname: UILabel!
    @IBOutlet weak var webname: UILabel!
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    var pass=""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        dataitems = getData()
        validaction(password: pass)
        // Do any additional setup after loading the view.
    }
    func validaction(password:String){
        let item = dataitems[num]
        if password == "r4mpage"{
            webname.text = item.value(forKey: "name") as? String
            let pic = item.value(forKey: "icon") as? String
            icon.image = UIImage(named: pic!)
            let username = item.value(forKey: "username") as? String
            let usernamed = dencrypt(text: username ?? "")
            uname.text = usernamed
            let password = item.value(forKey: "password") as? String
            let passwordd = dencrypt(text: password ?? "")
            passw.text = passwordd
            let link = item.value(forKey: "website") as? String
            weblink.text = link
        }
        else{
            webname.text = item.value(forKey: "name") as? String
            let pic = item.value(forKey: "icon") as? String
            icon.image = UIImage(named: pic!)
            uname.text = "Wrong password"
            passw.text = "Wrong password"
            let link = item.value(forKey: "website") as? String
            weblink.text = link
        }
    }
    func dencrypt(text:String) -> String{
        let message = text.data(using: .utf8)!
        let key1 = CryptoKit.SymmetricKey(size: .bits256)
        let nonce1 = CryptoKit.AES.GCM.Nonce()
        // Encrypt the data
        let encrypted1 = try! CryptoKit.AES.GCM.seal(message, using: key1, nonce: nonce1)
        let comb = encrypted1.combined!
        // Decrypt the data
        let box1 = try! CryptoKit.AES.GCM.SealedBox(combined: comb)
        let decrypted1 = try! CryptoKit.AES.GCM.open(box1, using: key1)
        let decryptedString = String(data: decrypted1, encoding: .utf8)!
        return decryptedString
     }

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
