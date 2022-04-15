//
//  NewWorkoutViewController.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 12.04.2022.
//

import UIKit
import RealmSwift

class NewWorkoutViewController: UIViewController {
    
    private let mainLabel = UILabel(text: "NEW WORKOUT", font: .robotoMedium24(), textColor: .specialGray)
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let nameLabel = UILabel(text: "Name", font: .robotoMedium14(), textColor: .specialLightBrown)
    
    private let nameTextfield: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .specialBrown
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.textColor = .specialGray
        textField.font = .robotoBold20()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        return textField
    }()
    
    private let dateRepeatLabel = UILabel(text: "Date and repeat", font: .robotoMedium14(), textColor: .specialLightBrown)
    private let repsTimerLabel = UILabel(text: "Reps or timer", font: .robotoMedium14(), textColor: .specialLightBrown)
    private let dateRepeatView = DateRepeatView()
    private let repsTimerView = RepsOrTimerView()
    
    private lazy var saveButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SAVE", for: .normal)
        button.backgroundColor = .specialGreen
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
//MARK: Realm
    private let localRealm = try! Realm()
    private var workoutModel = WorkoutModel()
    
    private var testImage = UIImage(named: "testWorkout")
    
    private func setModel() {
        guard let nameWorkout = nameTextfield.text else { return }
        workoutModel.workoutName = nameWorkout
        
        let dateFromPicker = dateRepeatView.setDateRepeat().0
        workoutModel.workoutDate = dateFromPicker
        workoutModel.woroutNumberOfDay = dateFromPicker.getWeekDayNumber()
        
        workoutModel.workoutRepeat = dateRepeatView.setDateRepeat().1
        workoutModel.workoutSets = repsTimerView.setSliderValue().0
        workoutModel.workoutReps = repsTimerView.setSliderValue().1
        workoutModel.workoutTimer = repsTimerView.setSliderValue().2
        
        guard let imageData = testImage?.pngData() else { return }
        workoutModel.workoutImage = imageData
    }

//MARK: viewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius  = closeButton.frame.width / 2
    }
    
//    deinit {           // вызывается когда вьюконтрорллер удаляется из памяти
//        print("deinit")
//    }
    
//MARK: functions
    private func setupViews() {
        view.backgroundColor = .specialBackground
        [mainLabel, closeButton, nameLabel, nameTextfield, dateRepeatLabel,
         dateRepeatView, repsTimerLabel, repsTimerView, saveButton].forEach{ view.addSubview($0) }
    }
    
//MARK: @objc functions
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        setModel()
        RealmManager.shared.saveWorkoutModel(model: workoutModel)
    }
}

//MARK: extensions
extension NewWorkoutViewController {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 24),
            mainLabel.widthAnchor.constraint(equalToConstant: 136),
            
            closeButton.centerYAnchor.constraint(equalTo: mainLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            
            nameLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            nameTextfield.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            nameTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextfield.heightAnchor.constraint(equalToConstant: 38),
            
            dateRepeatLabel.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor, constant: 10),
            dateRepeatLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            dateRepeatLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            dateRepeatView.topAnchor.constraint(equalTo: dateRepeatLabel.bottomAnchor, constant: 3),
            dateRepeatView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateRepeatView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateRepeatView.heightAnchor.constraint(equalToConstant: 92),
            
            repsTimerLabel.topAnchor.constraint(equalTo: dateRepeatView.bottomAnchor, constant: 10),
            repsTimerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            repsTimerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            repsTimerView.topAnchor.constraint(equalTo: repsTimerLabel.bottomAnchor, constant: 3),
            repsTimerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repsTimerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            repsTimerView.heightAnchor.constraint(equalToConstant: 320),
            
            saveButton.topAnchor.constraint(equalTo: repsTimerView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
