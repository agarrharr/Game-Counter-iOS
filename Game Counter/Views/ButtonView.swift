//
//  ButtonView.swift
//  Game Counter
//
//  Created by Adam Garrett-Harris on 9/8/21.
//

import SwiftUI
import CoreData

let waitTime = 1300
let animationTime = 500

struct ButtonView: View {
    var score: Score
    var amount: Int
    @Binding var currentAddend: Int
    @State private var addends: [UUID: Int] = [:]
    @State private var currentLocalAddend = 0
    
    private var addendsArray: [(id: UUID, addend: Int)] {
        var array: [(id: UUID, addend: Int)] = []

        for (key, value) in addends {
            array.append((id: key, addend: value))
        }
        return array
    }
    
    @Environment(\.managedObjectContext) private var viewContext: NSManagedObjectContext
    
    var body: some View {
        ZStack {
            Button {
                currentAddend += amount
                currentLocalAddend = currentAddend
                let uuid = UUID()
                let uuidSnapshot = uuid
                let addendsSnapshot = addends.keys // snapshot BEFORE adding the new addend
                addends[uuid] = currentAddend
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(waitTime)) {
                    if addends[uuidSnapshot] != nil {
                        score.value += Int16(addends[uuidSnapshot]!)
                        currentAddend = 0
                        currentLocalAddend = 0
                        addends[uuidSnapshot] = nil
                    }
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(animationTime - 200)) {
                    if addends.count > 1  {
                        addendsSnapshot.forEach { id in
                            addends[id] = nil
                        }
                    }
                }
                
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            } label: {
                Text("\(amount >= 0 ? "+" : "")\(amount)")
                    .frame(minWidth: 20, maxWidth: .infinity, minHeight: 44)
                    .border(Color.accentColor, width: 1)
            }
            .onChange(of: currentAddend) { newValue in
                if (newValue != currentLocalAddend) {
                    addends.removeAll()
                }
            }
            
            ForEach(addendsArray, id: \.id) {
                AnimatedNumberView(number: $0.addend, animationTime: animationTime)
            }
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        let score = Score(context: context)
        
        VStack {
            ButtonView(score: score, amount: 5, currentAddend: .constant(0))
            ButtonView(score: score, amount: 1, currentAddend: .constant(0))
            ButtonView(score: score, amount: 0, currentAddend: .constant(0))
            ButtonView(score: score, amount: -1, currentAddend: .constant(0))
            ButtonView(score: score, amount: -5, currentAddend: .constant(0))
        }
    }
}
