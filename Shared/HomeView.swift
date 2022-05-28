//
//  HomeView.swift
//  PairCard
//
//  Created by Fred Xin on 5/16/22.
//

import SwiftUI

struct Faq: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    var items: [Faq]?

    // some example websites
    static let howto1 = Faq(name: "You are playing against computer.  Computer will open two cards, then it is your turn.  If two cards match, one wins two points, and it is still one's turn.  The game goes on until all cards are gone.",
                           icon: "1.circle")
    static let howto2 = Faq(name: "The difficult level goes up when select bug, tortoise, hale, person, or computer.",
                           icon: "2.circle")
    
    static let setting1 = Faq(name: "Change difficulty level", icon: "1.circle")
    static let setting2 = Faq(name: "Customize number of cards to play with", icon: "2.circle")

    static let story1 = Faq(name: "Story about the game.", icon: "rectangle.and.pencil.and.ellipsis")

    static let feedback1 = Faq(name: "Email: xin.sisters@gmail.com", icon: "envelope")
    static let feedback2 = Faq(name: "Your feedback is welcome.", icon: "envelope")

    // some example groups
    static let howto = Faq(name: "How to play", icon: "star", items: [Faq.howto1, Faq.howto2])
    static let setting = Faq(name: "Change settings", icon: "gearshape", items: [Faq.setting1, Faq.setting2])
    static let story = Faq(name: "Stories about the game", icon: "hand.thumbsup", items: [Faq.feedback1, Faq.feedback2])
    static let feedback = Faq(name: "Feedbacks", icon: "hand.thumbsup", items: [Faq.feedback1, Faq.feedback2])
}

struct HomeView: View {
    let items: [Faq] = [.howto, .setting, .story, .feedback]

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                HStack {
                    Image("playing")
                    Spacer()
                    Text("PairCard is a game my family used to play when I was a kid.  It helped me greatly on memory training.  Hope you will enjoy it too."
                    )
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .font(.headline)
                .cornerRadius(16)
                Spacer()
            }
            
            Spacer()
            
            List(items, children: \.items) { row in
                Image(systemName: row.icon)
                Text(row.name)
            }
            .padding()
            
            Spacer()
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
