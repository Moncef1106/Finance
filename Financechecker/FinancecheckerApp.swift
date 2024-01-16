import SwiftUI

@main
struct FinanceApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    DashboardView()
                        .navigationBarItems(trailing: NavigationLink(destination: AddTransactionView()) {
                            Image(systemName: "plus.circle")
                        })
                }
                .tabItem {
                    Label("Dashboard", systemImage: "house")
                }

                SettingsView() 
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        }
    }
}
