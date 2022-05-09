//
//  StatisticViewController.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 09.04.2022.
//

import UIKit
import RealmSwift

struct DifferenceWorkout { // лучшая практика вынести в отдельный файл
    
    let name: String
    let lastReps: Int
    let firstReps: Int
}

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
    
    //MARK: Realm
        private let localRealm = try! Realm() // можно через do catch  блок сделать избежать force unwrapp
        private var workoutArray: Results<WorkoutModel>!
    
    private var differenceArray = [DifferenceWorkout]()
    
    //MARK: VC lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupDelegates()
        setStartScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        differenceArray = [DifferenceWorkout]()
        setStartScreen()
        tableView.reloadData()
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
    
    private func getWorkoutsName() -> [String] {
        var nameArray = [String]()
        workoutArray = localRealm.objects(WorkoutModel.self)
        
        for workoutModel in workoutArray {
            if !nameArray.contains(workoutModel.workoutName) {
                nameArray.append(workoutModel.workoutName)
            }
        }
        return nameArray
    }
    
    private func getDifferenceModel(dateStart: Date) {
        let dateEnd = Date().localDate()
        let nameArray = getWorkoutsName()
        
        for name in nameArray {
            //NSPredicate
            let predicateDifference = NSPredicate(format: "workoutName = '\(name)' AND workoutDate BETWEEN %@", [dateStart, dateEnd])
            workoutArray = localRealm.objects(WorkoutModel.self).filter(predicateDifference).sorted(byKeyPath: "workoutDate")
            
            guard let last = workoutArray.last?.workoutReps,
                  let first = workoutArray.first?.workoutReps else {
                return
            }
            let differenceWorkout = DifferenceWorkout(name: name, lastReps: last, firstReps: first)
            differenceArray.append(differenceWorkout)
        }
    }
    
    private func setStartScreen() {
        let dateToday = Date().localDate()
        getDifferenceModel(dateStart: dateToday.offsetDay(days: 7))
        tableView.reloadData()
    }
    
    //MARK: @objc functions
    @objc private func segmentChange() {
        let dateToday = Date().localDate()
        differenceArray = [DifferenceWorkout]()
        
        if segmentadControl.selectedSegmentIndex == 0 {
            let dateStart = dateToday.offsetDay(days: 7)
            getDifferenceModel(dateStart: dateStart)
        } else {
            let dateStart = dateToday.offsetMonth(month: 1)
            getDifferenceModel(dateStart: dateStart)
        }
        tableView.reloadData()
    }
}

//MARK: UITableViewDataSource
extension StatisticViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        differenceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idExerciseViewCell, for: indexPath) as? ExerciseViewCell else {
            return UITableViewCell() }
        let differenceModel = differenceArray[indexPath.row]
        cell.cellConfigure(differenceWorkout: differenceModel)
        return cell
    }
}

//MARK: UITableViewDelegate
extension StatisticViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

//MARK: SetupConstraints
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
