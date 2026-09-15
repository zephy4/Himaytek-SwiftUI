import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                Home(onSeeAllFavorites: { selectedTab = 1 })
            }.tabItem {
                Label("Home", systemImage: "house")
            }
            .tag(0)
            NavigationStack {
                FavoritesView()
            }.tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
            .tag(1)
            NavigationStack {
                BookingsView()
            }.tabItem {
                Label("Bookings", systemImage: "calendar.badge")
            }
            .tag(2)
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle.fill")
            }
            .tag(3)
        }
    }
}

#Preview {
    HomeView()
}
