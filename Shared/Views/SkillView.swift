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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SkillView_Previews: PreviewProvider {
    static var previews: some View {
        SkillView()
    }
}
