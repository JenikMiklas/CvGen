//
//  SocialView.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 09.02.2021.
//

import SwiftUI

struct SocialView: View {
    
    @EnvironmentObject var cvgVM: CvGenViewModel
    
    @State private var showSheet = false
    
    var body: some View {
        List {
            ForEach(cvgVM.person?.socialArray ?? [], id: \.self) { social in
                ContetView(header: social.name ?? "", text: social.link ?? "", from: nil, to: nil)
                    .onTapGesture {
                        cvgVM.selectedObject = social
                        showSheet.toggle()
                    }
            }.onDelete(perform: deleteSocial)
        }
        .navigationBarTitle("Social")
        .navigationBarItems(trailing: Button(action: { showSheet.toggle() }, label: {
            Text("Add")
        }))
        .sheet(isPresented: $showSheet, content: {
            NewContetView(showSheet: $showSheet)
            
        })
        .onAppear {
            cvgVM.section = .social
            //print(cvgVM.person?.work)
        }
    }
    
    private func deleteSocial(offsets: IndexSet) {
        withAnimation {
            cvgVM.deleteContect(offsets: offsets)
        }
    }
}

struct SocialView_Previews: PreviewProvider {
    static var previews: some View {
        SocialView()
    }
}
