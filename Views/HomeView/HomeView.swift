import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    var body: some View {
        TabView {
            NavigationStack {
                Home()
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
                FavoritesView()
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
        }
        .labelsHidden()
    }
}

#Preview {
    HomeView()
}
