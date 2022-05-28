//
//  PlayCardView.swift
//  PairCard
//
//  Created by Fred Xin on 5/16/22.
//

import SwiftUI

struct PlayCardView: View {
    private var cardManager = CardManager()
    private var game: Game = Game()

    @EnvironmentObject var globalData: GlobalData

    @State private var cards: [Card]
    @State private var opponent = Opponent.bug
    @State private var userCount: Int = 0
    @State private var cpuCount: Int = 0
    @State private var userBg: Color = Color.gray
    @State private var cpuBg: Color = Color.gray
    @State private var playButton: String = "play.rectangle.fill"
    @State private var title: String = "Are you smarter than a"
    @State private var titleColor: Color = Color.white
    
    init() {
        _cards = State(initialValue: self.cardManager.shafferCardPairs(deckSize: 36))
    }
 
    var body: some View {
        
        VStack {
            Spacer()
            VStack {
                HStack {
                    Image(systemName: "person.fill")
                    Text(title)
                        .onReceive(globalData.$cardCount) {
                            cards = self.cardManager.shafferCardPairs(deckSize: $0)
                        }
                }
                Picker("Opponent", selection: $opponent) {
                    Image(systemName: "ladybug.fill")
                                .tag(Opponent.bug)
                    Image(systemName: "tortoise.fill")
                                .tag(Opponent.tortoise)
                    Image(systemName: "hare.fill")
                                .tag(Opponent.hare)
                    Image(systemName: "person.crop.rectangle.fill")
                                .tag(Opponent.human)
                    Image(systemName: "desktopcomputer")
                                .tag(Opponent.cpu)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding([.leading, .bottom, .trailing])
                
            }
            Spacer()
            
            ForEach (0..<globalData.vSize, id: \.self) { vIdx in
                HStack {
                    ForEach (0..<globalData.hSize, id: \.self) { idx in
                        Button(
                            action: {
                                let idx = globalData.hSize*vIdx + idx
                                if (game.gameState == GameState.user && game.playStatus != PlayState.secondCard && cards[idx].state == CardState.selectable) {
                                    userAction(i: idx)
                                }
                            },
                            label: {
                                Image(cards[vIdx*globalData.hSize + idx].imageName)
                            }
                        )
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "person.fill")
                    Text(String(userCount)).font(.title).foregroundColor(Color.green).padding(.top, 1.0)
                }.padding().background(userBg).cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                
                Spacer()
                Button(
                    action: {
                        if (game.gameState == GameState.notstarted || game.gameState == GameState.ended) {
                            print("card count: \(globalData.cardCount)")
                            startGame(count: globalData.cardCount)
                            playButton = "pause.rectangle.fill"
                            userCount = game.userList.count
                            cpuCount = game.cpuList.count
                            cpuAction()
                        } else {
                            playButton = "play.rectangle.fill"
                            game.endGame()
                        }
                    },
                    label: {
                        Image(systemName: playButton)
                            .resizable()
                            .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                    }
                )
                Spacer()
                
                VStack {
                    Image(systemName: opponent.imageName)
                    Text(String(cpuCount)).font(.title).foregroundColor(Color.purple).padding(.top, 1.0)
                }.padding().background(cpuBg).cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                Spacer()
            }.padding(.bottom)
            
            Spacer()
        }
    }

    func startGame(count: Int) {
        cards = cardManager.shafferCardPairs(deckSize: count)
        for card in cards {
            card.state = .selectable
            card.setImageName()
        }
        title = "Are you smarter than a"
        titleColor = Color.white
        game.startGame(opponent: opponent, cardCount: globalData.cardCount)
    }
    
    func cpuAction() -> Void {
        cpuBg = Color.yellow
        userBg = Color.gray
        if (game.gameState == GameState.cpu) {
            var i = game.randCard()
            while (i == game.firstCardIdx) {
                let idx = Int.random(in: 0...game.availabeList.count-1)
                i = game.availabeList[idx]
            }
            print("i = \(i)")
            setCardStatus(card: cards[i], status: CardState.selected)
            cpuBg = Color.gray
            cpuBg = Color.yellow
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                let st = game.openCard(cardIdx: i, cardNum: cards[i].number, globalData: globalData)
                if (st == PlayState.match) {
                    setCardStatus(card: cards[i], status: CardState.opponent)
                    setCardStatus(card: cards[game.firstCardIdx], status: CardState.opponent)
                    cpuCount = game.cpuList.count
                    game.playStatus = .firstCard
                    cpuAction()
                    if (game.availabeList.count == 0) {
                        endGame()
                    }
                    print("available count: \(game.availabeList.count)")
                } else if (st == PlayState.noMatch) {
                    setCardStatus(card: cards[i], status: CardState.selectable)
                    setCardStatus(card: cards[game.firstCardIdx], status: CardState.selectable)
                    cpuBg = Color.gray
                    userBg = Color.yellow
                    game.playStatus = .firstCard
                } else {
                    cpuAction()
                }
            })
        }
    }
    
    func userAction(i: Int) -> Void {
        setCardStatus(card: cards[i], status: CardState.selected)
        userBg = Color.white
        userBg = Color.secondary
        let st = game.openCard(cardIdx: i, cardNum: cards[i].number, globalData: globalData)
        if (st != PlayState.firstCard) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                if (st == PlayState.match) {
                    setCardStatus(card: cards[i], status: CardState.you)
                    setCardStatus(card: cards[game.firstCardIdx], status: CardState.you)
                    userCount = game.userList.count
                    game.playStatus = .firstCard
                    if (game.availabeList.count == 0) {
                        endGame()
                    }
                    print("available count: \(game.availabeList.count)")
                } else if (st == PlayState.noMatch) {
                    setCardStatus(card: cards[i], status: CardState.selectable)
                    setCardStatus(card: cards[game.firstCardIdx], status: CardState.selectable)
                    game.playStatus = .firstCard
                    cpuAction()
                }
            })
        }
    }
    
    func endGame() -> Void {
        game.endGame()
        playButton = "play.rectangle.fill"
        if (game.cpuList.count > game.userList.count) {
            title = "May want to learn from a"
            titleColor = Color.red
        } else if (game.cpuList.count < game.userList.count) {
            title = "You are smater than a"
            titleColor = Color.green
        } else {
            title = "You are a"
            titleColor = Color.yellow
        }
    }
    
    func setCardStatus(card: Card, status: CardState) -> Void {
        card.state = status
        card.setImageName()
    }
}

struct PlayCardView_Previews: PreviewProvider {
    static var previews: some View {
        PlayCardView()
    }
}
