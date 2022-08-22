//
//  prospect.swift
//  hotProspect
//
//  Created by Sampel on 03/08/2022.
//

import Foundation

class Prospect : Identifiable, Codable {
    var id = UUID()
    var name = "anonymous"
    var emailAdress = ""
    fileprivate (set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
   @Published private (set) var people : [Prospect]
    let saveKey = "SavedData"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
        }
        
        
         people = []
    
    }
        private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded,forKey:  saveKey)
        }
    }
    
    func add (_ prospect : Prospect){
        people.append(prospect)
        save()
    }
    
    func toogle ( _ prospect : Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
}
