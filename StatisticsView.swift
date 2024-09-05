import SwiftUI
import Charts

struct StatisticsView: View {
    @EnvironmentObject var budgetManager: BudgetManager
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Statistics")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .padding(.top)
                
                AverageCostPerMealView()
                    .transition(.scale.combined(with: .opacity))
                
                RestaurantAverageCostsView()
                    .transition(.scale.combined(with: .opacity))
                
                MonthlySpendingView()
                    .transition(.scale.combined(with: .opacity))
                
                SemesterSpendingView()
                    .transition(.scale.combined(with: .opacity))
            }
            .padding()
        }
        .background(Color(UIColor.systemBackground))
        .transition(.move(edge: .trailing))
    }
}

struct AverageCostPerMealView: View {
    @EnvironmentObject var budgetManager: BudgetManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Average Cost per Meal")
                .font(.headline)
                .foregroundColor(.secondary)
            Text("$\(budgetManager.averageCostPerMeal(), specifier: "%.2f")")
                .font(.system(size: 36, weight: .bold, design: .rounded))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(16)
        .animation(.spring(), value: budgetManager.averageCostPerMeal())
    }
}

struct RestaurantAverageCostsView: View {
    @EnvironmentObject var budgetManager: BudgetManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Average Cost per Restaurant")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Chart {
                ForEach(budgetManager.averageCostPerRestaurant(), id: \.0) { restaurant, avgCost in
                    BarMark(
                        x: .value("Restaurant", restaurant),
                        y: .value("Average Cost", avgCost)
                    )
                    .foregroundStyle(Color.blue.gradient)
                }
            }
            .frame(height: 200)
        }
        .padding()
        .background(Color.green.opacity(0.1))
        .cornerRadius(16)
        .animation(.spring(), value: budgetManager.averageCostPerRestaurant())
    }
}

struct MonthlySpendingView: View {
    @EnvironmentObject var budgetManager: BudgetManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Monthly Spending")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Chart {
                ForEach(budgetManager.monthlySpending(), id: \.0) { month, spending in
                    LineMark(
                        x: .value("Month", month),
                        y: .value("Spending", spending)
                    )
                    .foregroundStyle(Color.orange.gradient)
                }
            }
            .frame(height: 200)
        }
        .padding()
        .background(Color.orange.opacity(0.1))
        .cornerRadius(16)
        .animation(.spring(), value: budgetManager.monthlySpending())
    }
}

struct SemesterSpendingView: View {
    @EnvironmentObject var budgetManager: BudgetManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Semester Spending")
                .font(.headline)
                .foregroundColor(.secondary)
            
            HStack {
                Text("$\(budgetManager.semesterSpending(), specifier: "%.2f")")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                Text("/ $\(budgetManager.totalBudget, specifier: "%.2f")")
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
            
            ProgressView(value: budgetManager.semesterSpending(), total: budgetManager.totalBudget)
                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                .frame(height: 20)
        }
        .padding()
        .background(Color.purple.opacity(0.1))
        .cornerRadius(16)
        .animation(.spring(), value: budgetManager.semesterSpending())
    }
}