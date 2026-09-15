import SwiftUI

struct VendorsDetailsView: View {
    @ObservedObject var vm = VendorsViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {

        ScrollView {
            appBar
            vendorDetails
            servicesSections
            aboutSection
            reviews

        }
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden()
        .sheet(
            isPresented: $vm.showReviews,
            content: {

                Text("Reviews Section")
            }
        )
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
                Text("Elite Detailing")
                    .font(.custom("Urbanist-Regular", size: 20))
                HStack {
                    Text("4.8")
                        .font(.custom("Urbanist-Regular", size: 14))
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 15, height: 15, alignment: .leading)
                        .foregroundStyle(.yellow)
                    Text("(324 reviews)")
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
            NavigationLink {
                ServicesView()
            } label: {
                RoundedRectangle(cornerRadius: 6)
                    .frame(width: 236, height: 122)
                    .foregroundStyle(.gray.opacity(0.1))
                    .overlay {
                        VStack(alignment: .leading) {
                            HStack(spacing: 1) {
                                Text("Paint Protection Film")
                                    .font(.custom("Urbanist-Regular", size: 15))
                                Spacer()
                                Image("clock")
                                Text("3h")
                                    .font(.custom("Urbanist-Regular", size: 12))
                            }
                            Text("Clear film protection for high-impact areas")
                                .font(.custom("Urbanist-Light", size: 13))
                            Spacer()
                            HStack {
                                Text("120 KWD")
                                    .font(.custom("Urbanist-Bold", size: 15))
                                Spacer()
                                Text("Book")
                                .font(.custom("Urbanist-Bold", size: 15))
                            }
                        }
                        .padding(.leading, 14)
                        .padding(.trailing, 10)
                        .padding(.vertical, 14)
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

            RoundedRectangle(cornerRadius: 6)
                .frame(width: 350, height: 223)
                .foregroundStyle(.gray.opacity(0.1))
                .overlay {
                    VStack(alignment: .leading) {
                        Text(
                            "Premium Auto Care has been serving the community for over 5 years with professional car protection and detailing services. We use only the highest quality products and certified techniques."
                        )
                        .font(.custom("Urbanist-Regular", size: 16))
                        Spacer()
                        HStack {
                            Image(systemName: "location.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundStyle(.accent)
                            Text("123 Main Street, Downtown")
                                .font(.custom("Urbanist-Regular", size: 14))

                        }
                        HStack {
                            Image(systemName: "clock.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundStyle(.accent)
                            Text("Mon-Sat: 8 AM - 8 PM, Sun: 10 AM - 6 PM")
                                .font(.custom("Urbanist-Regular", size: 14))

                        }

                        HStack {
                            Image(systemName: "phone.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundStyle(.accent)
                            Text("(555) 123-4567")
                                .font(.custom("Urbanist-Regular", size: 14))

                        }
                    }
                    .padding(14)
                }
        }
    }

    private var reviews: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("Reviews (231)")
                    .font(.custom("Urbanist-Regular", size: 16))
                    .padding(.top, 6)

                Spacer()
                Button(
                    "See all"
                ) {
                    vm.showReviews = true
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
    VendorsDetailsView()
}
