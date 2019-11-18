//
//  Bmi.swift
//  BMI Calculator
//
//  Created by Sindhu Gudivada on 10/21/19.
//  Copyright © 2019 abc. All rights reserved.
//

import Foundation

class Bmi {
    var value: Double
    var message: String
    var links: [String]

    init(value: Double, message: String, links: [String]) {
        self.value = value
        self.message = message
        self.links = links
    }
}
