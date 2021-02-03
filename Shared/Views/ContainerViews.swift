//
//  ContainerViews.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 03.02.2021.
//

import SwiftUI

struct ContetView: View {
    
    let header: String
    let text: String
    let from: Date
    let to: Date
    
    var body: some View {
        VStack {
            Text(header)
                .font(.title2)
            Divider()
            Text(text)
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

struct NewContetView: View {
    
    @EnvironmentObject var cvgVM: CvGenViewModel
    
    @Binding var showSheet: Bool
    
    @State private var header = ""
    @State private var content = "Description"
    @State private var from = Date()
    @State private var to = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $header)
                    TextEditor(text: $content)
                        .opacity(content == "Description" ? 0.25 : 1)
                        .frame(height: 300)
                    HStack {
                        DatePicker("from", selection: $from, displayedComponents: .date)
                        DatePicker("to", selection: $to, displayedComponents: .date)
                    }
                    .font(.caption)
                    Button(action: {
                        if cvgVM.selectedObject != nil {
                            cvgVM.updateContent(header: header, content: content, from: from, to: to)
                        } else {
                            cvgVM.createContent(header: header, content: content, from: from, to: to)
                        }
                        showSheet.toggle()
                    }, label: {
                        Text(cvgVM.getButtonTitle())
                    })
                }
            }
            .onAppear {
                let data = cvgVM.loadContent()
                header = data.0
                content = data.1
                from = data.2
                to = data.3
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
