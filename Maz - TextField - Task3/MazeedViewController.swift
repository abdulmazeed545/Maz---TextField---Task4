//
//  MazeedViewController.swift
//  Maz - TextField - Task3
//
//  Created by Shaik abdul mazeed on 25/01/21.
//  Copyright © 2021 Shaik abdul mazeed. All rights reserved.
//

import UIKit

class MazeedViewController: UIViewController {
    //Creating global variables
    var scTextView  = UITextView()
    var textView:UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Calling function
        create()
        // Do any additional setup after loading the view.
    }
    //Creating a function
    func create(){
        //setting the textview frame
        scTextView.frame = CGRect(x: 0, y: 200, width: view.frame.size.width, height: view.frame.size.height)
        
        view.addSubview(scTextView)
    }
    //creating a function to dismiss the viewcontroller screen
    @IBAction func dismiss(_ sender: Any) {
        
        
        dismiss(animated: true , completion: nil)
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
