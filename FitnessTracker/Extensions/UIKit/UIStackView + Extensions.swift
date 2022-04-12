//
//  UIStackView + Extensions.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 09.04.2022.
//

import UIKit

//let stackView = UIStackView()
//stackView.addArrangedSubview(YourView)
//stackView.addArrangedSubview(YourView2)
//stackView.axis = .horizontal
//stackView.spacing = 10
//stackView.translatesAutoresizingMaskIntoConstraints = false

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        //self.distribution = .equalSpacing // распределить стеквью по углам
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
