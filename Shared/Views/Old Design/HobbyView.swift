//
//  HobbyView.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 04.02.2021.
//

import SwiftUI

struct HobbyView: View {
    
    @EnvironmentObject var cvgVM: CvGenViewModel
    
    @State private var showSheet = false
    
    var body: some View {
        List {
            ForEach(cvgVM.person?.hobbyArray ?? [], id: \.self) { hobby in
                ContetView(header: hobby.name ?? "", text: nil, from: nil, to: nil)
                    .onTapGesture {
                        cvgVM.selectedObject = hobby
                        showSheet.toggle()
                    }
            }.onDelete(perform: deleteHobby)
        }
        .navigationBarTitle("Hobbies")
        .navigationBarItems(trailing: Button(action: { showSheet.toggle() }, label: {
            Text("Add")
        }))
        .sheet(isPresented: $showSheet, content: {
            NewContetView(showSheet: $showSheet)
            
        })
        .onAppear {
            cvgVM.section = .hobby
            //print(cvgVM.person?.hobby)
        }
    }
    
    private func deleteHobby(offsets: IndexSet) {
        withAnimation {
            cvgVM.deleteContect(offsets: offsets)
        }
    }
}

struct HobbyView_Previews: PreviewProvider {
    static var previews: some View {
        HobbyView()
    }
}
