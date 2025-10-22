import SwiftUI

struct CartBackButton: View {
    @Environment(\.dismiss) private var dismiss
    var color: Color = .primary

    var body: some View {
        Button {
            dismiss()
        } label: {
            HStack(spacing: 4) {
                Image(systemName: "chevron.left")
                    .font(.headline)
                    .foregroundColor(color)
            }
        }
        .buttonStyle(.plain)
    }
}
