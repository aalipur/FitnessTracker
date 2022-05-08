//
//  RepsOrTimerView.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 12.04.2022.
//

import UIKit
import RealmSwift

class RepsOrTimerView: UIView {
    
    private let setsLabel = UILabel(text: "Sets", font: .robotoMedium18(), textColor: .specialGray)
    private let repsLabel = UILabel(text: "Reps", font: .robotoMedium18(), textColor: .specialGray)
    private let timerLabel = UILabel(text: "Timer", font: .robotoMedium18(), textColor: .specialGray)
    private let repsOrTimerLabel = UILabel(text: "Choose repeat or timer", font: .robotoMedium14(), textColor: .specialLightBrown)
    
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
    
    private lazy var setsSlider: UISlider = {
           let slider = UISlider()
            slider.translatesAutoresizingMaskIntoConstraints = false
            slider.minimumValue = 0
            slider.maximumValue = 10
            slider.maximumTrackTintColor = .specialLightBrown
            slider.minimumTrackTintColor = .specialGreen
            slider.addTarget(self, action: #selector(setsSliderChange), for: .valueChanged)
            return slider
        }()
    
    private lazy var repsSlider: UISlider = {
           let slider = UISlider()
            slider.translatesAutoresizingMaskIntoConstraints = false
            slider.minimumValue = 0
            slider.maximumValue = 10
            slider.maximumTrackTintColor = .specialLightBrown
            slider.minimumTrackTintColor = .specialGreen
            slider.addTarget(self, action: #selector(repsSliderChange), for: .valueChanged)
            return slider
        }()
    
    private lazy var timerSlider: UISlider = {
           let slider = UISlider()
            slider.translatesAutoresizingMaskIntoConstraints = false
            slider.minimumValue = 0
            slider.maximumValue = 10
            slider.maximumTrackTintColor = .specialLightBrown
            slider.minimumTrackTintColor = .specialGreen
            slider.addTarget(self, action: #selector(timerSliderChange), for: .valueChanged)
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
    
    //MARK: functions
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor = .specialBrown
        [setsLabel, numberOfSetsLabel, setsSlider, repsOrTimerLabel,
         repsLabel, numberOfRepsLabel, repsSlider,
         timerLabel, timeLabel, timerSlider,
         ].forEach{ addSubview($0) }
    }
    
    private func setNegative(label: UILabel, numberLabel: UILabel, slider: UISlider) {
        label.alpha = 0.5
        numberLabel.alpha = 0.5
        numberLabel.text = "0"
        slider.alpha = 0.5
        slider.value = 0
    }
    
    private func setActive(label: UILabel, numberLabel: UILabel, slider: UISlider) {
        label.alpha = 1.0
        numberLabel.alpha = 1.0
        slider.alpha = 1
    }
    
    private func getSliderValue() -> (Int, Int, Int) {
        let setsSliderValue = Int(setsSlider.value)
        let repsSliderValue = Int(repsSlider.value)
        let timerSliderValue = Int(timerSlider.value)
        return (setsSliderValue, repsSliderValue, timerSliderValue)
    }
    
    public func setSliderValue() -> (Int, Int, Int) {
        getSliderValue()
    }
    
    private func refreashWorkoutObjects() {
        numberOfSetsLabel.text = "0"
        setsSlider.value = 0
        numberOfRepsLabel.text = "0"
        repsSlider.value = 0
        timeLabel.text = "0"
        timerSlider.value = 0
    }
    
    public func refreashLabelsAndSliders() {
        refreashWorkoutObjects()
    }
    
    //MARK: @objc functions
    @objc private func setsSliderChange() {
        numberOfSetsLabel.text = "\(Int(setsSlider.value))"
    }
    
    @objc private func repsSliderChange() {
        numberOfRepsLabel.text = "\(Int(repsSlider.value))"
        setNegative(label: timerLabel, numberLabel: timeLabel, slider: timerSlider)
        setActive(label: repsLabel, numberLabel: numberOfRepsLabel, slider: repsSlider)
    }
    
    @objc private func timerSliderChange() {
        let (min, sec) = { (secs: Int) -> (Int, Int) in
            (secs / 60, secs % 60)
        }(Int(timerSlider.value))
        timeLabel.text = (sec != 0 ? "\(min) min \(sec) sec" : "\(min) min")
        setNegative(label: repsLabel, numberLabel: numberOfRepsLabel, slider: repsSlider)
        setActive(label: timerLabel, numberLabel: timeLabel, slider: timerSlider)
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
            
            repsSlider.topAnchor.constraint(equalTo: numberOfRepsLabel.bottomAnchor, constant: 16),
            repsSlider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            repsSlider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            
            timerLabel.topAnchor.constraint(equalTo: repsSlider.topAnchor, constant: 42),
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
