//
//  StatisticViewController.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 09.04.2022.
//

import UIKit

class StatisticViewController: UIViewController {
    
    private let mainLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "STATISTICS"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        return label
    }()
    
    private let exerciseLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Exercises"
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
        [mainLabel, exerciseLabel, tableView].forEach{ view.addSubview($0) }
    }
    private func setupDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
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
            
            exerciseLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 75),
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
