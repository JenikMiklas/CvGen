//
//  SkillView.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 03.02.2021.
//

import SwiftUI

struct SkillView: View {
    
    @EnvironmentObject var cvgVM: CvGenViewModel
    
    @State private var showSheet = false
    
    var body: some View {
        List {
            ForEach(cvgVM.person?.skillArray ?? [], id: \.self) { skill in
                SkillCard(name: skill.name ?? "", score: skill.score )
                    .onTapGesture {
                        cvgVM.selectedObject = skill
                        showSheet.toggle()
                    }
            }.onDelete(perform: deleteSchool)
        }
        .navigationBarTitle("Skills")
        .navigationBarItems(trailing: Button(action: { showSheet.toggle() }, label: {
            Text("Add")
        }))
        .sheet(isPresented: $showSheet, content: {
            NewSkillView(showSheet: $showSheet)
            
        })
        .onAppear {
            cvgVM.section = .skill
            //print(cvgVM.person?.work)
        }
    }
    
    private func deleteSchool(offsets: IndexSet) {
        withAnimation {
            cvgVM.deleteContect(offsets: offsets)
        }
    }
}

struct SkillView_Previews: PreviewProvider {
    static var previews: some View {
        NewSkillView(showSheet: .constant(true))
    }
}

struct NewSkillView: View {
    
    @EnvironmentObject var cvgVM: CvGenViewModel
    
    @Binding var showSheet: Bool
    
    @State private var header = ""
    @State private var content = "Description"
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $header)
                    TextEditor(text: $content)
                        .opacity(content == "Description" ? 0.25 : 1)
                    Button(action: {
                        if cvgVM.selectedObject != nil {
                            cvgVM.updateContent(header: header, content: content, from: Date(), to: Date())
                        } else {
                            cvgVM.createContent(header: header, content: content, from: Date(), to: Date())
                        }
                        showSheet.toggle()
                    }, label: {
                        HStack {
                            Spacer()
                            Text(cvgVM.getButtonTitle())
                            Spacer()
                        }
                    })
                }
            }
            .onAppear {
                let data = cvgVM.loadContent()
                header = data.0
                content = data.1
            }
            .navigationBarTitle(cvgVM.getViewTitle(), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                cvgVM.selectedObject = nil
                showSheet.toggle()
                
            }, label: {
                Text("Close")
            }))
        }
    }
}
