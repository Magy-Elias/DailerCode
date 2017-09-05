//
//  ViewController.swift
//  DailerTree
//
//  Created by Anirudha on 05/09/17.
//  Copyright © 2017 Anirudha Mahale. All rights reserved.
//

import UIKit

extension String {
    func getCharacterAt(_ index: Int) -> String? {
        if self.characters.count > index {
            let characterIndex = self.characters.index(self.startIndex, offsetBy: index)
            let character = self[characterIndex]
            return "\(character)"
        }
        return nil
    }
}

class ViewController: UIViewController {

    let phoneNumber = "+1 6489637892151"
    // let phoneNumber = "+919637892151"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let countryCode = parse(phoneNumber)
        print(countryCode)
    }
    
    func parse(_ number: String) -> String? {
        var countryCode = "+"
        if let json = readJson() {
            // Get the Number at Index 1
            if let firstNumber = number.getCharacterAt(1) {
                countryCode.append(firstNumber)
                if let jsonFirstNumber = json[firstNumber] as? [String: Any] {
                    print(countryCode)

                    // Get the Number at Index 2
                    if let secondNumber = number.getCharacterAt(2) {
                        countryCode.append(secondNumber)
                        if let jsonSecondNumber = jsonFirstNumber[secondNumber] as? [String: Any] {
                            print(countryCode)
                            if jsonSecondNumber["done"] as? Bool == true {
                                return countryCode
                            }
                            
                            // Get the Number at Index 3
                            if let thirdNumber = number.getCharacterAt(3) {
                                countryCode.append(thirdNumber)
                                if let thirdJsonNumber = jsonSecondNumber[thirdNumber] as? [String: Any] {
                                    print(countryCode)
                                    if thirdJsonNumber["done"] as? Bool == true {
                                        return countryCode
                                    }
                                    
                                    // Get the Number at Index 4
                                    if let fourthNumber = number.getCharacterAt(4) {
                                        countryCode.append(fourthNumber)
                                        if let jsonFourthNumber = thirdJsonNumber[fourthNumber] as? [String: Any] {
                                            print(countryCode)
                                            if jsonFourthNumber["done"] as? Bool == true {
                                                return countryCode
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            return countryCode
        }
        return nil
    }
    
    func readJson() -> [String: Any]? {
        if let fileUrl = Bundle.main.url(forResource: "DailerCodeTree", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let dictionary = json as! [String: Any]
                let plusDictionary = dictionary["+"] as! [String: Any]
                return plusDictionary
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
        print("File not found!")
        return nil
    }
}
