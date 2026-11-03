import SwiftUI

struct SubmitATicket: View {
    @StateObject var vm = SupportAndHelpCenterViewModel()
    var body: some View {
        VStack {
            NewCommonAppbar(title: "Submit a Ticket")
                .padding(.horizontal, 20)

            ScrollView {
                bodyContent
                description
                categories
                uploadPictures
            }
            .padding(.horizontal, 20)
            bottomButton
        }

        .navigationBarBackButtonHidden()
        .ignoresSafeArea(edges: .bottom)
    }

    private var bodyContent: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Submit a Ticket")
                .font(.custom("Urbanist-Bold", size: 14))
            HStack {
                Text("Describe your issue and we'll get back to you")
                    .font(.custom("Urbanist-Regular", size: 14))
                Spacer()
            }
            Spacer().frame(height: 12)
        }
    }

    private var categories: some View {
        VStack(alignment: .leading) {
            Text("Category")
                .font(.custom("Urbanist-Regular", size: 14))
            IssueTypePicker(vm: vm)
        }
    }

    private var description: some View {
        VStack(alignment: .leading) {
            Text("Describe")
                .font(.custom("Urbanist-Regular", size: 14))

            TextField("Describe Your Issue", text: $vm.description)
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(10)
                .keyboardType(.default)
                .font(.custom("Urbanist-Regular", size: 14))

        }
    }

    private var bottomButton: some View {
        CommonButton(
            text: "Submit Ticket",
            destination: EmptyView(),
            action: {
                Task {
                    await vm.placeTicket()
                }
            },
            isNavigation: false,

        )
        .padding(.top, 20)
        .padding(.bottom, 30)
        .background(
            Color.white
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 24,
                        topTrailingRadius: 24
                    )
                )
        )
        .shadow(radius: 10)

    }

    private var uploadPictures: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Upload Attachment")
                .font(.custom("Urbanist-Regular", size: 16))
            Text("Up to 3 images/screenshorts")
                .font(.custom("Urbanist-Regular", size: 16))
                .foregroundStyle(.gray)
            RoundedRectangle(cornerRadius: 10)
                .stroke(
                    style: StrokeStyle(
                        lineWidth: 2,
                        dash: [2, 4]
                    )
                ).foregroundStyle(.accent)
                .frame(height: 163)
                .overlay {
                    VStack(spacing: 10) {
                        Image(systemName: "plus")
                        Text("Click To upload")
                            .font(.custom("Urbanist-Regular", size: 14))
                        Text("Maximum file size: 10mb")
                            .font(.custom("Urbanist-Regular", size: 12))
                            .foregroundStyle(.gray)

                    }
                }
                .onTapGesture {
                    
                }
        }

    }
}

struct IssueTypePicker: View {

    @ObservedObject var vm: SupportAndHelpCenterViewModel

    var body: some View {
        Menu {
            ForEach(vm.issueTypes, id: \.self) { issue in
                Button(issue) {
                    vm.selectedIssue = issue
                }
            }
        } label: {
            HStack {
                Text(vm.selectedIssue ?? "Select issue type")
                    .font(.custom("Urbanist-Regular", size: 16))
                    .foregroundColor(vm.selectedIssue == nil ? .gray : .primary)

                Spacer()

                Image(systemName: "chevron.down")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 16)
            .frame(height: 54)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
    }
}

#Preview {
    SubmitATicket()
}
