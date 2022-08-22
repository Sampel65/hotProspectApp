//
//  ContentView.swift
//  hotProspect
//
//  Created by Sampel on 03/08/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var prospects = Prospects()
     
    var body: some View {
        TabView{
            ProspectView(filter: .none)
                .tabItem {
                    Label("everyone ", systemImage: "person.3")
                }
            
            
            ProspectView(filter: .contacted)
                    .tabItem {
                        Label("contacted", systemImage: "checkmark.circle")
                    }
            
            
            ProspectView(filter: .uncontacted)
                    .tabItem {
                        Label("Uncontacted", systemImage: "questionmark.diamond")
                    }
            
            
                MeView()
                    .tabItem {
                        Label("Me", systemImage: "person.crop.square")
                    }
        }
        .environmentObject(prospects)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
