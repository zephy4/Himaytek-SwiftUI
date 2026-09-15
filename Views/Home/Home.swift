import SwiftUI

struct Home: View {

    @StateObject var vm = HomeVModel()
    var onSeeAllFavorites: (() -> Void)? = nil

    var body: some View {

        ScrollView {
            VStack(alignment: .leading) {
                appbar
                searchBar
                offerBanner()
                categoriesSection
                favSection
            }.padding(.horizontal, 20)
        }
    }

    private var appbar: some View {
        HStack {
            Text("goodmornning")
                .font(.custom("Urbanist-Regular", size: 16))
            Spacer()
            Button {
            } label: {
                Image(systemName: "bell.fill")
            }
            Button {
            } label: {
                Image(systemName: "gear")
            }
        }.padding(.top, 10)
    }

    private var searchBar: some View {

        TextField("searchBar", text: $vm.searchEditor)
            .font(.custom("Urbanist-Regular", size: 14))
            .foregroundStyle(.black)
            .padding(.vertical, 16)
            .padding(.leading, 20)
            .background(.gray.opacity(0.07))
            .cornerRadius(12)
            .padding(.vertical, 20)
    }

    private var categoriesSection: some View {
        VStack {
            HStack {
                Text("categories")
                    .font(.custom("Urbanist-Regular", size: 16))
                Spacer()
                NavigationLink("See all") {
                    VendorsView()
                }.font(.custom("Urbanist-Regular", size: 14))
            }

            ScrollView(.horizontal) {
                HStack {
                    ForEach(vm.categories) { item in
                        NavigationLink {
                            VendorsView()
                        } label: {
                            VStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: 125, height: 125)
                                    .foregroundStyle(.gray.opacity(0.1))
                                    .overlay {
                                        Image(
                                            item.avatar
                                                ?? "exclamationmark.triangle.fill"
                                        )
                                    }
                                Text(item.title ?? "N/A")
                                    .font(.custom("Urbanist-Regular", size: 13))
                                    .foregroundStyle(.black)

                            }
                        }

                    }
                }

            }.scrollIndicators(.hidden)

        }
        .padding(.vertical, 10)
    }

    private var favSection: some View {
        VStack {
            HStack {
                Text("Your Favorites")
                    .font(.custom("Urbanist-Regular", size: 16))
                Spacer()
                Button("See all") {
                    onSeeAllFavorites?()
                }
                .font(.custom("Urbanist-Regular", size: 14))
            }
        }
    }
}

struct offerBanner: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("bannerImage")
                .resizable()
                .frame(width: 350, height: 167)
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Text("specialOffer")
                    .font(.custom("Urbanist-Bold", size: 18))
                    .foregroundStyle(.accent)
                Text("Get 20% off on ceramic coating services")
                    .frame(width: 209, alignment: .leading)
                Spacer()
                Button {
                } label: {
                    Text("bookNow")
                        .font(.custom("Urbanist-Regular", size: 14))
                        .padding(.horizontal, 25)
                        .padding(.vertical, 13)
                        .background(.white)
                        .cornerRadius(8)
                }
            }.padding(16)
        }
    }
}

#Preview {
    NavigationStack {
        Home()
    }
}
