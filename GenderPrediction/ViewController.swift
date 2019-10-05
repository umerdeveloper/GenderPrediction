//  ViewController.swift
//  GenderPrediction
//
//  Created by Umer Khan on 05/10/2019.
//  Copyright © 2019 Umer Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
    }
    
    func predictGenderFromName(_ name: String) -> String? {
        let featureName = feature(name)
        
        let model = GenderByName()
        if let prediction = try? model.prediction(input: featureName) {
            if prediction.classLabel == "F" {
                return "Female"
            } else { return "Male" }
        }
        return nil
    }
    
    // Supporting Function
    func feature(_ string: String) -> [String: Double] {
        guard !string.isEmpty else { return [:] }
        
        let string = string.lowercased()
        var keys = [String]()
        
        keys.append("FirstLetter1 = (\(string.prefix(1))")
        keys.append("FirstLetter2 = (\(string.prefix(2))")
        keys.append("FirstLetter3 = (\(string.prefix(3))")
        keys.append("FirstLetter1 = (\(string.suffix(1))")
        keys.append("FirstLetter2 = (\(string.suffix(2))")
        keys.append("FirstLetter3 = (\(string.suffix(3))")
        
        return keys.reduce([String: Double]()) { (result, key) -> [String: Double] in
            var result = result
            result[key] = 1.0
            return result
        }
    }
    
    // MARK: - TextField Delegate method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        genderLabel.text = predictGenderFromName(textField.text!)
        return true
    }
}

