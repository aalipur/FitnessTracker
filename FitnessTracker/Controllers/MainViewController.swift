//
//  ViewController.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 05.04.2022.
//

import UIKit
import RealmSwift// импортировать необязательно, лучшая практика работать через менеджер как на NewWorkoutViewController

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
    
    private let noWorkoutImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "noWorkout")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let calendarView = CalendarView()
    private let weatherView = WeatherView()
    private let idWorkoutTableviewCell = "idWorkoutTableviewCell"
    
    //MARK: Realm
    private let localRealm = try! Realm() // можно через do catch  блок сделать избежать force unwrapp
    private var workoutArray: Results<WorkoutModel>!
    
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getWorkouts(date: Date())
        tableView.reloadData()
    }
    
    //MARK: functions
    private func setupViews() {
        view.backgroundColor = .specialBackground
        weatherView.addShadowOnView()
        tableView.register(WorkoutTableViewCell.self, forCellReuseIdentifier: idWorkoutTableviewCell)
        [calendarView, userPhotoImageView, userNameLabel,
         addWorkoutButton, weatherView, workoutTodayLabel, tableView,
         noWorkoutImageView].forEach{ view.addSubview($0) }
    }
    
    private func setupDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
        calendarView.cellCollectionViewDelegate = self
    }
    
    private func getWorkouts(date: Date) {
        let weekDay = date.getWeekDayNumber()
        let dateStart = date.startEndDate().0
        let dateEnd = date.startEndDate().1
        
        //MARK: NSPredicate
        let predicateRepeat = NSPredicate(format: "woroutNumberOfDay = \(weekDay) AND workoutRepeat = true")
        let predicateUnrepeat = NSPredicate(format: "workoutRepeat = false AND workoutDate BETWEEN %@", [dateStart, dateEnd])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeat])
        
        workoutArray = localRealm.objects(WorkoutModel.self).filter(compound).sorted(byKeyPath: "workoutName")
        checkWorkoutToday()
        tableView.reloadData()
    }
    
    private func checkWorkoutToday() {
        if workoutArray.count == 0 {
            noWorkoutImageView.isHidden = false
            tableView.isHidden = true
        } else {
            noWorkoutImageView.isHidden = true
            tableView.isHidden = false
        }
    }
    
    //MARK: @objc functions
    @objc private func addWorkoutButtonTapped() {
        let newWorkoutViewController = NewWorkoutViewController()
        newWorkoutViewController.modalPresentationStyle = .fullScreen
        newWorkoutViewController.modalTransitionStyle = .flipHorizontal
        present(newWorkoutViewController, animated: true)
    }
}

//MARK: UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        workoutArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idWorkoutTableviewCell, for: indexPath) as? WorkoutTableViewCell else { return UITableViewCell() }
        let model = workoutArray[indexPath.row]
        cell.cellConfigure(model: model)
        cell.cellStartWorkoutDelegate = self
        return cell
    }
}

//MARK: UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "") {_, _, _ in
            let deleteModel = self.workoutArray[indexPath.row]
            RealmManager.shared.deleteWorkoutModel(model: deleteModel)
            //tableView.deleteRows(at: [indexPath], with: .automatic) // вариант удаления
            tableView.reloadData()
        }
        action.backgroundColor = .specialBackground
        action.image = UIImage(named: "trashBasket")
        return UISwipeActionsConfiguration(actions: [action])
    }
}

//MARK: SelectCollectionViewItem
extension MainViewController: SelectCollectionViewItem {
    func selectItem(date: Date) {
        getWorkouts(date: date)
    }
}

//MARK: StartWorkoutProtocol
extension MainViewController: StartWorkoutProtocol {
    
    func startButtonTapped(model: WorkoutModel) {
        print(model)
    }
}

//MARK: SetupConstraints
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            noWorkoutImageView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: 0),
            noWorkoutImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            noWorkoutImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            noWorkoutImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
        ])
    }
}
