import SwiftUI

struct VendorDetailView: View {
    let vendor: Datum
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            appBar
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 160)
                        .foregroundStyle(.gray.opacity(0.1))

                    Text(vendor.name ?? "Vendor")
                        .font(.custom("Urbanist-SemiBold", size: 22))

                    HStack(spacing: 6) {
                        Text(String(format: "%.1f", vendor.averageRating ?? 0))
                            .font(.custom("Urbanist-Regular", size: 14))
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                            .font(.system(size: 12))
                        Text("\(vendor.totalReviews ?? 0) reviews")
                            .font(.custom("Urbanist-Regular", size: 14))
                            .foregroundStyle(.gray)
                    }

                    Text(vendor.address ?? "")
                        .font(.custom("Urbanist-Regular", size: 14))
                        .foregroundStyle(.gray)

                    Text(vendor.aboutUs ?? "")
                        .font(.custom("Urbanist-Regular", size: 16))
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden()
    }

    private var appBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
            }
            Spacer()
            Text(vendor.companyName ?? "Vendor")
                .font(.custom("Urbanist-Regular", size: 18))
            Spacer()
            Image(systemName: "chevron.left")
                .hidden()
        }
        .padding(.top, 10)
    }
}

#Preview {
    NavigationStack {
        VendorDetailView(
            vendor: Datum(
                id: 1,
                name: "Premium Car wash",
                companyName: "Al-Baraqa",
                address: "Main Boulevard",
                latitude: nil,
                longitude: nil,
                contactPhone: nil,
                aboutUs: "Car shop for maintenance",
                logo: nil,
                coverImage: nil,
                vendorStatus: "active",
                distance: 10,
                servicesCount: 3,
                averageRating: 4.5,
                totalReviews: 12,
                createdAt: nil,
                updatedAt: nil
            )
        )
    }
}
