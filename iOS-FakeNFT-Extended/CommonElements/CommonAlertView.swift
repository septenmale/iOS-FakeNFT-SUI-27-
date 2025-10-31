//
//  CommonAlertView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/31/25.
//
import SwiftUI

struct CommonAlertView: View {
    
    let alertTitle: String
    
    var cancelAction: (() -> Void)?
    var resetAction: (() -> Void)?
    
    private let alertFont: Font = .bold17
    private let cancelButtonFont: Font = .regular17
    private let resetButtonFont: Font = .bold17

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.uniAlert)
            alertView
        }
        .frame(width: 270, height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
    
    private var alertView: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)
            Text(alertTitle)
                .foregroundStyle(Color.uniBlack)
                .multilineTextAlignment(.center)
                .font(alertFont)
                .padding(.all, 16)
            Spacer(minLength: 0)
            Divider()
            HStack(spacing: 0) {
                alertCancelButton
                Divider()
                alertResetButton
            }
            .frame(maxHeight: 43)
        }
    }
    
    private var alertCancelButton: some View {
        Button {
            cancelAction?()
        } label: {
            ZStack {
                Rectangle()
                    .fill(Color.clear)
                Text("Отмена")
                    .font(cancelButtonFont)
            }
        }
    }
    
    private var alertResetButton: some View {
        Button {
            resetAction?()
        } label: {
            ZStack {
                Rectangle()
                    .fill(Color.clear)
                Text("Повторить")
                    .font(resetButtonFont)
                    .padding(.vertical, 11)
            }
        }
    }
}

#Preview {
    CommonAlertView(alertTitle: "Не удалось получить данные")
}
