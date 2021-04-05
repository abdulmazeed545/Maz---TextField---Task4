//
//  ViewController.swift
//  Maz - TextField - Task3
//
//  Created by Shaik abdul mazeed on 25/01/21.
//  Copyright © 2021 Shaik abdul mazeed. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    //Creating and storing global variables
    
   
    @IBOutlet weak var maritalStatus: UISegmentedControl!
    @IBOutlet weak var sexSegment: UISegmentedControl!
    
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var age: UITextField!
    
    @IBOutlet weak var emailID: UITextField!
    
    @IBOutlet weak var mobile: UITextField!
    
    @IBOutlet weak var DOBField: UITextField!
    //Creating instance to date picker class
    let picker = UIDatePicker()
    var stringArr:[String] = []
    var imagesArr:[String] = ["age","email","phone","user"]
    var sexSegValue:String!
    var statusSegValue:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        //applying the delegates to textfields
        firstName.isFirstResponder
        firstName.delegate = self
        lastName.delegate = self
        age.delegate = self
        emailID.delegate = self
        mobile.delegate = self
        // creating a tap gesture to hide the keyboard when tap on the view
        var tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        view.addGestureRecognizer(tap)
        //Creating an instance for image
        let userImage = UIImage(named: imagesArr[3])!
        images(txtF: firstName, andImage: userImage)
        images(txtF: lastName, andImage: userImage)
        let ageImage = UIImage(named: imagesArr[0])!
        images(txtF: age, andImage: ageImage)
        let emailImage = UIImage(named: imagesArr[1])!
        images(txtF: emailID, andImage: emailImage)
        let phoneImage = UIImage(named: imagesArr[2])!
        images(txtF: mobile, andImage: phoneImage)
        //Calling function
        createDatePicker()
        
    }
    
    @IBAction func genderSegment(_ sender: Any) {
        //Condition for segment selection
        if (sexSegment.selectedSegmentIndex == 0)
        {
            sexSegment.selectedSegmentTintColor = .cyan
            //storing value in variable
            sexSegValue = "Male"
        }else if (sexSegment.selectedSegmentIndex == 1)
        {
            sexSegment.selectedSegmentTintColor = .cyan
            //storing value in variable
            sexSegValue = "Female"
        }
       
    }
    
    @IBAction func maritalStatusSegment(_ sender: Any) {
        
        //Condition for segment selection
        if (maritalStatus.selectedSegmentIndex == 0)
        {
            maritalStatus.selectedSegmentTintColor = .green
            //storing value in variable
            statusSegValue = "Married"
        }else if (maritalStatus.selectedSegmentIndex == 1)
        {
            maritalStatus.selectedSegmentTintColor = .green
            //storing value in variable
            statusSegValue = "Single"
        }
    }
    //Creating a function for date picker component
    func createDatePicker()
    {
        //Creating an instance to the tool bar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Done button for tool bar
        let submit = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(submitPressed))
        toolBar.setItems([submit], animated: false)
        DOBField.inputAccessoryView = toolBar
        picker.maximumDate = Date()
        picker.backgroundColor = .orange
        DOBField.inputView = picker
        
        //Formatting picker for date
        picker.datePickerMode = .date
    }
    @objc func submitPressed()
    {
        //Formatting date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: picker.date)
        
        DOBField.text = "\(dateString)"
        view.endEditing(true)
    }
    //Creating a function for to display images in textfields
    func images(txtF: UITextField, andImage img: UIImage)
    {
        //Creating a imageview to display images in textfields
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imgView.image = img
        imgView.contentMode = .scaleAspectFill
        txtF.leftView = imgView
        txtF.leftViewMode = .always
    }
    //Creating a function for tap action
    @objc func tapAction()
    {
        view.endEditing(true)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing")
        //creating a variable for returning the value
        var returns:Bool = false
        //Condtions when textfield should begins editing
        if(textField == firstName)
        {
            returns = true
        }else if (textField == lastName)
        {
            if (firstName.text!.count > 0)
            {
                returns = true
            }else
            {
                returns = false
                
            }
        }else if(textField == age)
        {
            if (firstName.text!.count > 0 && lastName.text!.count > 0)
            {
                returns = true
            }else
            {
                returns = false
                
            }
            
        }else if(textField == emailID)
        {
            if (firstName.text!.count > 0 && lastName.text!.count > 0 && age.text!.count > 0)
            {
                if(Int(age.text!)! > 5 && Int(age.text!)! <= 120)
                {
                    
                    returns = true
                }else
                {
                    returns = false
                }
                    
            }else
            {
                returns = false
                
            }
            
        }else if(textField == mobile)
        {
            if (firstName.text!.count > 0 && lastName.text!.count > 0 && age.text!.count > 0 && emailID.text!.count > 7)
            {
                returns = true
            }else
            {
                returns = false
                
            }
        }else if (textField == DOBField)
        {
            if (firstName.text!.count > 0 && lastName.text!.count > 0 && age.text!.count > 0 && emailID.text!.count > 7 && mobile.text!.count == 10)
            {
                returns = true
            }else
            {
                returns = false
                
            }
            
        }
        return returns
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        var returns:Bool = true
        if (textField == firstName)
        {
            if(firstName.text!.count >= 3)
            {
                returns = true
            }else
            {
                returns = false
            }
        }else if(textField == lastName)
        {
            if(lastName.text!.count >= 3)
            {
                returns = true
            }else
            {
                returns = false
                    
            }
        }else if (textField == emailID)
        {
            return isValidEmail(textField.text!)
        }else if (textField == mobile)
        {
            return isValidNum(value: textField.text!)
        }
        return returns
        
    }
    //Creating a function for email validation
    func isValidEmail(_ email: String) -> Bool {
        
        //Creating a constant for regular expression
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    //Creating a function for mobile number validation
    func isValidNum(value: String) -> Bool {
        //Creating a constant for regular expression
        let PHONE_REGEX = "^[6-9]{1}[0-9]{9}$";
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //setting the text field color when editing begins
        textField.backgroundColor = .magenta

    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        if(firstName.text!.count > 0 && lastName.text!.count > 0 && age.text!.count > 0 && emailID.text!.count > 0 && mobile.text!.count == 10 && DOBField.inputView == picker)
        {
               //enabling the save button
                save.isEnabled = true
        }

        //setting the textfield color white after editing completed
        textField.backgroundColor = .white
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == ""
        {
            return true
        }
        if (textField == firstName || textField == lastName)
        {
            //creating a constant for character set for only letters
            let allowCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            return allowCharacters.isSuperset(of: characterSet)
            
        }
        else if (textField == age)
        {
            if (age.text!.count >= 0 && age.text!.count <= 1)
            {
                //Calling characterset function
                self.characterSet(string: string)
            }
            if (age.text!.count == 2)
            {
                //Creating a constant for characterset
                let allow = CharacterSet(charactersIn: "+#*123456789").inverted
                if (string.rangeOfCharacter(from: allow) != nil)
                {
                    return true
                }else
                {
                    return false
                }
            }
            if (age.text!.count > 2)
            {
                //Creating a constant for characterset
                let allow = CharacterSet(charactersIn: "#*+0123456789").inverted
                if (string.rangeOfCharacter(from: allow) != nil)
                {
                    return true
                }else
                {
                    return false
                }
            }
            
            
        }else if (textField == mobile)
        {
            if (mobile.text!.count == 0)
            {
                //Creating a constant for characterset
                let allow = CharacterSet(charactersIn: "012345").inverted
                if (string.rangeOfCharacter(from: allow) != nil)
                {
                    return true
                }else
                {
                    return false
                }
                //Calling characterset function
                self.characterSet(string: string)
            }
            if (mobile.text!.count > 0 && mobile.text!.count <= 9)
            {
                //Calling characterset function
                self.characterSet(string: string)
            }
            if (mobile.text!.count > 9)
            {
                //Creating a constant for characterset
                let allow = CharacterSet(charactersIn: "0123456789+").inverted
                if (string.rangeOfCharacter(from: allow) != nil)
                {
                    return true
                }else
                {
                    return false
                }
            }
        }
        return true
    }
    let allowCharDigits = CharacterSet.decimalDigits
    //Creating a function for characterset
    func characterSet(string: String) -> Bool
    {
        //Creating a constant for characterset
        let allowCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowCharacters.isSuperset(of: characterSet)
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("textFieldShouldClear")
        return true
    }
    //using the delegate method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //calling resignFirstResponder method to hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    //Creating a function to save data using button
    @IBAction func saveData(_ sender: Any) {
        
        
        //Condition to check all the text fields data count is morethan zero or not
        if(firstName.text!.count > 2 && lastName.text!.count > 2 && age.text!.count > 0 && emailID.text!.count > 0 && mobile.text!.count == 10 && DOBField.text!.count > 0)
        {
            if (sexSegValue != nil && statusSegValue != nil)
            {
                //Appending the values into an array
                stringArr.append("     Personal Details       ")
                //Appending the text fields data into an array
                stringArr.append("First Name: \(firstName.text!)")
                stringArr.append("Last Name: \(lastName.text!)")
                stringArr.append("AGE: \(age.text!)")
                stringArr.append("Email-ID: \(emailID.text!)")
                stringArr.append("Mobile: \(mobile.text!)")
                stringArr.append("SEX: \(sexSegValue!)")
                stringArr.append("Maital Status: \(statusSegValue!)")
                stringArr.append("DOB: \(DOBField.text!)")
            }
        }
        //clearing the textfields data after button pressed
        firstName.text = nil
        lastName.text = nil
        age.text = nil
        emailID.text = nil
        mobile.text = nil
        DOBField.text = nil
        //Setting segment tintcolor to segment background color
        sexSegment.selectedSegmentTintColor = UIColor.systemRed
        maritalStatus.selectedSegmentTintColor = UIColor.systemRed

        //Disabling the save button after submission
        save.isEnabled = false
    }
    //Creating  a function for button action
    @IBAction func nextVC(_ sender: Any) {
        //Creating an instance to the MazeedViewController Class
        let mazVC = storyboard?.instantiateViewController(identifier: "mazeed") as! MazeedViewController
        mazVC.modalPresentationStyle = .fullScreen
        //present method to display the data into next viewcontroller
        present(mazVC, animated: true) {
            //Creating a variable
            var a = 0
           //For loop to display stored user data
           for i in 0..<self.stringArr.count
            {
                //Creating an instance to the textview to display stored data
                mazVC.textView = UITextView()
                mazVC.textView.frame = CGRect(x: 30, y: 50+35*a, width: 300, height: 35)
                mazVC.textView.text = self.stringArr[i]
                mazVC.textView.isEditable = false
                mazVC.textView.font = UIFont(name: "ArialRoundedMTBold", size: 15)
                mazVC.textView.backgroundColor = UIColor.cyan
                mazVC.textView.clipsToBounds = true
                mazVC.textView.textAlignment = .center
                //Setting the content size for textview
                mazVC.scTextView.contentSize = CGSize(width: mazVC.view.frame.size.width, height: mazVC.textView.frame.maxY)
                mazVC.scTextView.addSubview(mazVC.textView)
                if (i%9 == 0)
                {
                    mazVC.textView.backgroundColor = UIColor.systemFill
                    mazVC.textView.textColor = .blue
                }
                //Dividing i value at 6 to get spaces
                if (i%9 == 8)
                {
                    //Incrementing the a value
                    a += 1
                }
            //Incrementing the a value
            a += 1
            }
            
            
            
        }
        
    }
    
}

