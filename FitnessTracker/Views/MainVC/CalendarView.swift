//
//  CalendarView.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 05.04.2022.
//

import UIKit

protocol SelectCollectionViewItem: AnyObject {
    
    func selectItem(date: Date)
}

class CalendarView: UIView {
    
    private let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 3
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .none
        return collectionView
    }()
    
    private let idCalendarCell = "isCalendarCell"
    
    weak var cellCollectionViewDelegate: SelectCollectionViewItem?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .specialGreen
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        collectionView.register(CalendarCollectioViewCell.self, forCellWithReuseIdentifier: idCalendarCell)
    }
    
    private func setupDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

//MARK: UICollectionViewDataSource
extension CalendarView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCalendarCell, for: indexPath) as? CalendarCollectioViewCell else { return UICollectionViewCell() }
        let dateTimeZone = Date().localDate()
        let weekArray = dateTimeZone.getWeekArray()
        cell.dateForCell(numberOfDay: weekArray[1][indexPath.item], dayOfWeek: weekArray[0][indexPath.item])
        if indexPath.item == 6 {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .right)
        }
        return cell
    }
}

//MARK: UICollectionViewDelegate
extension CalendarView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dateTimeZone = Date()
        
        switch indexPath.item {
            case 0:
                cellCollectionViewDelegate?.selectItem(date: dateTimeZone.offsetDay(days: 6))
            case 1:
                cellCollectionViewDelegate?.selectItem(date: dateTimeZone.offsetDay(days: 5))
            case 2:
                cellCollectionViewDelegate?.selectItem(date: dateTimeZone.offsetDay(days: 4))
            case 3:
                cellCollectionViewDelegate?.selectItem(date: dateTimeZone.offsetDay(days: 3))
            case 4:
                cellCollectionViewDelegate?.selectItem(date: dateTimeZone.offsetDay(days: 2))
            case 5:
                cellCollectionViewDelegate?.selectItem(date: dateTimeZone.offsetDay(days: 1))
            default:
                cellCollectionViewDelegate?.selectItem(date: dateTimeZone.offsetDay(days: 0))
        }
    }
}
//MARK: UICollectionViewDelegateFlowLayout
extension CalendarView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 8, height: collectionView.frame.height)
    }
}
//MARK: SetupConstraints
extension CalendarView {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 105),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
