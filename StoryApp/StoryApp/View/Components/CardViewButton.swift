//
//  CardViewButton.swift
//

import SwiftUI

struct CardViewButton: View {
    let title: String
    let calWidth: CGFloat
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {

            HStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Spacer()
            }

            Button {

            } label: {
                Text("다음에 읽기")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 25)
                    .background(Color.blue)
                    .clipShape(Capsule())
            }

        }
        .frame(width: calWidth - 40)
        .padding(.leading, 20)
        .padding(.bottom, 20)
    }
}

struct CardViewButton_Previews: PreviewProvider {
    static var previews: some View {
        CardViewButton(title: "죠르디", calWidth: 1.0)
    }
}
