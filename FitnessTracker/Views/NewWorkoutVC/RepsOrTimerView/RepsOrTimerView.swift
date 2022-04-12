//
//  RepsOrTimerView.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 12.04.2022.
//

import UIKit

class RepsOrTimerView: UIView {
    
    private let setsLabel = UILabel(text: "Sets", font: .robotoMedium18() ?? .systemFont(ofSize: 18), textColor: .specialGray)
    private let repsLabel = UILabel(text: "Reps", font: .robotoMedium18() ?? .systemFont(ofSize: 18), textColor: .specialGray)
    private let timerLabel = UILabel(text: "Timer", font: .robotoMedium18() ?? .systemFont(ofSize: 18), textColor: .specialGray)
    private let repsOrTimerLabel = UILabel(text: "Choose repeat or timer", font: .robotoMedium14() ?? .systemFont(ofSize: 14), textColor: .specialLightBrown)
    
    private let numberOfSetsLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+4"
        label.textColor = .specialBlack
        label.font = .robotoMedium24()
        return label
    }()
    
    private let numberOfRepsLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+4"
        label.textColor = .specialBlack
        label.font = .robotoMedium24()
        return label
    }()
    
    private let timeLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1m 56sec"
        label.textColor = .specialBlack
        label.font = .robotoMedium24()
        return label
    }()
    
    private let setsSlider: UISlider = {
           let slider = UISlider()
            slider.translatesAutoresizingMaskIntoConstraints = false
            slider.minimumValue = 0
            slider.maximumValue = 10
            slider.maximumTrackTintColor = .specialLightBrown
            slider.minimumTrackTintColor = .specialGreen
            //slider.setThumbImage(UIImage(named: "sun"), for: .normal)
            return slider
        }()
    
    private let RepsSlider: UISlider = {
           let slider = UISlider()
            slider.translatesAutoresizingMaskIntoConstraints = false
            slider.minimumValue = 0
            slider.maximumValue = 10
            slider.maximumTrackTintColor = .specialLightBrown
            slider.minimumTrackTintColor = .specialGreen
            return slider
        }()
    
    private let timerSlider: UISlider = {
           let slider = UISlider()
            slider.translatesAutoresizingMaskIntoConstraints = false
            slider.minimumValue = 0
            slider.maximumValue = 10
            slider.maximumTrackTintColor = .specialLightBrown
            slider.minimumTrackTintColor = .specialGreen
            return slider
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
        [setsLabel, numberOfSetsLabel, setsSlider, repsOrTimerLabel,
         repsLabel, numberOfRepsLabel, RepsSlider,
         timerLabel, timeLabel, timerSlider,
         ].forEach{ addSubview($0) }
    }
}

extension RepsOrTimerView {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            setsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 23),
            setsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            setsLabel.heightAnchor.constraint(equalToConstant: 21),
            setsLabel.widthAnchor.constraint(equalToConstant: 88),
            
            numberOfSetsLabel.centerYAnchor.constraint(equalTo: setsLabel.centerYAnchor),
            numberOfSetsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -13),
            
            setsSlider.topAnchor.constraint(equalTo: setsLabel.bottomAnchor, constant: 16),
            setsSlider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            setsSlider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            
            repsOrTimerLabel.topAnchor.constraint(equalTo: setsSlider.bottomAnchor, constant: 22),
            repsOrTimerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            repsLabel.topAnchor.constraint(equalTo: repsOrTimerLabel.bottomAnchor, constant: 5),
            repsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            repsLabel.heightAnchor.constraint(equalToConstant: 21),
            repsLabel.widthAnchor.constraint(equalToConstant: 88),
            
            numberOfRepsLabel.centerYAnchor.constraint(equalTo: repsLabel.centerYAnchor),
            numberOfRepsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -13),
            
            RepsSlider.topAnchor.constraint(equalTo: numberOfRepsLabel.bottomAnchor, constant: 16),
            RepsSlider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            RepsSlider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            
            timerLabel.topAnchor.constraint(equalTo: RepsSlider.topAnchor, constant: 42),
            timerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            timerLabel.heightAnchor.constraint(equalToConstant: 21),
            timerLabel.widthAnchor.constraint(equalToConstant: 88),
            
            timeLabel.centerYAnchor.constraint(equalTo: timerLabel.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -13),
            
            timerSlider.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16),
            timerSlider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            timerSlider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
        ])
    }
}
