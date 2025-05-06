//
//  BudgetStorage.swift
//  Budgetr
//
//  Created by Riley Bowling on 5/4/25.
//

import Foundation
import Combine

class BudgetStorage: ObservableObject {
    @Published var budget: Budget? = nil
}
