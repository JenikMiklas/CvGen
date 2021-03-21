//
//  NavView.swift
//  CvGenUI
//
//  Created by Jan Miklas on 17.03.2021.
//

import SwiftUI

struct MainView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            showMenu.toggle()
                        }
                    }, label: {
                        Image(systemName: showMenu ? "xmark" : "list.bullet")
                            .resizable()
                            .frame(width: showMenu ? 30 : 20, height: showMenu ? 30 : 15)
                            .foregroundColor(.black)
                    })
                    Spacer()
                }
                Text("CvGen")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.title)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            ZStack {
                TemplatesView()
            }
            .disabled(showMenu)
        }
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(showMenu: .constant(false))
    }
}
