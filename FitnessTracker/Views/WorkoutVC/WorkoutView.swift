//
//  WorkoutView.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 16.04.2022.
//

import UIKit

class WorkoutView: UIView {

    private let squatsLabel = UILabel(text: "Biceps", font: .robotoBold24(), textColor: .specialGray)
    private let setsLabel = UILabel(text: "Sets", font: .robotoMedium18(), textColor: .specialGray)
    private let timeOfSetLabel = UILabel(text: "Reps", font: .robotoMedium18(), textColor: .specialGray)
    
    private let lineView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .specialLine
        return view
    }()
    
    private let lineView2: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .specialLine
        return view
    }()
    
    private let numberOfSetsLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1/4"
        label.textColor = .specialBlack
        label.font = .robotoMedium24()
        return label
    }()
    
    private let repsLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "14"
        label.textColor = .specialBlack
        label.font = .robotoMedium24()
        return label
    }()
    
    private lazy var editButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Editing", for: .normal)
        button.setImage(UIImage(named: "pencilIcon"), for: .normal)
        button.backgroundColor = .specialBrown
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextSetButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("NEXT SET", for: .normal)
        button.backgroundColor = .specialDarkYellow
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(nextSetButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor = .specialBrown
        [squatsLabel, setsLabel, numberOfSetsLabel, lineView,
         timeOfSetLabel, repsLabel, lineView2,
         editButton, nextSetButton
        ].forEach{ addSubview($0) }
    }
    
//MARK: @objc functions
    @objc private func editButtonTapped() {
        print("editButtonTapped")
    }
    
    @objc private func nextSetButtonTapped() {
        print("nextSetButtonTapped")
    }
}

extension WorkoutView {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            squatsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            squatsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            squatsLabel.heightAnchor.constraint(equalToConstant: 24),
            squatsLabel.widthAnchor.constraint(equalToConstant: 78),
            
            setsLabel.topAnchor.constraint(equalTo: squatsLabel.bottomAnchor, constant: 20),
            setsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            setsLabel.heightAnchor.constraint(equalToConstant: 21),
            setsLabel.widthAnchor.constraint(equalToConstant: 88),
            
            numberOfSetsLabel.centerYAnchor.constraint(equalTo: setsLabel.centerYAnchor),
            numberOfSetsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            
            lineView.topAnchor.constraint(equalTo: setsLabel.bottomAnchor, constant: 3),
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            timeOfSetLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 25),
            timeOfSetLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            timeOfSetLabel.heightAnchor.constraint(equalToConstant: 21),
            timeOfSetLabel.widthAnchor.constraint(equalToConstant: 88),
            
            repsLabel.centerYAnchor.constraint(equalTo: timeOfSetLabel.centerYAnchor),
            repsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            
            lineView2.topAnchor.constraint(equalTo: timeOfSetLabel.bottomAnchor, constant: 3),
            lineView2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            lineView2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            lineView2.heightAnchor.constraint(equalToConstant: 1),
            
            editButton.topAnchor.constraint(equalTo: lineView2.bottomAnchor, constant: 7),
            editButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            editButton.heightAnchor.constraint(equalToConstant: 24),
            editButton.widthAnchor.constraint(equalToConstant: 84),
            
            nextSetButton.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 10),
            nextSetButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            nextSetButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            nextSetButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
