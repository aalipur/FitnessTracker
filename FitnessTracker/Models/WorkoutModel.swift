//
//  WorkoutModel.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 15.04.2022.
//

import RealmSwift
import Foundation

class WorkoutModel: Object {
    
    @Persisted var workoutDate: Date
    @Persisted var woroutNumberOfDay: Int = 0
    @Persisted var workoutName: String = "Unknow"
    @Persisted var workoutRepeat: Bool = true
    @Persisted var workoutSets: Int = 0
    @Persisted var workoutReps: Int = 0
    @Persisted var workoutTimer: Int = 0
    @Persisted var workoutImage: Data?
    @Persisted var workoutStatus: Bool = false
}
