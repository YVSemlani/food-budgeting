import SwiftUI

struct ContentView: View {
    @StateObject private var budgetManager = BudgetManager()
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            BudgetInputView()
                .tabItem {
                    Label("Budget", systemImage: "dollarsign.circle")
                }
                .tag(0)
            
            MealInputView()
                .tabItem {
                    Label("Add Meal", systemImage: "fork.knife")
                }
                .tag(1)
            
            StatisticsView()
                .tabItem {
                    Label("Statistics", systemImage: "chart.bar")
                }
                .tag(2)
        }
        .accentColor(.blue)
        .environmentObject(budgetManager)
        .animation(.easeInOut, value: selectedTab)
        .transition(.slide)
    }
}