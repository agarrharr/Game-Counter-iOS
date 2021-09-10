//
//  ContentView.swift
//  Game Counter
//
//  Created by Adam Garrett-Harris on 9/8/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [],
        animation: .default) private var scores: FetchedResults<Score>

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(scores) { score in
                    CounterView(score: score)
                        .padding(.bottom)
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            Score.create(in: viewContext)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { scores[$0] }.forEach{
                Score.delete($0, in: viewContext)
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
