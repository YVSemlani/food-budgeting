import SwiftUI

struct BudgetInputView: View {
    @EnvironmentObject var budgetManager: BudgetManager
    @State private var budgetInput: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Set Your Budget")
                .font(.largeTitle)
                .fontWeight(.bold)
                .animation(.spring(), value: budgetManager.totalBudget)
            
            TextField("Enter total budget", text: $budgetInput)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(10)
                .animation(.easeInOut, value: budgetInput)
            
            Button(action: setBudget) {
                Text("Set Budget")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .animation(.spring(), value: budgetInput)
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .transition(.move(edge: .leading))
    }
    
    private func setBudget() {
        guard let budget = Double(budgetInput), budget > 0 else {
            alertMessage = "Please enter a valid budget amount."
            showAlert = true
            return
        }
        budgetManager.totalBudget = budget
        budgetInput = ""
    }
}