//
//  CalendarCollectionViewcell.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 09.04.2022.
//

import UIKit

class CalendarCollectioViewCell: UICollectionViewCell {
    
    private let dayOfWeekLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "We"
        label.font = .robotoBold16()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let numberOfDayLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "07"
        label.font = .robotoBold20()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                backgroundColor = .specialYellow
                layer.cornerRadius = 10
                dayOfWeekLabel.textColor = .specialBlack
                numberOfDayLabel.textColor = .specialDarkGreen
            } else {
                backgroundColor = .specialGreen
                dayOfWeekLabel.textColor = .white
                numberOfDayLabel.textColor = .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: functions
    private func setupViews() {
        [dayOfWeekLabel, numberOfDayLabel].forEach{ addSubview($0)}
    }
    
    private func cellConfigure(numberOfDay: String, dayOfWeek: String) {
        numberOfDayLabel.text = numberOfDay
        dayOfWeekLabel.text = dayOfWeek
    }
    
    public func dateForCell(numberOfDay: String, dayOfWeek: String) {
        cellConfigure(numberOfDay: numberOfDay, dayOfWeek: dayOfWeek)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dayOfWeekLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dayOfWeekLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            
            numberOfDayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberOfDayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
