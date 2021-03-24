//
//  SideMenu.swift
//  CvGenUI
//
//  Created by Jan Miklas on 17.03.2021.
//

import SwiftUI

struct SideMenu: View {
    
    @EnvironmentObject var pVM: PersonViewModel
    @Binding var showMenu: Bool
    @State private var showSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            //ScrollView(.horizontal) {
                //HStack {
                   // ForEach(pVM.persons) { person in
                        if let img = pVM.person?.img {
                            Image(pVM.getDocumentsDirectory(name: img))
                                 .resizable()
                                 .frame(width: 65, height: 65)
                                 .clipShape(Circle())
                        } else {
                            Image("profile")
                                .resizable()
                                .frame(width: 65, height: 65)
                                .clipShape(Circle())
                        }
                    //}
                //}
            //}
            Group {
                Button(action: { goTo(.menu) }) {
                    Text("Osobní info")
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Práce")
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Vzdělání")
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Dovednosti")
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Záliby")
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                Button(action: { goTo(.templates) }) {
                    Text("Šablony")
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                Button(action: {
                    showSheet.toggle()
                }) {
                    Image(systemName: "person.3.fill")
                        .resizable()
                        .frame(maxWidth: 35, maxHeight: 35)
                        .scaledToFit()
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding([.leading, .top])
        .sheet(isPresented: $showSheet) {
            PersonsView(showSheet: $showSheet)
        }
    }
    private func goTo(_ selectedView: Sections) {
        pVM.menuSection = selectedView
        withAnimation {
            showMenu.toggle()
        }
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SideMenu(showMenu: .constant(false))
                .environmentObject(PersonViewModel())
        }
    }
}
