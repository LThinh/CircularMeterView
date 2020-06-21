//
//  StringExtension.swift
//  CircularMeterView
//
//  Created by Thinh Le on 6/21/20.
//  Copyright © 2020 Thinh Le. All rights reserved.
//

import UIKit

extension String {
    func sizeOf(_ font: UIFont) -> CGSize {
        return self.size(withAttributes: [NSAttributedString.Key.font: font])
    }
}
