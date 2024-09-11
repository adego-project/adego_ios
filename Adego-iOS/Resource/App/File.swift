//
//  File.swift
//  Adego-iOS
//
//  Created by 최시훈 on 8/28/24.
//

import Foundation
import SwiftUI
import Alamofire

class PatientViewModel: ObservableObject {
    
    @Published var location: String = ""
    
    var lat: String = ""
    var lon: String = ""
    
    @Published var step: Int8 = 0
    
    @Published var age: String = ""
    @Published var isAgeError: Bool = false
    
    @Published var gender: String = ""
    
    @Published var emergency: Array<String> = []
    
    @Published var KTAS: String = ""
    @Published var isKTASError: Bool = false
    
    @Published var symptoms: String = ""
    @Published var isSymptomsError: Bool = false
    
    @Published var isModalPresented: Bool = false
    
    
    private let ageRegex: String = "^[0-9]+$"
    
    func prevStep() {
        withAnimation {
            if step != 0 {
                step -= 1
            }
        }
    }
    
    func closeModal() {
        if isModalPresented {
            isModalPresented = false
        }
    }
    
    func fetchHospital() {
        
        let url = "https://searchlight.kwl.kr/hospital/fetch"
        
        let params: [String: Any] = [
            "lat": lat,
            "lon": lon,
            "rltmEmerCds": emergency.map({ item in
                return [
                    "일반": "O001",
                    "코호트 격리": "O059",
                    "음압격리": "O003",
                    "일반격리": "O004",
                    "외상소생실": "O060",
                    "소아": "O002",
                    "소아음압격리": "O048",
                    "소아일반격리": "O049"
                ][item]
            })
        ]
        
        AF.request(
            url,
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default
        )
        .validate()
        .responseDecodable(of: [Hospital].self) { response in
            switch response.result {
            case .success(let value):
                print("DEBUG \(value)")
            case .failure(let value):
                print("DEBUG \(value)")
            }
        }
    }
}
