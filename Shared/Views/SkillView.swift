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
                ContetView(header: skill.name ?? "", text: "\(skill.score)", from: nil, to: nil)
                    .onTapGesture {
                        cvgVM.selectedObject = skill
                        showSheet.toggle()
                    }
            }.onDelete(perform: deleteSkill)
        }
        .navigationBarTitle("Skills")
        .navigationBarItems(trailing: Button(action: { showSheet.toggle() }, label: {
            Text("Add")
        }))
        .sheet(isPresented: $showSheet, content: {
            NewContetView(showSheet: $showSheet)
            
        })
        .onAppear {
            cvgVM.section = .skill
            //print(cvgVM.person?.work)
        }
    }
    
    private func deleteSkill(offsets: IndexSet) {
        withAnimation {
            cvgVM.deleteContect(offsets: offsets)
        }
    }
}

struct SkillView_Previews: PreviewProvider {
    static var previews: some View {
        SkillView()
    }
}
