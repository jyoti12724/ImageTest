//
//  WebServics.swift
//  TestSwiftUi
//
//  Created by Jyoti Gupta on 10/10/24.
//
import UIKit
import SwiftUI

enum ErrorType{
    case ErrorTyp1
    case ErrorType2
    case ErrorType3
}


class WebService{
    static let shared: WebService = WebService()
    func hitAPIData() async throws -> ModelBase {
        let urlString = URL(string: "https://reqres.in/api/users?page=2")
        let (data,_) = try await URLSession.shared.data(from: urlString!)
        let imageData = try JSONDecoder().decode(ModelBase.self, from: data)
        return imageData
    }
}


