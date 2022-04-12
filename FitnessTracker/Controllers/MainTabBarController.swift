//
//  MainTabBarController.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 12.04.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViews()
    }
   
    private func setupTabBar() {
        tabBar.backgroundColor = .specialTabBar
        tabBar.tintColor = .specialDarkGreen
        tabBar.unselectedItemTintColor = .specialGray
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.specialLightBrown.cgColor
    }

    private func setupViews() {
        let mainVC = MainViewController()
        let statisticVC = StatisticViewController()
        
        setViewControllers([mainVC, statisticVC], animated: true)
        
        guard let items = tabBar.items else { return }
        
        items[0].title = "Main"
        items[1].title = "Statistics"
        
        items[0].image = UIImage(named: "mainTabBar")
        items[1].image = UIImage(named: "statisticTabBar")
        
        UITabBarItem.appearance().setBadgeTextAttributes([.font: UIFont(name: "Roboto-Bold", size: 12) as Any], for: .normal)
    }
}
