//
//  CardGame.swift
//  PairCard
//
//  Created by Fred Xin on 5/16/22.
//

import Foundation

class GlobalData: ObservableObject {
    @Published var cardCount: Int
    @Published var vSize: Int
    @Published var hSize: Int
    @Published var numBug = 0
    @Published var numTortoise = 2
    @Published var numHare = 4
    @Published var numHuman = 8
    @Published var numCpu = 36
    
    init() {
        self.cardCount = 16
        self.vSize = 4
        self.hSize = 4
    }
}

class Game {
    var gameState = GameState.notstarted
    var availabeList: [Int] = Array(0...35)
    var userList: [Int] = []
    var cpuList: [Int] = []
    var firstCardIdx: Int = -1
    var playStatus: PlayState = .firstCard
    private var firstCardVal: Int = -1
    private var cardMem: [Int: Int] = [Int: Int]()
    private var dupMem: [Int: Int] = [Int: Int]()
    private var opponent: Opponent = .bug
    
    func startGame(opponent: Opponent, cardCount: Int) -> Void {
        self.opponent = opponent
        gameState = GameState.cpu
        availabeList = Array(0...cardCount-1)
        userList = []
        cpuList = []
        firstCardIdx = -1
        firstCardVal = -1
        cardMem.removeAll()
        dupMem.removeAll()
    }
    
    func endGame() -> Void {
        gameState = GameState.ended
    }
    
    private func updateMem(cardIdx: Int, cardNum: Int, globalData: GlobalData) -> Void {
        switch (opponent) {
            case .tortoise:
                resetMem(max: globalData.numTortoise, cardIdx: cardIdx, cardNum: cardNum)
            case .hare:
                resetMem(max: globalData.numHare, cardIdx: cardIdx, cardNum: cardNum)
            case .human:
                resetMem(max: globalData.numHuman, cardIdx: cardIdx, cardNum: cardNum)
            case .cpu:
                resetMem(max: globalData.numCpu, cardIdx: cardIdx, cardNum: cardNum)
            default:
                resetMem(max: globalData.numBug, cardIdx: cardIdx, cardNum: cardNum)
        }
    }
    
    private func resetMem(max: Int, cardIdx: Int, cardNum: Int) -> Void {
        setDupMem(max: max, idx: cardIdx, value: cardNum)
        setDupMem(max: max, idx: firstCardIdx, value: firstCardVal)
    }

    private func setDupMem(max: Int, idx: Int, value: Int) -> Void {
        if (cardMem.count > max) {
            let key = Array(cardMem)[0].key
            cardMem.removeValue(forKey: key)
        }
        if let val = cardMem[value] {
            if (val != idx) {
                dupMem[value] = val
            }
        }
        cardMem[value] = idx
    }
    
    func openCard(cardIdx: Int, cardNum: Int, globalData: GlobalData) -> PlayState {
        if (firstCardVal == -1) {
            firstCardVal = cardNum
            firstCardIdx = cardIdx
            playStatus = .firstCard
            return .firstCard
        } else {
            playStatus = .secondCard
            updateMem(cardIdx: cardIdx, cardNum: cardNum, globalData: globalData)

            if (firstCardVal == cardNum) {
                availabeList.removeAll(where: {$0 == cardIdx || $0 == firstCardIdx})
                if (gameState == .cpu) {
                    cpuList.append(firstCardIdx)
                    cpuList.append(cardIdx)
                } else {
                    userList.append(firstCardIdx)
                    userList.append(cardIdx)
                }
                cardMem.removeValue(forKey: firstCardVal)
                dupMem.removeValue(forKey: firstCardVal)
                firstCardVal = -1
                if (availabeList.count == 0) {
                    gameState = .ended
                }
                return .match
            } else {
                gameState = gameState == .cpu ? .user : .cpu
                firstCardVal = -1
                return .noMatch
            }
        }
    }
    
    func randCard() -> Int {
        if (firstCardVal == -1) {
            if (dupMem.count > 0) {
                let key = Array(dupMem)[0].key
                let val = Array(dupMem)[0].value
                dupMem.removeValue(forKey: key)
                print("from dupMem")
                return val
            }
        } else if let valIdx = cardMem[firstCardVal] {
            print("from cardMem")
            return valIdx
        }
        
        let arr = cardMem.values
        let tmpArr = Array(availabeList).filter({ !arr.contains($0) })
        if (tmpArr.count == 0) {
            print("from availabeList")
            return availabeList[Int.random(in: 0...availabeList.count-1)]
        } else {
            print("from tmpArr")
            return tmpArr[Int.random(in: 0...tmpArr.count-1)]
        }
    }
    
}
