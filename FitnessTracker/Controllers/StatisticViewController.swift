//
//  StatisticViewController.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 09.04.2022.
//

import UIKit

class StatisticViewController: UIViewController {
    
    private let mainLabel = UILabel(text: "STATISTICS", font: .robotoMedium24(), textColor: .specialGray)
    
    private let exerciseLabel = UILabel(text: "Exercises", font: .robotoMedium14(), textColor: .specialLightBrown)
    
    private lazy var segmentadControl: UISegmentedControl = {
       let segmentedControl = UISegmentedControl(items: ["Week", "Month"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .specialGreen
        segmentedControl.selectedSegmentTintColor = .specialYellow
        let font = UIFont(name: "Roboto-Medium", size: 16)
        segmentedControl.setTitleTextAttributes([.font: font as Any,
                                                 .foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([.font: font as Any,
                                                 .foregroundColor: UIColor.specialGray], for: .selected)
        segmentedControl.addTarget(self, action: #selector(segmentChange), for: .valueChanged)
        return segmentedControl
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
    
    private let idExerciseViewCell = "idExerciseViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupDelegates()
    }
    
//MARK: functions
    private func setupViews() {
        view.backgroundColor = .specialBackground
        tableView.register(ExerciseViewCell.self, forCellReuseIdentifier: idExerciseViewCell)
        [mainLabel, segmentadControl, exerciseLabel, tableView].forEach{ view.addSubview($0) }
    }
    
    private func setupDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc private func segmentChange() {
        print("segmentChangeTapped")
    }
}

//MARK: extensions
extension StatisticViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idExerciseViewCell, for: indexPath) as? ExerciseViewCell else {
            return UITableViewCell() }
        return cell
    }
}

extension StatisticViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension StatisticViewController {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 24),
            mainLabel.widthAnchor.constraint(equalToConstant: 136),
            
            segmentadControl.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 31),
            segmentadControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            segmentadControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23),
            
            exerciseLabel.topAnchor.constraint(equalTo: segmentadControl.bottomAnchor, constant: 15),
            exerciseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            exerciseLabel.heightAnchor.constraint(equalToConstant: 21),
            exerciseLabel.widthAnchor.constraint(equalToConstant: 120),
            
            tableView.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
