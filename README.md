# CircularMeterView
A Circular Meter View with smooth animation

[![License][license-image]][license-url]
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/CircularMeterView.svg)](https://cocoapods.org/pods/CircularMeterView)
[![Platform](https://img.shields.io/badge/platforms-iOS-333333.svg)](http://cocoapods.org/pods/CircularMeterView)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)


[![Demo](https://i.gyazo.com/9c4d5927ca76df63c4008b6556e54ce6.gif)](https://gyazo.com/9c4d5927ca76df63c4008b6556e54ce6)

## Features

- [x] Updates values while animation
- [x] Shows an animatable circular meter view
- [x] Configures directly on storyboard/xibs or initiates programmatically

## Requirements

- iOS 11.1+
- Swift 5.0

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `CircularMeterView` by adding it to your `Podfile`:

```ruby
pod 'CircularMeterView', '1.0'
```

To get the full benefits import `CircularMeterView` wherever you import UIKit

``` swift
import UIKit
import CircularMeterView
```

#### Manually
1. Download and drop ```CircularMeterView.swift``` in your project.  
2. Congratulations!

## Usage example

1. import `CircularMeterView` to your project
```
import CircularMeterView
```

2. Create and configure loading button
```swift

let frame = CGRect(x: 50, y: 50, width: 200, height: 200)
let circularMeterView = CircularMeterView(frame: frame)

// Setting animation duration which is used on each update
circularMeterView.animationDuration = 2

// Setting animation style
circularMeterView.animationStyle = .easeIn

// Setting line cap
circularMeterView.lineCap = .square

// setting max value
circularMeterView.maxValue = 100

// setting start angle, default 0
circularMeterView.startAngle = 0

// setting end angle, default 360
circularMeterView.endAngle = 180

// Setting lower circle width, default 8
circularMeterView.lowerCircleWidth = 10

// Setting lower circle color, default gray
circularMeterView.lowerColor = .darkGray

// Setting upper circle width, default 10
circularMeterView.upperCircleWidth = 12

// Setting lower circle color, default green
circularMeterView.upperColor = .yellow

// Setting shadow radius, default 0
circularMeterView.radiusShadow = 10
circularMeterView.offsetShadow = .zero
circularMeterView.colorShadow = .black

// Add meter view as subview
view.addSubview(circularMeterView)

```

Or you can drag a `UIView` to your storyboard/xib file and set its class to `CircularMeterView` and configures the view on storyboard directly.

[![Using Storyboard](https://i.gyazo.com/4c3f6a03ac1d91e90232537508438b7d.png)](https://gyazo.com/4c3f6a03ac1d91e90232537508438b7d)

3. Update value:
```
circularMeterView.updateValue(50)
```

## Contribute

We would love you for the contribution to **CircularMeterView**, check the ``LICENSE`` file for more info.

## Information

Copyright © 2020 Thinh Le – [@Facebook](https://www.facebook.com/LLThinh)

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/LThinh/CircularMeterView](https://github.com/LThinh/CircularMeterView)

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
