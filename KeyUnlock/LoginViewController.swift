//
//  LoginViewController.swift
//  KeyUnlock
//
//  Created by Refo Yudhanto on 5/2/20.
//  Copyright © 2020 Refo Yudhanto. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var lgnBtn: UIButton!
    @IBOutlet weak var textfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lgnBtn.layer.cornerRadius = 4
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard));
        textfield.isSecureTextEntry = true
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        //view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    //Calls this function when the tap is recognized.
    @IBAction func move(_ sender: UIButton) {
        performSegue(withIdentifier: "getin", sender: nil);
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "getin") {
            let whichdata = segue.destination as! TableViewController;
            whichdata.passw = (textfield.text ?? "")
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
