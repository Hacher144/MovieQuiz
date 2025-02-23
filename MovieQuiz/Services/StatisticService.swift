//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by MacBook Pro on 21.02.2025.
//

import Foundation

final class StatisticService {
    private let storage: UserDefaults = .standard
    private enum Keys: String {
        case correctBestGame
        case totalBestGame
        case dateBestGame
        case gamesCount
        case allGamesCorrectAnswers
    }
}

extension StatisticService: StatisticServiceProtocol {
    var gamesCount: Int {
        get {
            storage.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameResult {
        get {
            let correct = storage.integer(forKey: Keys.correctBestGame.rawValue)
            let total = storage.integer(forKey: Keys.totalBestGame.rawValue)
            let date = DateFormatter.defaultDateTime.date(from: storage.string(forKey: Keys.dateBestGame.rawValue) ?? Date().dateTimeString) ?? Date()
            
            return GameResult(correct: correct, total: total, date: date)
        }
        set {
            storage.set(newValue.correct, forKey: Keys.correctBestGame.rawValue)
            storage.set(newValue.total, forKey: Keys.totalBestGame.rawValue)
            storage.set(newValue.date.dateTimeString, forKey: Keys.dateBestGame.rawValue)
        }
    }
    
    var totalAccuracy: Double {
        let allGamesCorrectAnswers = storage.integer(forKey: Keys.allGamesCorrectAnswers.rawValue)
        let amountOfGames = storage.integer(forKey: Keys.gamesCount.rawValue)
        
        return (Double(allGamesCorrectAnswers) / Double(amountOfGames * 10)) * 100
    }
    
    func store(correct count: Int, total amount: Int) {
        if count > bestGame.correct {
            bestGame = GameResult(correct: count, total: amount, date: Date())
        }
        
        let totalPlayedGames = storage.integer(forKey: Keys.gamesCount.rawValue) + 1
        storage.set(totalPlayedGames, forKey: Keys.gamesCount.rawValue)
        
        let totalCorrectAnswers = storage.integer(forKey: Keys.allGamesCorrectAnswers.rawValue) + count
        storage.set(totalCorrectAnswers, forKey: Keys.allGamesCorrectAnswers.rawValue)
    }
}
