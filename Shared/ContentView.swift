//
//  ContentView.swift
//  Shared
//
//  Created by Sam Warnick on 11/14/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Bucket.name, ascending: true)],
        animation: .default)
    private var buckets: FetchedResults<Bucket>
    private var total: Decimal {
        buckets.reduce(NSDecimalNumber(value: 0)) { total, bucket in
            total.adding(bucket.balance!)
        }.decimalValue
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(buckets) { bucket in
                    HStack{
                        Text(bucket.name!)
                        Text(bucket.goal!.decimalValue.formatted(.currency(code: "USD")))
                        Text(bucket.balance!.decimalValue.formatted(.currency(code: "USD")))
                        Spacer()
                    }
                    .padding(.vertical)
                    .background(
                        Rectangle()
                            .fill(.green)
                            .scaleEffect(x: bucket.percentCompleted, y: 1, anchor: .leading)
                    )
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationTitle(Text(total.formatted(.currency(code: "USD"))))
        }
    }

    private func addItem() {
        withAnimation {
            let sampleBuckets = ["🏝 Vacation", "💰 Emergency", "📺 TV"]
            sampleBuckets.forEach {
                let bucket = Bucket(context: viewContext)
                bucket.name = $0
                bucket.id = UUID()
                var goal = Double.random(in: 500..<5000)
                goal = round(goal / 500) * 500
                bucket.goal = NSDecimalNumber(string: goal.formatted(.number.precision(.fractionLength(2)).grouping(.never)))
                
                var transactions: [Transaction] = []
                for n in 1...10 {
                    let transaction = Transaction(context: viewContext)
                    transaction.id = UUID()
                    transaction.bucket = bucket
                    transaction.date = Calendar.current.date(byAdding: .day, value: -n, to: Date())
                    var amount = Double.random(in: -500..<1000)
                    amount = round(amount / 50) * 50
                    transaction.amount = NSDecimalNumber(string: amount.formatted(.number.precision(.fractionLength(2)).grouping(.never)))
                    transactions.append(transaction)
                }
                bucket.balance = transactions.reduce(NSDecimalNumber(value: 0)) { total, transaction in
                    total.adding(transaction.amount!)
                }
                if bucket.balance!.compare(0) == .orderedAscending {
                    bucket.balance = NSDecimalNumber.zero
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
