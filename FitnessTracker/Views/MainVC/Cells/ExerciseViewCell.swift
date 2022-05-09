//
//  ExerciseViewCell.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 09.04.2022.
//

import UIKit

class ExerciseViewCell: UITableViewCell {
    
    private let typeOfExerciseLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PushUps"
        label.adjustsFontSizeToFitWidth = true
        label.font = .robotoMedium22()
        label.textColor = .specialBlack
        return label
    }()
    
    private let beforeLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reps: 9"
        label.textColor = .specialGray
        label.font = .robotoMedium16()
        return label
    }()
    
    private let nowLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reps: 11"
        label.textColor = .specialGray
        label.font = .robotoMedium16()
        return label
    }()
    
    private let numberLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+4"
        label.textColor = .specialDarkGreen
        label.font = .robotoMedium24()
        return label
    }()
    
    private let bottomLineView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .specialLine
        return view
    }()
    
    private var labelsStackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: functions
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        labelsStackView = UIStackView(arrangedSubviews: [beforeLabel, nowLabel],
                                      axis: .horizontal,
                                      spacing: 10)
        [typeOfExerciseLabel, labelsStackView, numberLabel,bottomLineView].forEach{ addSubview($0) }
    }
    
    func cellConfigure(differenceWorkout: DifferenceWorkout) {
        typeOfExerciseLabel.text = differenceWorkout.name
        beforeLabel.text = "Before: \(differenceWorkout.firstReps)"
        nowLabel.text = "Now: \(differenceWorkout.lastReps)"
        
        let difference = differenceWorkout.lastReps - differenceWorkout.firstReps
        numberLabel.text = "\(difference)"
        
        switch difference {
            case ..<0 : numberLabel.textColor = .specialGreen
            case 1...: numberLabel.textColor = .specialYellow
            default: numberLabel.textColor = .specialGray
        }
    }
}

//MARK: extensions
extension ExerciseViewCell {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            typeOfExerciseLabel.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            typeOfExerciseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            typeOfExerciseLabel.heightAnchor.constraint(equalToConstant: 28),
            
            labelsStackView.topAnchor.constraint(equalTo: typeOfExerciseLabel.bottomAnchor, constant: 1),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            labelsStackView.heightAnchor.constraint(equalToConstant: 20),
            
            numberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            numberLabel.bottomAnchor.constraint(equalTo: bottomLineView.topAnchor, constant: -10),
            
            bottomLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            bottomLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            bottomLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -21),
            bottomLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
