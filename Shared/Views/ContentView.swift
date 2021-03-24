//
//  ContentView.swift
//  CvGenUI
//
//  Created by Jan Miklas on 17.03.2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var pVM: PersonViewModel
    
    //MARK: Don't forget to add keyword PRIVATE @State variable
    @State var showMenu = false
    
    var body: some View {
        ZStack {
            ( showMenu ? Color.black.opacity(0.05) : Color.clear).ignoresSafeArea(.all)
            ZStack(alignment: .leading) {
                SideMenu(showMenu: $showMenu)
                MainView(showMenu: $showMenu, menuSection: $pVM.menuSection)
                    .edgesIgnoringSafeArea(.bottom)
                    .scaleEffect(showMenu ? 0.75 : 1)
                    .offset(x: showMenu ? 100 : 0, y: showMenu ? 50 : 0)
            }
        }
        .environmentObject(pVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environmentObject(PersonViewModel())
                .preferredColorScheme(.light)
                .previewDevice("iPhone 12 Pro")
        }
    }
}
