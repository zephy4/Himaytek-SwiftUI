import SwiftUI

struct ServicesView: View {
    @Environment(\.dismiss) var dismiss
    let service: Service

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
            BottomBookingBar(totalPrice: service.basePrice ?? "")
        }

        .navigationBarBackButtonHidden()
        .toolbarVisibility(.hidden, for: .tabBar)
        .ignoresSafeArea(edges: .bottom)
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
                Text(service.name ?? "")
                    .font(.custom("Urbanist-Regular", size: 18))
                Spacer()
                Text(
                    "\(service.basePrice ?? "") KWD"
                )
                .font(.custom("Urbanist-Regular", size: 18))
            }
            Text(service.description ?? "")
                .font(.custom("Urbanist-Light", size: 15))
        }
    }

    struct BottomBookingBar: View {
        let totalPrice: String
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
                    destination: SelectCarDesign(),
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
                        subTitle: "\(service.durationMinutes ?? 0)",
                        icon: "clock.fill"
                    )
                    IncludedItemRow(
                        title: "Warranty",
                        subTitle: service.warranty ?? "",
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

            VStack(alignment: .leading, spacing: 10) {
                ForEach(service.inclusions ?? [], id: \.self) { index in
                    HStack {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.green)

                        Text(index)
                            .font(.custom("Urbanist-Regular", size: 14))
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
            }
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 355)
                    .foregroundStyle(.gray.opacity(0.1))
            )
        }
    }
}

#Preview {
    // Construct a mock service for previewing the layout
    let mockService = Service(
        id: 1,
        name: "Paint Protection Film",
        description:
            "Clear film protection for high-impact areas of your vehicle.",
        image: nil,
        warranty: "5 Years",
        inclusions: ["Hood", "Bumpers", "Mirrors"],
        durationMinutes: 180,
        cancellationPeriodHours: 24,
        basePrice: "120",
        featured: true,
        isActive: true,
        displayOrder: 1,
        category: nil,
        createdAt: nil,
        updatedAt: nil
    )

    return ServicesView(service: mockService)
}
