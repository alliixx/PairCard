//
//  PlayCard.swift
//  PairCard
//
//  Created by Fred Xin on 5/3/22.
//

import Foundation


enum CardState: String {
    case inactive, selectable, selected, you, opponent
}

enum GameState: String {
    case notstarted, cpu, user, ended
}

enum PlayState: String {
    case firstCard, secondCard, match, noMatch
}

enum Opponent: String, CaseIterable, Identifiable {
    case bug
    case tortoise
    case hare
    case human
    case cpu

    var id: String { self.rawValue }
    var imageName: String {
        switch (self.rawValue) {
            case "bug": return "ladybug.fill"
            case "tortoise": return "tortoise.fill"
            case "hare": return "hare.fill"
            case "human": return "person.crop.rectangle.fill"
            default: return "desktopcomputer"
        }
    }
}

class Card {
    var number: Int
    var name: String
    var state: CardState
    var imageName: String

    init(number:Int, name: String, state: CardState) {
        self.number = number
        self.name = name
        self.state = state
        self.imageName = "gray_back"
    }
    
    func setImageName() -> Void {
        switch state {
            case .selectable: self.imageName = "blue_back"
            case .selected: self.imageName = name
            case .you: self.imageName = "green_back"
            case .opponent: self.imageName = "purple_back"
            default: return self.imageName = "gray_back"
        }
    }
}

class CardManager {
    var cardsMap:[[String]] = [
        ["AC", "AD", "AH", "AS"],
        ["2C", "2D", "2H", "2S"],
        ["3C", "3D", "3H", "3S"],
        ["4C", "4D", "4H", "4S"],
        ["5C", "5D", "5H", "5S"],
        ["6C", "6D", "6H", "6S"],
        ["7C", "7D", "7H", "7S"],
        ["8C", "8D", "8H", "8S"],
        ["9C", "9D", "9H", "9S"],
        ["10C", "10D", "10H", "10S"],
        ["JC", "JD", "JH", "JS"],
        ["QC", "QD", "QH", "QS"],
        ["KC", "KD", "KH", "KS"]
    ]
    
    init() {
    }
    
    func shafferCardPairs(deckSize: Int) -> [Card] {
        var cards = [Card]()
        for idx in (0..<deckSize/2) {
            let cardNum = idx < 13 ? idx : Int.random(in: 0...12)
            let cardNames = cardsMap[cardNum]
            let cardPattern1 = Int.random(in: 0...3)
            var cardPattern2 = Int.random(in: 0...2)
            cardPattern2 = cardPattern2 < cardPattern1 ? cardPattern2 : cardPattern2 + 1
            cards.append(Card(number: cardNum+1, name: cardNames[cardPattern1], state: CardState.inactive))
            cards.append(Card(number: cardNum+1, name: cardNames[cardPattern2], state: CardState.inactive))
        }
        cards.shuffle()
        return cards
    }
}

