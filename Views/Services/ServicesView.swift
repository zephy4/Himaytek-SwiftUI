import SwiftUI

struct ServicesView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 0) {
            appBar
                .padding(.horizontal, 20)
            ScrollView {
                VStack(spacing: 16) {
                    details
                    whatsIncluded
                    includedDetails
                }
                .padding(.horizontal, 20)
            }
            .scrollIndicators(.hidden)
            BottomBookingBar()
        }

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
            Text("Service Details")
                .font(.custom("Urbanist-Regular", size: 16))
            Spacer()
            Button("Cancel") {

            }
            .font(.custom("Urbanist-Bold", size: 14))
        }.padding(.top, 10)
            .padding(.bottom, 30)
    }

    private var details: some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 132)
                .padding(.bottom, 8)

            HStack {
                Text("Ceramic Coating Service")
                    .font(.custom("Urbanist-Regular", size: 18))
                Spacer()
                Text("135 KWD")
                    .font(.custom("Urbanist-Regular", size: 18))
            }
            Text("Paint Protection Service")
                .font(.custom("Urbanist-Light", size: 15))
        }
    }

    struct BottomBookingBar: View {
        var totalPrice: String = "100 KWD"
        var onBookTap: () -> Void = {}

        var body: some View {
            HStack(alignment: .center) {
                // Left Side: Price Details
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total Price")
                        .font(.custom("Urbanist-Regular", size: 14))
                        .foregroundColor(.gray)

                    Text(totalPrice)
                        .font(.custom("Urbanist-Bold", size: 16))
                        .foregroundColor(.black)
                }

                Spacer()
                CommonButton(
                    text: "Book Service",
                    destination: HomeView(),
                    isNavigation: true
                )
                .frame(width: 170)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 34)  // Extra space for safe area / Home indicator
            .background(
                Color.white
                    .clipShape(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 24,
                            topTrailingRadius: 24
                        )
                    )
                    .shadow(
                        color: Color.black.opacity(0.08),
                        radius: 10,
                        x: 0,
                        y: -5
                    )
            )
            .ignoresSafeArea(edges: .bottom)
        }
    }

    private var whatsIncluded: some View {
        RoundedRectangle(cornerRadius: 6)
            .frame(height: 166)
            .foregroundStyle(.gray.opacity(0.1))
            .overlay {
                VStack(alignment: .leading) {
                    IncludedItemRow(
                        title: "Duration",
                        subTitle: "3-5 Hours",
                        icon: "clock.fill"
                    )
                    IncludedItemRow(
                        title: "Warranty",
                        subTitle: "2 Years Protection",
                        icon: "calendar"
                    )
                    IncludedItemRow(
                        title: "Service Location",
                        subTitle: "At Vendors Location",
                        icon: "location.fill"
                    )
                }
                .padding(.horizontal, 14)
            }

    }

    struct IncludedItemRow: View {
        let title: String
        let subTitle: String
        let icon: String

        var body: some View {
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.gray.opacity(0.2))
                    .overlay {
                        Image(systemName: icon)
                            .foregroundStyle(.accent)
                    }
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.custom("Urbanist-Regular", size: 14))
                    Text(subTitle)
                        .font(.custom("Urbanist-Light", size: 12))
                }
                Spacer()
            }
        }
    }

    private var includedDetails: some View {
        VStack(alignment: .leading) {
            Text("Whats Included")
                .font(.custom("Urbanist-Regular", size: 16))

            RoundedRectangle(cornerRadius: 6)
                .frame(height: 222)
                .foregroundStyle(.gray.opacity(0.1))
                .overlay {
                    HStack {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.green)
                        Text("Complete paint surface preparation and cleaning")
                            .font(.custom("Urbanist-Regular", size: 14))
                    }
                }
        }
        .padding(.vertical, 14)
    }
}

#Preview {
    ServicesView()
}
