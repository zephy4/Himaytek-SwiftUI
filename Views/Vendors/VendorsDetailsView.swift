import SwiftUI

struct VendorsDetailsView: View {
    @StateObject private var vm = VendorsViewModel()
    let vendorId: Int
    @Environment(\.dismiss) var dismiss
    var body: some View {

        ScrollView {
            appBar
            vendorDetails
            servicesSections
            aboutSection
            reviews

        }
        .task(id: vendorId) {
            await vm.loadDetails(id: vendorId)
        }
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden()
        .padding(.horizontal, 20)

    }

    //MARK: Components
    private var appBar: some View {
        HStack(alignment: .center) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
            }

            Spacer()
            Text("Vendor Profile")
                .font(.custom("Urbanist-Regular", size: 16))
            Spacer()
        }
        .padding(.top, 10)
        .padding(.bottom, 30)
    }

    private var vendorDetails: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 70, height: 70)
            VStack(alignment: .leading, spacing: 5) {
                Text(vm.vendorDetails?.name ?? "NO NAME")
                    .font(.custom("Urbanist-Regular", size: 20))
                HStack {
                    Text("\(vm.vendorDetails?.averageRating ?? 0 )")

                        .font(.custom("Urbanist-Regular", size: 14))
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 15, height: 15, alignment: .leading)
                        .foregroundStyle(.yellow)
                    Text("\(vm.vendorDetails?.totalReviews ?? 0)")
                        .font(.custom("Urbanist-Regular", size: 14))
                }
                Text("2.3 km away")
                    .font(.custom("Urbanist-Regular", size: 14))
            }
            Spacer()
            Circle()
                .frame(width: 30, height: 30)
                .foregroundStyle(.white)
                .shadow(radius: 5)
                .overlay(content: {
                    Button {

                    } label: {
                        Image(systemName: "heart.fill")
                    }
                })
                .padding(.trailing, 5)
        }
    }

    private var servicesSections: some View {
        VStack(alignment: .leading) {
            Text("Services")
                .font(.custom("Urbanist-Regular", size: 16))
                .padding(.vertical, 14)
                .padding(.top, 6)

            ScrollView(.horizontal) {
                HStack {
                    ForEach(vm.vendorDetails?.services ?? []) { item in

                        NavigationLink {
                            ServicesView(service: item)
                        } label: {
                            RoundedRectangle(cornerRadius: 6)
                                .frame(width: 236, height: 122)
                                .foregroundStyle(.gray.opacity(0.1))
                                .overlay {
                                    VStack(alignment: .leading) {
                                        HStack(spacing: 1) {
                                            Text(item.name ?? "")
                                                .font(
                                                    .custom(
                                                        "Urbanist-Regular",
                                                        size: 15
                                                    )
                                                )
                                            Spacer()
                                            Image("clock")

                                            Text(
                                                "\((item.durationMinutes ?? 0) / 60)h"
                                            )

                                            .font(
                                                .custom(
                                                    "Urbanist-Regular",
                                                    size: 12
                                                )
                                            )
                                        }
                                        Text(
                                            item.description ?? ""
                                        )
                                        .multilineTextAlignment(.leading)
                                        .font(
                                            .custom("Urbanist-Light", size: 13)
                                        )
                                        Spacer()
                                        HStack {
                                            Text("\(item.basePrice ?? "0") KWD")
                                                .font(
                                                    .custom(
                                                        "Urbanist-Bold",
                                                        size: 15
                                                    )
                                                )
                                            Spacer()
                                            Text("Book")
                                                .font(
                                                    .custom(
                                                        "Urbanist-Bold",
                                                        size: 15
                                                    )
                                                )
                                        }
                                    }
                                    .padding(.leading, 14)
                                    .padding(.trailing, 10)
                                    .padding(.vertical, 14)
                                }
                        }
                    }.foregroundStyle(.black)
                        .scrollIndicators(.hidden)

                }
            }

        }
    }

    private var aboutSection: some View {
        VStack(alignment: .leading) {
            Text("About")
                .font(.custom("Urbanist-Regular", size: 16))
                .padding(.vertical, 14)
                .padding(.top, 6)

            VStack(alignment: .leading, spacing: 12) {
                Text(vm.vendorDetails?.aboutUs ?? "NO DESCRIPTION AVAILABLE")
                    .font(.custom("Urbanist-Regular", size: 16))
                    .fixedSize(horizontal: false, vertical: true)  // Allows text to expand vertically as needed

                Spacer(minLength: 12)

                HStack(spacing: 8) {
                    Image(systemName: "location.fill")
                        .font(.system(size: 15))
                        .foregroundStyle(.accent)
                    Text(vm.vendorDetails?.address ?? "NO ADDRESS")
                        .font(.custom("Urbanist-Regular", size: 14))
                }

                HStack(spacing: 8) {
                    Image(systemName: "clock.fill")
                        .font(.system(size: 15))
                        .foregroundStyle(.accent)
                    Text("Mon-Sat: 8 AM - 8 PM, Sun: 10 AM - 6 PM")
                        .font(.custom("Urbanist-Regular", size: 14))
                }

                HStack(spacing: 8) {
                    Image(systemName: "phone.fill")
                        .font(.system(size: 15))
                        .foregroundStyle(.accent)
                    Text(vm.vendorDetails?.contactPhone ?? "N/A")
                        .font(.custom("Urbanist-Regular", size: 14))
                }
            }
            .padding(14)
            .frame(maxWidth: 350, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.gray.opacity(0.1))
            )
        }
    }

    private var reviews: some View {
        Group {
            if let reviews = vm.vendorDetails?.reviews, !reviews.isEmpty {
                withReviews()
            } else {
                noReviews()
            }
        }

    }

}

// REVIEWS
struct noReviews: View {
    var body: some View {

        VStack {
            Image("stars")
                .resizable()
                .frame(width: 236)
                .foregroundStyle(.gray)

            Text("No reviews Yet")
                .font(.custom("Urbanist-Regular", size: 23))
                .foregroundStyle(.black)

        }.padding(.vertical, 20)
    }
}

struct withReviews: View {
    var body: some View {

        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("Reviews (231)")
                    .font(.custom("Urbanist-Regular", size: 16))
                    .padding(.top, 6)

                Spacer()
                Button(
                    "See all"
                ) {

                }.font(.custom("Urbanist-Bold", size: 14))
                    .padding(.top, 6)
            }

            RoundedRectangle(cornerRadius: 6)
                .frame(width: 350, height: 155)
                .foregroundStyle(.gray.opacity(0.1))
                .overlay {
                    VStack {
                        HStack(alignment: .center) {
                            Circle()
                                .frame(width: 60, height: 60)
                            VStack(alignment: .leading) {
                                Text("Sarah P.")
                                    .font(.custom("Urbanist-Regular", size: 14))
                                Text("2 days ago")
                                    .font(.custom("Urbanist-Regular", size: 12))

                            }
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundStyle(.yellow)

                            Text("5.0")
                                .font(.custom("Urbanist-Regular", size: 14))
                            Spacer()
                        }
                        Spacer()
                        Text(
                            "Excellent ceramic coating service! The team was professional and the results exceeded my expectations."
                        )
                        .font(.custom("Urbanist-Light", size: 16))
                    }
                    .padding(14)
                }
        }

    }
}

#Preview {
    VendorsDetailsView(vendorId: 4)
}
