//
//  RealmManager.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 15.04.2022.
//

import Foundation
import RealmSwift

//Singleton pattern

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveWorkoutModel(model: WorkoutModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
}
