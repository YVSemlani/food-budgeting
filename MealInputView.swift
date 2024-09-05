import SwiftUI

struct MealInputView: View {
    @EnvironmentObject var budgetManager: BudgetManager
    @State private var mealName = ""
    @State private var mealCost = ""
    @State private var restaurant = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        Form {
            Section(header: Text("Meal Details")) {
                TextField("Meal Name", text: $mealName)
                    .animation(.easeInOut, value: mealName)
                TextField("Cost", text: $mealCost)
                    .keyboardType(.decimalPad)
                    .animation(.easeInOut, value: mealCost)
                TextField("Restaurant", text: $restaurant)
                    .animation(.easeInOut, value: restaurant)
            }
            
            Section {
                Button(action: addMeal) {
                    Text("Add Meal")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .animation(.spring(), value: mealName)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .transition(.move(edge: .trailing))
    }
    
    private func addMeal() {
        guard !mealName.isEmpty else {
            alertMessage = "Please enter a meal name."
            showAlert = true
            return
        }
        
        guard let cost = Double(mealCost), cost > 0 else {
            alertMessage = "Please enter a valid cost."
            showAlert = true
            return
        }
        
        guard !restaurant.isEmpty else {
            alertMessage = "Please enter a restaurant name."
            showAlert = true
            return
        }
        
        let meal = Meal(id: UUID(), name: mealName, cost: cost, restaurant: restaurant, date: Date())
        budgetManager.addMeal(meal)
        mealName = ""
        mealCost = ""
        restaurant = ""
    }
}