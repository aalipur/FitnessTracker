//
//  WorkoutViewController.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 16.04.2022.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    private let mainLabel = UILabel(text: "START WORKOUT", font: .robotoMedium24(), textColor: .specialGray)
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let mainImageView: UIImageView = {
        let image = UIImage(named: "girlFitness")
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        return imageView
    }()
    
    private let detailsLabel = UILabel(text: "Details", font: .robotoMedium14(), textColor: .specialLightBrown)
    private let workoutView = WorkoutView()
    
    private lazy var finishButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Finish", for: .normal)
        button.backgroundColor = .specialGreen
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        return button
    }()

//MARK: viewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius  = closeButton.frame.width / 2
    }
    
//MARK: functions
        private func setupViews() {
            view.backgroundColor = .specialBackground
            [mainLabel, closeButton, mainImageView,
             detailsLabel, workoutView, finishButton
             ].forEach{ view.addSubview($0) }
        }
//MARK: @objc functions
        @objc private func closeButtonTapped() {
            dismiss(animated: true)
        }
        
        @objc private func finishButtonTapped() {
            print("finishButtonTapped")
        }
}

//MARK: extensions
extension WorkoutViewController {
    
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

            mainImageView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 28),
            mainImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.width - 189) / 2),
            mainImageView.heightAnchor.constraint(equalToConstant: 250),
            mainImageView.widthAnchor.constraint(equalToConstant: 189),

            detailsLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 26),
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            detailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),

            workoutView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 3),
            workoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            workoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            workoutView.heightAnchor.constraint(equalToConstant: 235),

            finishButton.topAnchor.constraint(equalTo: workoutView.bottomAnchor, constant: 20),
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
