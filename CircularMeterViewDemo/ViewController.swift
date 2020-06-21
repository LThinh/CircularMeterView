//
//  ViewController.swift
//  CircularMeterViewDemo
//
//  Created by Thinh Le on 6/21/20.
//  Copyright © 2020 Thinh Le. All rights reserved.
//

import UIKit
import CircularMeterView

class ViewController: UIViewController {
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var meterView: CircularMeterView!
    
    private var currentValue: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meterView.delegate = self
        meterView.lineCap = .round
        meterView.updateValue(currentValue)
    }
    
    @IBAction func didTapChangeValueLabel(_ sender: Any) {
        let rand = Double.random(in: -100...100)
        currentValue += rand
        if currentValue >= 360 {
            currentValue = 360
        }
        if currentValue <= 0 {
            currentValue = 0
        }
        meterView.updateValue(currentValue)
    }
}

extension ViewController: CircularMeterViewDelegate {
    func meterView(_ view: CircularMeterView, changedValue value: Double) {
        let roundedValue = "\(Int(value))"
        valueLabel.text = roundedValue
    }
}
