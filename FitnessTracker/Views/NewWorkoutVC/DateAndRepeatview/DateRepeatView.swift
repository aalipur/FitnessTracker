//
//  DateRepeatView.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 12.04.2022.
//

import UIKit

class DateRepeatView: UIView {
    
    private let dateLabel = UILabel(text: "Date", font: .robotoMedium18(), textColor: .specialGray)
    private let repeatLabel = UILabel(text: "Repeat every 7 days", font: .robotoMedium18(), textColor: .specialGray)
    
    private let datePicker: UIDatePicker = {
       let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.tintColor = .specialGreen
        return datePicker
    }()
    
    private let testSwitch: UISwitch = {
       let testSwitch = UISwitch()
        testSwitch.translatesAutoresizingMaskIntoConstraints = false
        testSwitch.isOn = true
        testSwitch.onTintColor = .specialGreen
        return testSwitch
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: functions
    private func getDateRepeat() -> (Date, Bool) {
        (datePicker.date, testSwitch.isOn)
    }
    
    public func setDateRepeat() -> (Date, Bool) {
        getDateRepeat()
    }
    
    private func refreashWorkoutObjects() {
        datePicker.setDate(Date(), animated: true)
        testSwitch.isOn = true
    }
    
    public func refreashDatePickreAndSwitch() {
        refreashWorkoutObjects()
    }
    
    private func setupViews() {
        datePicker.subviews[0].subviews[0].subviews[0].alpha = 0
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor = .specialBrown
        [dateLabel, repeatLabel, datePicker, testSwitch].forEach{ addSubview($0) }
    }
}

extension DateRepeatView {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 17),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            dateLabel.heightAnchor.constraint(equalToConstant: 21),
            dateLabel.widthAnchor.constraint(equalToConstant: 88),
            
            repeatLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 13),
            repeatLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            repeatLabel.heightAnchor.constraint(equalToConstant: 21),
            repeatLabel.widthAnchor.constraint(equalToConstant: 188),
            
            datePicker.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            datePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),

            testSwitch.centerYAnchor.constraint(equalTo: repeatLabel.centerYAnchor),
            testSwitch.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18)
        ])
    }
}
