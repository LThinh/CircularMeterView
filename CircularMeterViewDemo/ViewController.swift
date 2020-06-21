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
    private var circularMeterView: CircularMeterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meterView.delegate = self
        meterView.lineCap = .round
        meterView.updateValue(currentValue)
        
        let frame = CGRect(x: 50, y: 50, width: 200, height: 200)
        circularMeterView = CircularMeterView(frame: frame)
        circularMeterView.animationDuration = 2
        circularMeterView.animationStyle = .easeIn
        circularMeterView.lineCap = .square
        
        circularMeterView.maxValue = 100
        circularMeterView.startAngle = 0
        circularMeterView.endAngle = 180
        circularMeterView.lowerCircleWidth = 10
        circularMeterView.lowerColor = .darkGray
        circularMeterView.upperCircleWidth = 12
        circularMeterView.upperColor = .yellow
        circularMeterView.radiusShadow = 10
        circularMeterView.offsetShadow = .zero
        circularMeterView.colorShadow = .black
        view.addSubview(circularMeterView)
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
        circularMeterView.updateValue(50)
    }
}

extension ViewController: CircularMeterViewDelegate {
    func meterView(_ view: CircularMeterView, changedValue value: Double) {
        let roundedValue = "\(Int(value))"
        valueLabel.text = roundedValue
    }
}
