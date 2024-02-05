//
//  CountryAPI.swift
//  MyFirstProject-CountryInfo
//
//  Created by Adel Khader on 03/02/2024.
//

import Foundation

// 1. Create URL
// 2. Create URL Session
// 3. Create a task
// 4. Start / Resume the task

protocol countryAPIDelegate{
    func DidRetrieveCountryInfo(country : Country)
}

protocol countryError {
    func countryFind(errorText : String)
}

class CountryAPI {
    
    var delegate:countryAPIDelegate?
    var countryErrorDelegate:countryError?
   
    
    
    let urlBaseString="https://restcountries.com/v3.1/name/"
    
    func fetchData(countryName : String){
        let urlString="\(urlBaseString)\(countryName)"
    
        // 1. create URL
        let url=URL(string: urlString)!
        
        // 2. create URL session   - allows developers to send and receive data from the web
        let session=URLSession(configuration: .default)
        
        // 3. create Task - Creates a task that retrieves the contents of a URL based on the specified URL request object, and calls a handler upon completion
        
        let task=session.dataTask(with: url, completionHandler: taskHandler(data:urlResponse:error:))
        
        //4. Start / resum - you need to call this method to start the task.
        task.resume()
    }
    
    func taskHandler(data : Data? , urlResponse : URLResponse? , error : Error?)->Void{
        
        do {
            let countries = try JSONDecoder().decode([Country].self, from: data!)
            // Access the decoded data here
            
            let firstCountry=countries[0]
           delegate?.DidRetrieveCountryInfo(country: firstCountry)
            print(firstCountry.flag!)
         
        } catch {
            print("** Error decoding JSON : \(error)")
            
            let errorMsg = "Maybe This Country Does Not Exist Or The Writing Format Is Not Correct !"
            countryErrorDelegate?.countryFind(errorText: errorMsg)
        }
        

}
    
    }
