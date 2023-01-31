//
//  ViewModel.swift
//  Ascend
//
//  Created by Fahad Ahmed Usmani on 31/01/2023.
//

import Foundation


class ViewModel {
    
    @Published var counter : Int = 0
    
    func updateCounter(){
        counter = counter + 1
    }
    
}
