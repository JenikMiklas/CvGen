//
//  PersonView.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 24.03.2021.
//

import SwiftUI

struct PersonsView: View {
    
    @Binding var showSheet: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: { showSheet.toggle() }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .padding(.trailing, 10)
                .padding(.top, 10)
                .foregroundColor(.primary)
            }
            Image("jenikface")
                .resizable()
                .frame(width: 250, height: 250)
                .scaledToFit()
                .clipShape(Circle())
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            Spacer()
        }
    }
}

struct PersonsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonsView(showSheet: .constant(true))
    }
}
