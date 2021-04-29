//
//  PersonView.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 24.03.2021.
//

import SwiftUI

struct PersonsView: View {
    
    //@EnvironmentObject var pVM: PersonViewModel
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
            ScrollView(showsIndicators: false) {
                ForEach(0 ..< 1) { _ in
                    PersonLargeCard()
                }
                .onDelete(perform: { indexSet in
                    //
                })
                Divider()
                    .padding()
                ForEach(0..<2) { item in
                    PersonSmallCard()
                    Divider()
                }.onDelete(perform: { indexSet in
                    //pVM.persons.remove(atOffsets: indexSet)
                })
            }
            //Spacer()
        }
    }
}

struct PersonsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonsView(showSheet: .constant(true))
            //.environmentObject(PersonViewModel())
    }
}

struct PersonLargeCard: View {
    var body: some View {
        ZStack(alignment: .center) {
            Image("jenikface")
                .resizable()
                .frame(width: 250, height: 250)
                .scaledToFill()
                .clipShape(Circle())
        }
    }
}

struct PersonSmallCard: View {
    var body: some View {
        Image("jenikface")
            .resizable()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
    }
}
