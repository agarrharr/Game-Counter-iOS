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
    @State private var currentAddend = 0
    
    @Environment(\.managedObjectContext) private var viewContext: NSManagedObjectContext
    
    var body: some View {
        VStack {
            Text("\(score.value)")
                .font(.system(size: 80))
                .foregroundColor(.accentColor)
            HStack (spacing: 0) {
                ButtonView(score: score, amount: -1, currentAddend: $currentAddend)
                ButtonView(score: score, amount: -5, currentAddend: $currentAddend)
                ButtonView(score: score, amount: 5, currentAddend: $currentAddend)
                ButtonView(score: score, amount: 1, currentAddend: $currentAddend)
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
