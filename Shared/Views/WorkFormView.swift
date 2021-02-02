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
                    VStack {
                        Text(job.company ?? "kolo")
                        Text(job.position ?? "kolo")
                        Text(DateFormatter.localizedString(from: job.periodFrom ?? Date(), dateStyle: .short, timeStyle: .none))
                        Text(DateFormatter.localizedString(from: job.periodTo ?? Date(), dateStyle: .short, timeStyle: .none))
                    }
                //}
            }
        }
        .navigationBarTitle("Jobs", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: { showSheet.toggle() }, label: {
            Text("Add")
        }))
        .sheet(isPresented: $showSheet, content: {
            NewJobView()
        })
        .onAppear {
            if cvgVM.person == nil {
                cvgVM.person = Person(context: cvgVM.moc)
            } else {
                /*if let jobs = cvgVM.person?.work {
                    self.jobs = jobs
                }*/
            }
        }
    }
    
}

struct WorkFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkFormView()
                .environmentObject(CvGenViewModel(moc: PersistenceController.shared.container.viewContext))
                .navigationBarTitle("Jobs", displayMode: .inline)
        }
    }
}

struct NewJobView: View {
    
    @EnvironmentObject var cvgVM: CvGenViewModel
    
    @State private var company = ""
    @State private var position = ""
    @State private var from = Date()
    @State private var to = Date()
    
    var body: some View {
        Form {
            Section(header: Text("Jobs")) {
                TextField("Company name", text: $company)
                TextField("Job position", text: $position)
                HStack {
                    DatePicker("from", selection: $from, displayedComponents: .date)
                    DatePicker("to", selection: $to, displayedComponents: .date)
                }
                Button(action: {
                    let job = Jobs(context: cvgVM.moc)
                    job.company = company
                    job.position = position
                    job.periodFrom = from
                    job.periodTo = to
                    job.person = cvgVM.person
                }, label: {
                    Text("Add job")
                })
            }
        }
    }
}
