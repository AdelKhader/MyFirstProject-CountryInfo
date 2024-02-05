//
//  ViewController.swift
//  MyFirstProject-CountryInfo
//
//  Created by Adel Khader on 29/01/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate=self
        countryAPI.delegate=self
        countryAPI.countryErrorDelegate=self
    }

    var countryAPI=CountryAPI()
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        updateUI()
    }
    
    @IBOutlet weak var lblNameCountry: UILabel!
    
    @IBOutlet weak var lblNameCapital: UILabel!
    
    @IBOutlet weak var lblRegionCountry: UILabel!
    
    
    @IBOutlet weak var lblPoplationCountry: UILabel!
    
    func updateUI(){
        countryAPI.fetchData(countryName: searchTextField.text!)
    }
    
    
}

extension ViewController : UITextFieldDelegate,countryAPIDelegate,countryError {
    
    func countryFind(errorText: String) {
        print(errorText)
        
        DispatchQueue.main.async {
           showAlertView()
       }
        
        func showAlertView(){
            let alert = UIAlertController(title: "Notification", message: errorText, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
            }
  }
    
    
    
    func DidRetrieveCountryInfo(country: Country) {
        print(country)

        
        DispatchQueue.main.async {
            
            
            if country.name?.common  == nil {
                self.lblNameCountry.text="Unkown Name"
            }else{
                self.lblNameCountry.text = ((country.name?.common)!) + " \(country.flag!)"
            }
            
            
            if country.capital?.first == nil {
                self.lblNameCapital.text="Unkown Capital"
            }else{
                self.lblNameCapital.text=country.capital?.first
            }
            
            if country.region==nil {
                self.lblRegionCountry.text="Unknown Region"
            }else{
                self.lblRegionCountry.text=country.region
            }
            
            if country.population == nil {
                self.lblPoplationCountry.text="Unkown"
            }else{
                self.lblPoplationCountry.text=String(country.population!)
            }
                
            
            
                }
            
     }
    
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateUI()
        return true
    }
    
    }
