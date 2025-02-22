//
//  GameResult.swift
//  MovieQuiz
//
//  Created by MacBook Pro on 21.02.2025.
//

import Foundation

struct GameResult {
    let correct: Int
    let total: Int
    let date: Date

    func isBetterThan(_ another: GameResult) -> Bool {
        correct > another.correct
    }
}
