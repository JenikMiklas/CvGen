//
//  WorkFormView.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 02.02.2021.
//

import SwiftUI

struct WorkFormView: View {
    
    @EnvironmentObject var cvgVM: CvGenViewModel
    //@State private var jobs = NSSet()
    @State private var showSheet = false
    
    var body: some View {
        List {
            ForEach(cvgVM.person?.jobsArray ?? [], id: \.self) { job in
                //if let job = set as? Jobs {
                ContetView(header: job.company ?? "", text: job.position ?? "", from: job.periodFrom ?? Date(), to: job.periodTo ?? Date())
                    .onTapGesture {
                        cvgVM.selectedObject = job
                        showSheet.toggle()
                    }
                //}
            }.onDelete(perform: deleteJob)
        }
        .navigationBarTitle("Jobs", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: { showSheet.toggle() }, label: {
            Text("Add")
        }))
        .sheet(isPresented: $showSheet, content: {
            NewContetView(showSheet: $showSheet)
            
        })
        .onAppear {
            cvgVM.section = .job
            //print(cvgVM.person?.work)
        }
    }
    private func deleteJob(offsets: IndexSet) {
        withAnimation {
            cvgVM.deleteContect(offsets: offsets)
        }
    }
}

struct WorkFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContetView(header: "Company", text: "Position", from: Date(), to: Date())
            /*WorkFormView()
                .environmentObject(CvGenViewModel(moc: PersistenceController.shared.container.viewContext))
                .navigationBarTitle("Jobs", displayMode: .inline)*/
        }
    }
}
