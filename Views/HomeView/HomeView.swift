import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    var body: some View {
        Text("\(vm.username)")
    }
}

#Preview {
    HomeView()
}
