//
//  ViewController.swift
//  test
//
//  Created by Artem Bobkov on 27/09/2019.
//  Copyright © 2019 Artem Bobkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var dateToTextField: UITextField!
    @IBOutlet weak var dateFromTextField: UITextField!
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        
    }
    
    func createDatePicker(){
        dateFromTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(getDateFromPicker))
        self.view.addGestureRecognizer(tapGesture)
    }
 
    @objc func getDateFromPicker(_ dateField:UITextField){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        dateFromTextField.text = formatter.string(from: datePicker.date)
        view.endEditing(true)

    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var countAdultPassangers: UISlider!
    @IBOutlet weak var countKidsPassangers: UISlider!
    @IBOutlet weak var countInfantsPassangers: UISlider!
    @IBOutlet weak var minimumNightSlider: UISlider!
    @IBOutlet weak var maximumNightSlider: UISlider!
    
    // MARK: - GetRequest
    
    @IBAction func GetRequest(_ sender: UIButton) {
        
        let adultPassangers = "touristGroup[adults]=\(Int(countAdultPassangers.value))"
        
        let kidsPassangers = "touristGroup[kids]=\(Int(countKidsPassangers.value))"
        
        let infantsPassangers = "touristGroup[infants]=\(Int(countInfantsPassangers.value).description)"

        let minimumNight = "nightRange[from]=\(Int(minimumNightSlider.value))"
        
        let maximumNight = "nightRange[to]=\(Int(maximumNightSlider.value))"
        
        guard let url = URL(string: "https://api-gateway.travelata.ru/statistic/cheapestTours?countries[]=92&departureCity=2&\(minimumNight)&\(maximumNight)&\(adultPassangers)&\(kidsPassangers)&\(infantsPassangers)&checkInDateRange[from]=2019-10-23&checkInDateRange[to]=2019-10-24") else { return }
        
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
        print("touristGroup[infants]=\(Int(countInfantsPassangers.value))")
            print("touristGroup[kids]=\(Int(countKidsPassangers.value))")
        print("touristGroup[adults]=\(Int(countAdultPassangers.value))")
            print("nightRange[from]=\(Int(minimumNightSlider.value))")
            print("nightRange[to]=\(Int(maximumNightSlider.value))")
        
        
      
        
    }
    


}

