//
//  ViewController.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 05.04.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private let userPhotoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1)
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Your name"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        return label
    }()
    
    private lazy var addWorkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.setTitle("Add workout", for: .normal)
        button.tintColor = .specialDarkGreen
        button.setImage(UIImage(named: "addWorkout"), for: .normal)
        button.titleLabel?.font = .robotoMedium12()
        button.imageEdgeInsets = UIEdgeInsets(top: 0,
                                              left: 20,
                                              bottom: 15,
                                              right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 50,
                                              left: -40,
                                              bottom: 0,
                                              right: 0)
        button.addTarget(self, action: #selector(addWorkoutButtonTapped), for: .touchUpInside)
        button.addShadowOnView()
        return button
    }()
    
    private let workoutTodayLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "WorkoutToday"
        label.textColor = .specialLightBrown
        label.font = .robotoMedium14()
        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.bounces = false
        table.showsVerticalScrollIndicator = false
        table.delaysContentTouches = false
        table.separatorStyle = .none
        table.backgroundColor = .none
        return table
    }()
    
    private let calendarView = CalendarView()
    private let weatherView = WeatherView()
    private let idWorkoutTableviewCell = "idWorkoutTableviewCell"
    
//MARK: VC lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupDelegates()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }
    
//MARK: functions
    private func setupViews() {
        view.backgroundColor = .specialBackground
        weatherView.addShadowOnView()
        tableView.register(WorkoutTableViewCell.self, forCellReuseIdentifier: idWorkoutTableviewCell)
        [calendarView, userPhotoImageView, userNameLabel,
         addWorkoutButton, weatherView, workoutTodayLabel, tableView].forEach{ view.addSubview($0) }
    }
    
    private func setupDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
//MARK: @objc functions
    @objc private func addWorkoutButtonTapped() {
        print("Tapped addWorkoutButton")
    }
}

//MARK: extensions
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idWorkoutTableviewCell, for: indexPath) as? WorkoutTableViewCell else { return UITableViewCell() }
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

extension MainViewController {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            userPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            calendarView.topAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 70),
            
            userNameLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: 5),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            userNameLabel.bottomAnchor.constraint(equalTo: calendarView.topAnchor, constant: -10),
            
            addWorkoutButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 6),
            addWorkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addWorkoutButton.heightAnchor.constraint(equalToConstant: 80),
            addWorkoutButton.widthAnchor.constraint(equalToConstant: 80),
            
            weatherView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 6),
            weatherView.leadingAnchor.constraint(equalTo: addWorkoutButton.trailingAnchor, constant: 10),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            weatherView.heightAnchor.constraint(equalToConstant: 80),
            
            workoutTodayLabel.topAnchor.constraint(equalTo: addWorkoutButton.bottomAnchor, constant: 10),
            workoutTodayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            tableView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
