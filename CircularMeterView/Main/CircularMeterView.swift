//
//  CircularMeterView.swift
//  CircularMeterView
//
//  Created by Thinh Le on 6/21/20.
//  Copyright © 2020 Thinh Le. All rights reserved.
//

import Foundation
import UIKit

protocol CircularMeterViewDelegate: class {
    func meterView(_ view: CircularMeterView, changedValue value: Double)
}

class CircularMeterView: UIView {
    private enum Direction {
        case none
        case backward
        case forward
    }
    
    @IBInspectable var maxValue: Double = 360
    @IBInspectable private(set) var currentValue: Double = 180
    
    @IBInspectable var lowerLineWidth: CGFloat = 8
    @IBInspectable var lowerColor: UIColor = .gray
    
    @IBInspectable var upperLineWidth: CGFloat = 10
    @IBInspectable var upperColor: UIColor = .green
    
    @IBInspectable var colorShadow: UIColor = .black
    @IBInspectable var radiusShadow: CGFloat = 0
    @IBInspectable var offsetShadow: CGSize = .zero
    
    private var radius: CGFloat = 0
    private var direction: Direction = .none
    private var firstLoad = true
    
    private var upperCircleLayer = CAShapeLayer()
    
    private var timer: Timer?
    private let bottomRadians: CGFloat = 0.5 * .pi
    private let startRadians: CGFloat = 0.75 * .pi
    private var endRadians: CGFloat = 0.25 * .pi
    private var centerPoint: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    var animationDuration: Double = 1
    var animationStyle: CAMediaTimingFunctionName = .linear
    
    weak var delegate: CircularMeterViewDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if firstLoad {
            setupInitialState()
            firstLoad = false
        }
    }
    
    func updateValue(_ newValue: Double) {
        guard newValue >= 0 else { return }
        let strokeEnd = upperCircleLayer.presentation()?.strokeEnd ?? 1
        switch direction {
        case .none:
            animateUpperCircle(fromValue: currentValue, toValue: newValue)
        case .backward, .forward:
            let currentValue = Double(strokeEnd) * maxValue
            animateUpperCircle(fromValue: currentValue, toValue: newValue)
        }
        resumeReporter()
        currentValue = newValue
    }
    
    override func draw(_ rect: CGRect) {
        // Lower Line
        let lowerLinePath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: startRadians, endAngle: endRadians, clockwise: true)
        lowerLinePath.lineCapStyle = .round
        lowerLinePath.lineWidth = lowerLineWidth
        lowerColor.setStroke()
        lowerLinePath.stroke()
    }
    
    // Animating upper circle from an value to another value
    private func animateUpperCircle(fromValue: Double, toValue: Double) {
        guard fromValue != toValue, maxValue > 0 else { return }
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat(fromValue / maxValue)
        animation.toValue = CGFloat(toValue / maxValue)
        animation.duration = animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: animationStyle)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        direction = toValue >= fromValue ? .forward : .backward
        upperCircleLayer.add(animation, forKey: "strokeEnd")
    }
    
    private func setupInitialState() {
        clearsContextBeforeDrawing = false
        isOpaque = true
        backgroundColor = .clear
        let size = min(bounds.width, bounds.height)
        let offset = max(upperLineWidth, lowerLineWidth) / 2
        radius = size / 2 - radiusShadow - offset
        
        let upperPath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: startRadians, endAngle: endRadians, clockwise: true)
        upperCircleLayer.strokeEnd = CGFloat(currentValue / maxValue)
        upperCircleLayer.path = upperPath.cgPath
        upperCircleLayer.strokeColor = upperColor.cgColor
        upperCircleLayer.fillColor = UIColor.clear.cgColor
        upperCircleLayer.lineWidth = upperLineWidth
        upperCircleLayer.lineCap = .round
        upperCircleLayer.shadowColor = colorShadow.cgColor
        upperCircleLayer.shadowOffset = offsetShadow
        upperCircleLayer.shadowRadius = radiusShadow
        upperCircleLayer.shadowOpacity = 1
        layer.addSublayer(upperCircleLayer)
    }
    
    // MARK: Helper
    private func radians(from value: Double, offset: CGFloat = 0) -> CGFloat {
        if maxValue == 0 {
            return 0
        }
        return startRadians + CGFloat(value / maxValue) * (2 * .pi - bottomRadians)
    }
    
    private func changeValue(newValue: Double) {
        delegate?.meterView(self, changedValue: newValue)
    }
    
    // "Almost realtime" updating current value :)
    private func resumeReporter() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { [weak self] timer in
            guard let `self` = self, let strokeEnd = self.upperCircleLayer.presentation()?.strokeEnd else {
                return
            }
            switch self.direction {
            case .backward, .forward:
                let value = Double(strokeEnd) * self.maxValue
                self.changeValue(newValue: value)
            case .none: break
            }
        })
    }
}

extension CircularMeterView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            direction = .none
            changeValue(newValue: currentValue)
            timer?.invalidate()
        }
    }
}
