//
//  RadioButton.swift
//  ybs-interview
//
//  Created by Lenard Pop on 28/08/2023.
//

import SwiftUI

struct RadioButton<T: Equatable>: View {
    @Binding var selectedOption: T
    var option: T

    var body: some View {
        Button(action: {
            selectedOption = option
        }) {
            HStack {
                Image(systemName: selectedOption == option ? "checkmark.square.fill" : "square")
                Text(String(describing: option))
                    .font(.body)
                    .fontWeight(.light)
                    .foregroundColor(Color.white)
            }
        }
    }
}


struct RadioButton_Previews: PreviewProvider {
    static var previews: some View {
        RadioButton(selectedOption: .constant(""), option: "")
    }
}
