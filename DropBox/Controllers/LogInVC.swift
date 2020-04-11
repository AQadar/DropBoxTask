//
//  LogInVC.swift
//  RewCap
//
//  Created by Abdul Qadar / Engr.aqadar@gmail.com on 01/1/2019.
//  Copyright © 2019 Abdul Qadar. All rights reserved.
//

import UIKit

class LogInVC: BaseVC {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblPassword: UILabel!
    
    @IBOutlet weak var btnSignIn: UIButton!
    
    typealias welcome = [WelcomeElement]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        self.setUpUI()
    }
    
    func setUpUI() {
        
        self.btnSignIn.setBtnUI()
        self.txtEmail.setField()
        self.txtPassword.setField()

    }
    
    //MARK: - IBActions
    
    @IBAction func btnActionForgotPassword(_ sender: UIButton) {
        
        self.showSwiftMessage(title: "info", message: "this functionality isnot defined yet!", type: "warning")
    }
    
    @IBAction func btnActionLogIn(_ sender: Any) {
        if isCheck() {
            
            self.apiCall()
            
        }
    }
    
    @IBAction func btnActionSignUp(_ sender: UIButton) {
        
        self.showSwiftMessage(title: "info", message: "this functionality isnot defined yet!", type: "warning")
        
    }
    
    //MARK: - Custom Functions

    
    func isCheck() -> Bool {
        
        let email               = self.txtEmail.text
        let password            = self.txtPassword.text

        
        if email == ""  {
           self.showSwiftMessage(title: "Error!", message: "Email address is invalid. Please try again.", type: "error")
            self.txtEmail.setRedField()
            self.lblEmail.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            return false
        }else if (!email!.isValidEmail) {
            self.showSwiftMessage(title: "Error!", message: "Email address is invalid. Please try again.", type: "error")
            self.txtEmail.setRedField()
            self.lblEmail.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            return false
        }
        
        if password == "" {
            self.showSwiftMessage(title: "Error!", message: "Password is required.", type: "error")
            self.txtPassword.setRedField()
            self.lblPassword.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            return false
        }
        
        return true
    }
    
    // MARK: - API Call

    func apiCall() {
        
        let jsonUrlString = "https://jsonplaceholder.typicode.com/users"
        guard let url = URL(string: jsonUrlString) else { return }
        let myEmail = self.txtEmail.text!
        self.showLoader()
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else {
                
                self.stopAnimating()
                self.showSwiftMessage(title: "Error", message: "No Data Found", type: "error")
                return
            }
            do {
                DispatchQueue.main.async {
                    self.stopAnimating()
                    let decoder = JSONDecoder()
                    let welcome = try! decoder.decode([WelcomeElement].self, from: data)
                    
                    if welcome[0].email != myEmail  {
                        
                        self.PushViewWithIdentifier(name: "DocumentVC")
                    }else {
                        self.showSwiftMessage(title: "Info", message: "This user \(myEmail) doesn't exists in our database!", type: "info")
                    }
                }
                
            }
            }.resume()
    }
}

extension LogInVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == txtEmail {
            
            self.txtEmail.setColorField()
            self.lblEmail.textColor = #colorLiteral(red: 0.2602886001, green: 0.7406979138, blue: 0.8698821068, alpha: 1)
            self.lblEmail.isHidden = false

            
            self.txtPassword.setField()
            self.lblPassword.isHidden = true

        }else {
            
            self.txtPassword.setColorField()
            self.lblPassword.textColor = #colorLiteral(red: 0.2602886001, green: 0.7406979138, blue: 0.8698821068, alpha: 1)
            self.lblPassword.isHidden = false

            
            self.txtEmail.setField()
            self.lblEmail.isHidden = true
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        if textField == txtEmail {

            self.txtEmail.setField()
            self.lblEmail.isHidden = true
            
        }else {
            
            self.txtPassword.setField()
            self.lblPassword.isHidden = true
            
        }
    }
}

extension LogInVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
