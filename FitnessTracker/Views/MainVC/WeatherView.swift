//
//  WeatherView.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 05.04.2022.
//

import UIKit

class WeatherView: UIView {
    
    private let cloudinessLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sunny"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        return label
    }()
    
    private let weatherDescriptionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Хорошая погода, чтобы позаниматься на улице"
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.textColor = .specialGray
        label.font = .robotoMedium14()
        return label
    }()
    
    private let sunImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "sun")
        return imageView
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
        backgroundColor = . specialBackground
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        [sunImageView, cloudinessLabel, weatherDescriptionLabel].forEach{ addSubview($0) }
    }
}

//MARK: extensions
extension WeatherView {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            sunImageView.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            sunImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            sunImageView.heightAnchor.constraint(equalToConstant: 62),
            sunImageView.widthAnchor.constraint(equalToConstant: 62),
            
            cloudinessLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cloudinessLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            cloudinessLabel.heightAnchor.constraint(equalToConstant: 21),
            cloudinessLabel.widthAnchor.constraint(equalToConstant: 80),
            
            weatherDescriptionLabel.topAnchor.constraint(equalTo: cloudinessLabel.bottomAnchor, constant: 5),
            weatherDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            weatherDescriptionLabel.heightAnchor.constraint(equalToConstant: 31),
            weatherDescriptionLabel.widthAnchor.constraint(equalToConstant: 171)
        ])
    }
}
