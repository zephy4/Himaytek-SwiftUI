import SwiftUI

struct VendorsView: View {
    @StateObject var vm = VendorsViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            appBar
            ScrollView {
                categories(vm: vm)
                vendorsList(vm: vm)
            }
        }.task {
            await vm.loadVendors()
        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden()
    }

    //MARK: Components
    private var appBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
            }

            Spacer()
            Text("Vendors")
                .font(
                    .custom(
                        "Urbanist-Regular",
                        size: 18
                    )
                )
            Spacer()
            Button {

            } label: {
                Image(systemName: "magnifyingglass")
            }

            Button {

            } label: {
                Image(systemName: "wave.3.up")
            }

        }
        .padding(.top, 10)
    }

}

struct vendorsList: View {
    @ObservedObject var vm: VendorsViewModel
    var body: some View {

        ForEach(vm.vendors, id: \.self) { vendor in
            NavigationLink {
                VendorsDetailsView(vendorId: vendor.id ?? 0)
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 350, height: 104)
                    .foregroundStyle(.gray.opacity(0.1))
                    .overlay {
                        HStack(alignment: .top) {
                            AsyncImage(url: URL(string: vendor.logo ?? "")) {
                                phase in
                                switch phase {
                                case .empty:
                                    // Progress view while image is downloading
                                    ProgressView()
                                        .frame(width: 54, height: 54)
                                        .background(Color.gray.opacity(0.1))
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 12)
                                        )

                                case .success(let image):
                                    // Image loaded successfully
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 54, height: 54)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 12)
                                        )

                                case .failure:
                                    // Fallback UI if URL is invalid or image fails to load
                                    Image(systemName: "storefront.fill")
                                        .foregroundColor(.gray)
                                        .frame(width: 54, height: 54)
                                        .background(Color.gray.opacity(0.1))
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 12)
                                        )

                                @unknown default:
                                    EmptyView()
                                }
                            }
                            VStack(alignment: .leading) {
                                Text(vendor.name ?? "Vendor")
                                    .font(.custom("Urbanist-Regular", size: 15))
                                HStack {
                                    Text(
                                        String(
                                            format: "%.1f",
                                            vendor.averageRating ?? 0
                                        )
                                    )
                                    .font(
                                        .custom(
                                            "Urbanist-Regular",
                                            size: 12
                                        )
                                    )
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .frame(width: 10, height: 10)
                                        .foregroundStyle(.yellow)

                                    Circle()
                                        .frame(width: 5, height: 5)
                                        .foregroundStyle(.gray)

                                    Text(
                                        String(
                                            format: "%.1f",
                                            vendor.distance ?? 0
                                        )
                                    )
                                    .font(
                                        .custom(
                                            "Urbanist-Regular",
                                            size: 12
                                        )
                                    )
                                    Text("km away")
                                        .font(
                                            .custom(
                                                "Urbanist-Regular",
                                                size: 12
                                            )
                                        )
                                }

                                Text(vendor.aboutUs ?? "")
                                    .font(.custom("Urbanist-Regular", size: 13))
                                    .frame(alignment: .leading)

                            }

                            Spacer()
                            Button {
                                vm.isLiked.toggle()
                            } label: {
                                Image(
                                    systemName: vm.isLiked
                                        ? "heart.fill" : "heart"
                                )
                                .foregroundColor(vm.isLiked ? .red : .gray)
                            }
                            .buttonStyle(.borderless)
                        }
                        .padding(.horizontal, 12)
                    }
            }
            .buttonStyle(.plain)
        }.padding(.top, 15)

    }
}

struct categories: View {
    @ObservedObject var vm: VendorsViewModel
    var body: some View {

        ScrollView(.horizontal) {
            HStack {
                ForEach(vm.categories) { items in
                    HStack(alignment: .center) {
                        Image(items.avatar ?? "").resizable().frame(
                            width: 15,
                            height: 15
                        )
                        Text(
                            items.title ?? ""
                        )
                        .foregroundStyle(.white)
                        .font(
                            .custom("Urbanist-Regular", size: 13)
                        )
                        .lineLimit(1)
                    }.padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(
                            .accent
                        )
                        .cornerRadius(20)
                        .padding(.horizontal, 5)
                }

            }
        }.scrollIndicators(.hidden)
            .padding(.top, 10)
    }
}

#Preview {
    NavigationStack {
        VendorsView()
    }
}
