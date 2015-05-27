//
//  FactorsGenerator.swift
//  PrimeFactorsApp
//
//  Created by Ariel Ehrmann on 5/27/15.
//  Copyright (c) 2015 AriAndLisa. All rights reserved.
//

import Foundation

protocol FactorsGenerator {
    func generate(number: Int) -> [Int]
}