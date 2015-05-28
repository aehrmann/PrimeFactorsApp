//
//  HomeViewController.swift
//  PrimeFactorsApp
//
//  Created by Ariel Ehrmann on 5/27/15.
//  Copyright (c) 2015 AriAndLisa. All rights reserved.
//

import Foundation
import UIKit

public class MainViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var factorsTableView: UITableView!

    public var generator: FactorsGenerator?
    public var generatedFactors: [Int]?
    let textCellIdentifier = "TextCell"

    override public func viewDidLoad() {
        super.viewDidLoad()
        generator = PrimeFactorsGenerator()
    }

    @IBAction func submitNumberInput() {
        var inputString = numberTextField.text
        var inputAsInteger = inputString.toInt()
        generatedFactors = generator!.generate(inputAsInteger!)
    }

    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return generatedFactors!.count
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell

        let row = indexPath.row
        var cellValue = String(generatedFactors![row])
        cell.textLabel?.text = cellValue
        
        return cell
    }

}