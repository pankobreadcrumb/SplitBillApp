//
//  TakePhotoView.swift
//  Splitster2
//
//  Created by Tang Favish on 9/21/23.
//

import SwiftUI

struct TakePhotoView: View {
    @State private var isImagePickerPresented: Bool = false
    @State private var image: UIImage?

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("No Image Selected")
            }
            Button("Take Photo") {
                isImagePickerPresented = true
            }
        }
        .imagePicker(isPresented: $isImagePickerPresented, image: $image, sourceType: .camera)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}

extension View {
    func imagePicker(isPresented: Binding<Bool>, image: Binding<UIImage?>, sourceType: UIImagePickerController.SourceType) -> some View {
        self.modifier(ImagePickerModifier(isPresented: isPresented, image: image, sourceType: sourceType))
    }
}

struct ImagePickerModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType
    
    func body(content: Content) -> some View {
        content
            .background(
                ImagePicker(isPresented: $isPresented, image: $image, sourceType: sourceType)
                    .frame(width: 0, height: 0)
            )
    }
}
