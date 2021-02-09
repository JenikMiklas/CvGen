//
//  ContainerViews.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 03.02.2021.
//

import SwiftUI

struct ContetView: View {
    
    @EnvironmentObject var cvgVM: CvGenViewModel
    
    let header: String
    let text: String?
    let from: Date?
    let to: Date?
    
    var body: some View {
        VStack {
            Text(header)
                .font(.title2)
            if cvgVM.section != .hobby {
                Divider()
                Text(text!)
                if cvgVM.section == .job || cvgVM.section == .education {
                    Divider()
                    HStack {
                        Text(DateFormatter.localizedString(from: from!, dateStyle: .short, timeStyle: .none))
                        Spacer()
                        Text(DateFormatter.localizedString(from: to!, dateStyle: .short, timeStyle: .none))
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
    }
}

struct NewContetView: View {
    
    @EnvironmentObject var cvgVM: CvGenViewModel
    
    @Binding var showSheet: Bool
    
    @State private var pickerIndex = 0
    @State private var header = ""
    @State private var content = "Description"
    @State private var from = Date()
    @State private var to = Date()
    
    private let socialNetworks = ["Facebook", "Twitter", "YouTube", "Linkedin"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    if cvgVM.section == .social {
                        Picker(selection: $pickerIndex, label: Text(header == "" ? socialNetworks[pickerIndex] : header)) {
                            ForEach (0..<socialNetworks.count, id: \.self) { index in
                                Text(socialNetworks[index]).tag(index)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .onChange(of: pickerIndex, perform: { value in
                            header = socialNetworks[value]
                        })
                    } else {
                        TextField("Name", text: $header)
                    }
                    if cvgVM.section != .hobby {
                        TextEditor(text: $content)
                            .opacity(content == "Description" ? 0.25 : 1)
                            .frame(height: cvgVM.section == .skill || cvgVM.section == .social ? nil : 300)
                        if cvgVM.section == .job || cvgVM.section == .education {
                            HStack {
                                DatePicker("from", selection: $from, displayedComponents: .date)
                                DatePicker("to", selection: $to, displayedComponents: .date)
                            }
                            .font(.caption)
                        }
                    }
                    Button(action: {
                        if cvgVM.selectedObject != nil {
                            cvgVM.updateContent(header: header, content: content, from: from, to: to)
                        } else {
                            cvgVM.createContent(header: header, content: content, from: from, to: to)
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
                if cvgVM.section != .hobby {
                    content = data.1
                    if cvgVM.section != .skill {
                        from = data.2
                        to = data.3
                    }
                }
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

struct Badge: View {
    
    let image: String
    let title: String
    
    var body: some View {
        VStack {
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .overlay(
                    Image(systemName: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50))
            Text(title)
                .font(.title3)
        }
        .foregroundColor(.primary)
    }
}

struct VerticalDivider: View {
    var body: some View {
        Rectangle()
            .frame(width: 7, height: 50)
            .cornerRadius(8)
            .foregroundColor(.gray)
    }
}

struct CardView: View {
    
    let name: String
    let job: String
    let phone: String
    let email: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image("jenikface")
                .resizable()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .trailing) {
                Text(job)
                    .font(.caption)
                Text(phone)
                    .font(.caption2)
                Text(email)
                    .font(.caption2)
            }
            Spacer()
            VStack {
                Text(name)
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(5)
        //.background(Color.gray)
        //.cornerRadius(10)
    }
}
