import PhotosUI
import SwiftUI

struct ProfileView: View {
    @StateObject var vm = ProfileViewModel()
    @State private var profileImage: UIImage?
    @State private var showPhotoPicker = false
    @State private var selectedPhotoItem: PhotosPickerItem?

    var body: some View {
        ScrollView {
            VStack {
                appBar
                profileAvatar
                userDetails
                profileItems(
                    text: "Manage Payment Methods",
                    icon: "creditcard",
                    isLanguage: false
                )
                profileItems(
                    text: "Notification Preferences",
                    icon: "bell",
                    isLanguage: false
                )
                profileItems(
                    text: "Language",
                    icon: "translate",
                    isLanguage: true
                )
                logoutButton
            }
            .padding(.horizontal, 20)
        }
        .photoPicker(
            isPresented: $showPhotoPicker,
            image: $profileImage,
            selectedItem: $selectedPhotoItem
        )
    }

    var appBar: some View {
        HStack(alignment: .center) {
            Text("Profile").font(
                .custom("Urbanist-Regular", fixedSize: 16)
            )
            Spacer()
            Button(action: {
                
            }) {
                Image(systemName: "gear").foregroundColor(.primary)
                    .font(.title3)
            }
        }
    }

    var profileAvatar: some View {
        Circle()
            .frame(width: 140, height: 140)
            .overlay {
                Group {
                    if let profileImage {
                        Image(uiImage: profileImage)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Image("defaultProfile")
                            .resizable()
                    }
                }
                .clipShape(Circle())
            }
    }

    var userDetails: some View {
        VStack(spacing: 5) {
            Text("\(vm.username)").font(.custom("Urbanist-SemiBold", size: 20))
            Text("\(vm.email)").font(.custom("Urbanist-Regular", size: 14))
            Button("Edit Profile") {
                showPhotoPicker = true
            }
            .font(.custom("Urbanist-Bold", size: 14))
        }
    }

    var logoutButton: some View {

        Button {
            vm.logout()
        } label: {
            HStack {
                Image(systemName: "door.left.hand.open")
                    .font(.title2)
                    .foregroundStyle(.red)
                Text("Log out")
                    .font(.custom("Urbanist-Regular", size: 18))
                    .foregroundStyle(.red)
            }
            .padding()
            .padding(.horizontal, 120)
            .background(
                RoundedRectangle(cornerRadius: 10).stroke(.red, lineWidth: 1)
            )
            .foregroundStyle(.clear)

        }

    }

    struct profileItems: View {
        @State var text: String
        @State var icon: String
        @State var isLanguage: Bool
        @State var isOn: Bool = false
        var body: some View {
            HStack {
                Image(systemName: icon)
                    .font(.callout)
                Text(text)
                    .font(.custom("Urbanist-Regular", size: 14))
                Spacer(minLength: 40)
                if isLanguage {
                    Toggle(isOn: $isOn) {
                        EmptyView()
                    }
                } else {
                    Image(systemName: "chevron.forward")
                        .font(.callout)
                }
            }.padding()
                .padding(.vertical, 5)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.gray.opacity(0.1))
                }
        }
    }
}

#Preview {
    ProfileView()
}
