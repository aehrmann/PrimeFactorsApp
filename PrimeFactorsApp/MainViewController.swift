//
//  HomeViewController.swift
//  PrimeFactorsApp
//
//  Created by Ariel Ehrmann on 5/27/15.
//  Copyright (c) 2015 AriAndLisa. All rights reserved.
//

import Foundation
import UIKit

public class MainViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var generateButton: UIButton!

    public var generator: FactorsGenerator?
    public var generatedFactors: [Int]?

    override public func viewDidLoad() {
        super.viewDidLoad()
        generator = PrimeFactorsGenerator()
    }

    @IBAction func submitNumberInput() {
        generatedFactors = generator!.generate(1)
    }

}