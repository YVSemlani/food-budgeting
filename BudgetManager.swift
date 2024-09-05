import Foundation

class BudgetManager: ObservableObject {
    @Published var totalBudget: Double {
        didSet {
            saveBudget()
        }
    }
    @Published var meals: [Meal] {
        didSet {
            saveMeals()
        }
    }
    
    init() {
        self.totalBudget = UserDefaults.standard.double(forKey: "totalBudget")
        if let savedMeals = UserDefaults.standard.data(forKey: "meals"),
           let decodedMeals = try? JSONDecoder().decode([Meal].self, from: savedMeals) {
            self.meals = decodedMeals
        } else {
            self.meals = []
        }
    }
    
    private func saveBudget() {
        UserDefaults.standard.set(totalBudget, forKey: "totalBudget")
    }
    
    private func saveMeals() {
        if let encoded = try? JSONEncoder().encode(meals) {
            UserDefaults.standard.set(encoded, forKey: "meals")
        }
    }
    
    func addMeal(_ meal: Meal) {
        meals.append(meal)
    }
    
    // New methods for calculating statistics
    func averageCostPerMeal() -> Double {
        guard !meals.isEmpty else { return 0 }
        let totalCost = meals.reduce(0) { $0 + $1.cost }
        return totalCost / Double(meals.count)
    }
    
    func averageCostPerRestaurant() -> [(String, Double)] {
        let groupedMeals = Dictionary(grouping: meals, by: { $0.restaurant })
        return groupedMeals.map { (restaurant, meals) in
            let avgCost = meals.reduce(0) { $0 + $1.cost } / Double(meals.count)
            return (restaurant, avgCost)
        }
    }
    
    func monthlySpending() -> [(String, Double)] {
        let calendar = Calendar.current
        let groupedMeals = Dictionary(grouping: meals) { meal in
            let components = calendar.dateComponents([.year, .month], from: meal.date)
            return calendar.date(from: components)!
        }
        return groupedMeals.map { (date, meals) in
            let totalCost = meals.reduce(0) { $0 + $1.cost }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM yyyy"
            return (dateFormatter.string(from: date), totalCost)
        }.sorted { $0.0 < $1.0 }
    }
    
    func semesterSpending() -> Double {
        return meals.reduce(0) { $0 + $1.cost }
    }
}

struct Meal: Identifiable, Codable {
    let id: UUID
    let name: String
    let cost: Double
    let restaurant: String
    let date: Date
}