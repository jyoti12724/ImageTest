//
//  ViewModel.swift
//  TestSwiftUi
//
//  Created by Jyoti Gupta on 10/10/24.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    
    @Published var personeDataMode = [ImageModel]()
    
    func implementAPICallAndConvertItinModel() async {
        do{
            let dataValue = try await WebService.shared.hitAPIData()
            
            DispatchQueue.main.async {
                if let  data = dataValue.data {
                    self.personeDataMode = data
                }
            }
        }
        catch{
            print("Something Wrong")
        }
    }
}

