import SwiftUI

struct SettingsView: View {
    @StateObject var vm = SettingsViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            NewCommonAppbar(title: "Settings")
            ScrollView {
                SettingsItem(vm: vm)
                deleteAccount
            }
            copyRights
        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden()
        .navigationDestination(for: SettingsDestination.self) { destination in
            switch destination {
            case .terms:
                SettingsPageView(title: "Terms of Services")
            case .privacy:
                SettingsPageView(title: "Privacy Policy")
            case .support:
                SupportAndHelpCenter()
            case .ticket:
                SubmitATicket()
            }
        }
    }

    //MARK: Components

    private var deleteAccount: some View {
        VStack(alignment: .leading) {
            Text("Account")
                .font(.custom("Urbanist-Regular", size: 16))

            HStack {
                Image(systemName: "trash")
                Text("Delete Account")
                    .font(.custom("Urbanist-Regular", size: 14))
                Spacer()
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.white)

                    .overlay {
                        Button {
                            vm.deleteConfirmation.toggle()

                        } label: {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.black)
                        }
                    }
            }.padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 350, height: 56)
                        .foregroundStyle(.gray.opacity(0.1))
                        .cornerRadius(10)
                )
        }
    }

    private var copyRights: some View {
        VStack {
            Text("Himaytek App v2.1.0")
                .font(.custom("Urbanist-Regular", size: 12))

            Text("© 2025 Himaytek. All rights reserved.")
                .font(.custom("Urbanist-Light", size: 12))

        }
    }

    struct SettingsItem: View {
        @ObservedObject var vm: SettingsViewModel

        var body: some View {
            VStack(alignment: .leading) {
                Text("Legal & Support")
                    .font(.custom("Urbanist-Regular", size: 16))
                ForEach(vm.settingsItems) { item in
                    NavigationLink(value: item.destination) {
                        HStack {
                            Image(systemName: item.image ?? "")
                                .foregroundStyle(.black)
                            Text(item.title ?? "")
                                .font(.custom("Urbanist-Regular", size: 14))
                                .foregroundStyle(.black)
                            Spacer()
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.white)
                                .overlay {
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.black)
                                }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 350, height: 56)
                                .foregroundStyle(.gray.opacity(0.1))
                                .cornerRadius(10)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

struct SettingsPageView: View {
    let title: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                }
                Spacer()
                Text(title)
                    .font(.custom("Urbanist-Regular", size: 18))
                Spacer()
                Image(systemName: "chevron.left")
                    .hidden()
            }
            Text("Content coming soon.")
                .font(.custom("Urbanist-Regular", size: 14))
                .foregroundStyle(.gray)
            Spacer()
        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
