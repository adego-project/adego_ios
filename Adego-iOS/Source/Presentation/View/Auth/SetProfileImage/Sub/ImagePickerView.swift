//
//  ImagePickerView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/9/24.
//

import SwiftUI
import FlowKit
import ComposableArchitecture

struct ImagePickerView: UIViewControllerRepresentable {
    @Perception.Bindable var store: StoreOf<ImagePickerCore>
        
    var sourceType: UIImagePickerController.SourceType = .photoLibrary

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        
    }
}

final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let parent: ImagePickerView
    
    var image: UIImage?
    
    init(_ parent: ImagePickerView) {
        self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.parent.store.send(.didSelectImage(selectedImage))
                print("imagePickerController.selectedImage")
            }
        }
        parent.store.send(.dismiss)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parent.store.send(.dismiss)
    }
}
