//
//  CustomBackButton.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import UIKit

class CustomNavigationBarController: UINavigationController {
    
    override func viewDidLoad() {
        customNavigationBar()
    }
    
    func customNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .black
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationBar.standardAppearance = navigationBarAppearance
        navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationBar.tintColor = .gray50
    }
}
