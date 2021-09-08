//
//  CounterView.swift
//  Game Counter
//
//  Created by Adam Garrett-Harris on 9/8/21.
//

import CoreData
import SwiftUI

struct CounterView: View {
    @ObservedObject var score: Score
    
    @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext
    
    var body: some View {
        VStack {
            Text("\(score.value)")
                .font(.system(size: 80))
                .foregroundColor(.accentColor)
            HStack (spacing: 0) {
                Button {
                    Score.add(score, number: -1, in: viewContext)
                } label: {
                    Text("-1")
                        .frame(minWidth: 20, maxWidth: .infinity, minHeight: 44)
                        .border(Color.accentColor, width: 1)
                }
                
                Button {
                    Score.add(score, number: -5, in: viewContext)
                } label: {
                    Text("-5")
                        .frame(minWidth: 20, maxWidth: .infinity, minHeight: 44)
                        .border(Color.accentColor, width: 1)
                }
                
                Button {
                    Score.add(score, number: 5, in: viewContext)
                } label: {
                    Text("5")
                        .frame(minWidth: 20, maxWidth: .infinity, minHeight: 44)
                        .border(Color.accentColor, width: 1)
                }
                
                Button {
                    Score.add(score, number: 1, in: viewContext)
                } label: {
                    Text("1")
                        .frame(minWidth: 20, maxWidth: .infinity, minHeight: 44)
                        .border(Color.accentColor, width: 1)
                }
            }
        }
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        let score = Score(context: context)
        score.value = 1
        
        return CounterView(score: score)
    }
}
