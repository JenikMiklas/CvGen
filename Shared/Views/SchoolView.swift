//
//  SchoolView.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 03.02.2021.
//

import SwiftUI

struct SchoolView: View {
    
    @EnvironmentObject var cvgVM: CvGenViewModel
    
    @State private var showSheet = false
    
    var body: some View {
        List {
            ForEach(cvgVM.person?.schoolArray ?? [], id: \.self) { school in
                //if let job = set as? Jobs {
                ContetView(header: school.school ?? "", text: school.course ?? "", from: school.periodFrom ?? Date(), to: school.periodTo ?? Date())
                    .onTapGesture {
                        cvgVM.selectedObject = school
                        showSheet.toggle()
                    }
                //}
            }.onDelete(perform: deleteSchool)
        }
        .navigationBarTitle("Education", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: { showSheet.toggle() }, label: {
            Text("Add")
        }))
        .sheet(isPresented: $showSheet, content: {
            NewContetView(showSheet: $showSheet)
            
        })
        .onAppear {
            cvgVM.section = .education
            //print(cvgVM.person?.work)
        }
    }
    private func deleteSchool(offsets: IndexSet) {
        withAnimation {
            cvgVM.deleteContect(offsets: offsets)
        }
    }
}

struct SchoolView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolView()
    }
}
