//
//  MainTwoViewController.swift
//  Aqua Hydrate
//
//  Created by Varsha Balaji on 8/23/20.
//  Copyright © 2020 Varsha Balaji. All rights reserved.
//

import UIKit

class MainTwoViewController: UIViewController {

    @IBOutlet weak var InputTextField: UITextField!
    
    @IBOutlet weak var DateTextField: UITextField!
    
    @IBAction func AddItemButton(_ sender: Any) {
        
        if (InputTextField.text != "" || DateTextField.text != ""){
            
            list.append("\(InputTextField.text!) cups/ounces, \(DateTextField.text!)")
            //resetting the input field to nothing so that they can input new things
            InputTextField.text = ""
            DateTextField.text = ""
               }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
