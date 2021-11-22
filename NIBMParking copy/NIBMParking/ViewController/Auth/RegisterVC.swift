//
//  RegisterVC.swift
//  PASAN_EDIRISOORIYA-COBSCCOMP192P-011
//
//  Created by Pasan Induwara Edirisooriya on 3/2/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterVC: BaseVC {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtNICNo: UITextField!
    @IBOutlet weak var txtVehicleNo: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTappedOnRegister(_ sender: Any) {
        do {
            if try validateForm() {
                startLoading()
                registerUser()
            }
        } catch ValidateError.invalidData(let message) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        } catch {
            let alert = UIAlertController(title: "Error", message: "Missing Data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func didTappedOnLogin(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func registerUser(){ 
        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { authResult, error in
            if let user = authResult?.user {
                
                LocalUser.saveLoginData(user: UserModal(id: user.uid, avatarUrl: user.photoURL?.absoluteString ?? "", nic: self.txtNICNo.text!, vehicleNo: self.txtVehicleNo.text ?? "" , email: user.email ?? ""))
                let userAttrs = ["nic_no": self.txtNICNo.text!,"vehicle_no": self.txtVehicleNo.text!]
                
                let ref = Database.database().reference().child(user.uid)
                ref.setValue(userAttrs) { (error, ref) in
                    self.stopLoading()
                    if let error = error {
                        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                    }else{
                        let nc = UIStoryboard.init(name: "TabBar", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarVC")
                        self.resetWindow(with: nc)
                    }
                }
            }else if let error = error {
                self.stopLoading()
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    
    //MARK: Validate Login User
    func validateSignUpUser(completion: (_ status: Bool, _ message: String) -> ()) {
        do {
            if try validateForm() {
                completion(true, "Success")
            }
        } catch ValidateError.invalidData(let message) {
            completion(false, message)
        } catch {
            completion(false, "Missing Data")
        }
    }
    
    func validateForm() throws -> Bool {
        guard (txtEmail.text != nil), let value = txtEmail.text else {
            throw ValidateError.invalidData("Invalid Email")
        }
        guard !(value.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
            throw ValidateError.invalidData("Email Empty")
        }
        guard isValidEmailAddress(email: value) else {
            throw ValidateError.invalidData("Invalid Email")
        }
        guard (txtNICNo.text != nil), let nic = txtNICNo.text else {
            throw ValidateError.invalidData("NIC Empty")
        }
        guard !(nic.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
            throw ValidateError.invalidData("Phone number Empty")
        }
        
        guard (txtVehicleNo.text != nil), let vehicleNo = txtVehicleNo.text else {
            throw ValidateError.invalidData("Vehicle No Empty")
        }
        guard !(vehicleNo.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
            throw ValidateError.invalidData("Vehicle No Empty")
        }
        
        guard !((txtPassword.text ?? "").isEmpty) else {
            throw ValidateError.invalidData("Passoword is Empty")
        }
        
        return true
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


