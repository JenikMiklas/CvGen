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
                JobView(company: job.company ?? "", position: job.position ?? "", from: job.periodFrom ?? Date(), to: job.periodTo ?? Date())
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
            NewJobView(showSheet: $showSheet)
            
        })
        .onAppear {
            //print(cvgVM.person?.work)
        }
    }
    private func deleteJob(offsets: IndexSet) {
        withAnimation {
            cvgVM.deleteJob(offsets: offsets)
        }
    }
}

struct WorkFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JobView(company: "Company", position: "Position", from: Date(), to: Date())
            /*WorkFormView()
                .environmentObject(CvGenViewModel(moc: PersistenceController.shared.container.viewContext))
                .navigationBarTitle("Jobs", displayMode: .inline)*/
        }
    }
}

struct JobView: View {
    
    let company: String
    let position: String
    let from: Date
    let to: Date
    
    var body: some View {
        VStack {
            Text(company)
                .font(.title2)
            Divider()
            Text(position)
            Divider()
            HStack {
                Text(DateFormatter.localizedString(from: from, dateStyle: .short, timeStyle: .none))
                Spacer()
                Text(DateFormatter.localizedString(from: to, dateStyle: .short, timeStyle: .none))
            }
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
    }
}

struct NewJobView: View {
    
    @EnvironmentObject var cvgVM: CvGenViewModel
    
    @Binding var showSheet: Bool
    
    @State private var company = ""
    @State private var position = "Position"
    @State private var from = Date()
    @State private var to = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Company name", text: $company)
                    TextEditor(text: $position)
                        .opacity(position == "Position" ? 0.25 : 1)
                        .frame(height: 300)
                    HStack {
                        DatePicker("from", selection: $from, displayedComponents: .date)
                        DatePicker("to", selection: $to, displayedComponents: .date)
                    }
                    .font(.caption)
                    Button(action: {
                        if cvgVM.selectedObject != nil {
                            cvgVM.updateJob(company: company, position: position, from: from, to: to)
                        } else {
                            cvgVM.createJob(company: company, position: position, from: from, to: to)
                        }
                        showSheet.toggle()
                    }, label: {
                        Text(cvgVM.selectedObject != nil ? "Update job" : "Add job")
                    })
                }
            }
            .onAppear {
                if let job = cvgVM.selectedObject as? Jobs {
                    company = job.company!
                    position = job.position!
                    from = job.periodFrom!
                    to = job.periodTo!
                }
            }
            .navigationBarTitle("Insert new Job record", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                cvgVM.selectedObject = nil
                showSheet.toggle()
                
            }, label: {
                Text("Close")
            }))
        }
    }
}
