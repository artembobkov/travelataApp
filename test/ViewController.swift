//
//  ViewController.swift
//  test
//
//  Created by Artem Bobkov on 27/09/2019.
//  Copyright © 2019 Artem Bobkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var dateFromTextField: UITextField!
    var dateToTextField = UITextField()
    
    
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTextField(textField: dateFromTextField)
       
    }
    
    func createTextField( textField:UITextField){
        textField.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
               
    }
    
    @objc func dateChanged(){
      getDateFromPicker()
        view.endEditing(true)
    
    
    }
    
    func getDateFromPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y"
        dateFromTextField.text = formatter.string(from: datePicker.date)
    }
    
    
    @IBOutlet weak var countAdultPassangers: UISlider!
    
    @IBOutlet weak var countKidsPassangers: UISlider!
    
    @IBOutlet weak var countInfantsPassangers: UISlider!
    

    
    
    
    @IBAction func GetRequest(_ sender: UIButton) {
        
        let adultPassangers = "touristGroup[adults]=\(Int(countAdultPassangers.value).description)"
        
        let kidsPassangers = "touristGroup[kids]=\(Int(countKidsPassangers.value).description)"
        
        let infantsPassangers = "touristGroup[infants]=\(Int(countInfantsPassangers.value).description)"

        
        guard let url = URL(string: "https://api-gateway.travelata.ru/statistic/cheapestTours?countries[]=92&departureCity=2&nightRange[from]=4&nightRange[to]=10&\(adultPassangers)&\(kidsPassangers)&\(infantsPassangers)&checkInDateRange[from]=2019-10-23&checkInDateRange[to]=2019-10-24") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
       
    }
    
    
    
    
    @IBAction func printInLog(_ sender: UIButton) {
        print("touristGroup[infants]=\(Int(countInfantsPassangers.value).description)")
        
        
      
        
    }
    


}

