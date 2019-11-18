//
//  BMIVC.swift
//  BMI Calculator
//
//  Created by Sindhu Gudivada on 10/21/19.
//  Copyright © 2019 abc. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

class BMIVC: UIViewController {

    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var widthTextField: UITextField!
    @IBOutlet weak var bmiApiButton: UIButton!
    @IBOutlet weak var educateMeButton: UIButton!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!

    var finalResult = Bmi(value: 0.0, message: "", links: [])
    var weight: Double = 0.0
    var height: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        bmiApiButton.addTarget(self, action: #selector(bmiButtonPressed), for: .touchUpInside)
        educateMeButton.addTarget(self, action: #selector(educateMeButtonPressed), for: .touchUpInside)
    }

    private func calculateBMI() {
       let params: [String: Any] = ["height": self.height, "weight": self.weight]
       let data = "http://webstrar99.fulton.asu.edu/page3/Service1.svc/calculateBMI"
       Alamofire.request(data, method: .get, parameters: params).responseJSON { (response) in
            if let responseValue = response.result.value as! [String: Any]? {
                if let bmi = responseValue["bmi"] as! Double? {
                    self.finalResult.value = bmi
                    self.bmiLabel.text = "\(self.finalResult.value)"
                }
                if let educateArray = responseValue["more"] as! [String]? {
                    for link in educateArray {
                        self.finalResult.links.append(link)
                }
                if let risk = responseValue["risk"] as! String? {
                    self.finalResult.message = risk
                    self.messageLabel.text = "\(self.finalResult.message)"
                }
            }
            }
        }
    }

    @objc func bmiButtonPressed() {
        if let height = Double(heightTextField.text!) {
            self.height = height
        }
        if let weight = Double(widthTextField.text!) {
            self.weight = weight
        }
        calculateBMI()
    }

    @objc func educateMeButtonPressed() {
        let url  = self.finalResult.links.first ?? "https://www.google.com"
        let VC = WebViewVC(urlString: url)
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
