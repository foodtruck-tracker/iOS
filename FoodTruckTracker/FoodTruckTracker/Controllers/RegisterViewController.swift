//
//  RegisterViewController.swift
//  FoodTruckTracker
//
//  Created by Lambda_School_Loaner_218 on 1/8/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    enum loginType {
        case signUp
        case login
    }
    
    let registerController = RegisterController()
    
    var logintype: loginType = .signUp
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var roleTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBAction func LoginSelector(_ sender: UISegmentedControl) {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    
    
    
    @IBAction func registerPressed(_ sender: Any) {
        
       guard let email = emailTextField.text,
        let password = passwordTextField.text,
        let role = roleTextField.text,
        let city = cityTextField.text else { return }
        let newUser = User(username: email, password: password, role: Int(role) ?? 2 , city: city)
        
        registerController.signUp(with: newUser) { (error) in
            if let error = error {
                print("Error for sign up:\(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
            self.performSegue(withIdentifier: "RegisterSegue", sender: self)
            }
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
