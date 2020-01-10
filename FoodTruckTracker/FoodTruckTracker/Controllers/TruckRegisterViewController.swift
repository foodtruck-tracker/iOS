//
//  TruckRegisterViewController.swift
//  FoodTruckTracker
//
//  Created by Lambda_School_Loaner_218 on 1/9/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

import UIKit

class TruckRegisterViewController: UIViewController {
    
    enum loginType {
        case signUp
        case login
    }
    
    let registerController = RegisterController()
    var logintype: loginType = .signUp
    
    
    
    @IBOutlet weak var signUpSlector: UISegmentedControl!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var truckNameTextField: UITextField!
    @IBOutlet weak var foodTypeTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var roleTextField: UITextField!
    
    
    @IBAction func segmentSelector(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            logintype = .signUp
            signUpButton.setTitle("Sign Up", for: .normal)
            
        case 1:
            logintype = .login
            signUpButton.setTitle("Log In", for: .normal)
            
        default:
            break
        }
    }
    
    
    @IBAction func SignUpPressed(_ sender: Any) {
        guard let username = usernameTextField.text,
            let password = passwordTextField.text,
            let role = roleTextField.text,
            let city = foodTypeTextField.text,
            let foodTruckName = truckNameTextField else { return }
        
        let newUser = User(username: username, password: password, role: Int(role) ?? 1 , city: city)
        
        registerController.signUp(with: newUser) { (error) in
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "RegisterSegue", sender: self)
            }
            
            if self.logintype == .signUp {
                self.registerController.signUp(with: newUser) { (error) in
                    if let error = error {
                        print("Error with signup : \(error)")
                    } else {
                        let alertControl = UIAlertController(title: "Signup Complete", message: "please Login", preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertControl.addAction(alertAction)
                        self.present(alertControl, animated: true) {
                            self.logintype = .signUp
                            self.signUpSlector.selectedSegmentIndex =  1
                            self.signUpButton.setTitle("Sign In", for: .normal)
                        }
                    }
                }
            } else {
                self.registerController.login(with: newUser) { (error) in
                    if let error = error {
                        print("Error logging in: \(error)")
                    } else {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
            
        }
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
