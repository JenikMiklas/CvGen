//
//  ImageView.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 08.02.2021.
//

import SwiftUI
import PhotosUI

struct ImageView: View {
    
    @EnvironmentObject var cvgVM: CvGenViewModel
    
    @State private var showLibrary = false
    @State private var profileImg: UIImage?
    @State private var renderedImg: UIImage?
    
    @GestureState private var dragOffset: CGSize = .zero
    @State private var position: CGSize = .zero
    
    @GestureState private var pinchOffset: CGFloat = 1
    @State private var pinchPosition: CGFloat = 1
    
    var body: some View {
        VStack {
            /*if renderedImg != nil {
                Image(uiImage: renderedImg)
            } else*/ if profileImg == nil {
                Button(action: { showLibrary.toggle() }, label: {
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                })
                .frame(width: 300, height: 300)
                .background(Color.gray)
                .cornerRadius(10)
                .foregroundColor(.primary)
                .overlay(
                    Text("Tap to select picture").offset(y: 70)
                )
            } else {
                //GeometryReader { geo in
                    Image(uiImage: profileImg!)
                        .resizable()
                        .scaledToFill()
                        .scaleEffect(pinchOffset * pinchPosition)
                        .offset(x: dragOffset.width + position.width, y: dragOffset.height + position.height)
                        .overlay(
                            ZStack {
                                Color.black.opacity(0.5)
                                    .frame(width: 300, height: (UIScreen.main.bounds.height-300))
                                    .offset(y: (UIScreen.main.bounds.height-300)/2+150)
                                Color.black.opacity(0.5)
                                    .frame(width: 300, height: (UIScreen.main.bounds.height-300))
                                    .offset(y: -(UIScreen.main.bounds.height-300)/2-150)
                                Color.black.opacity(0.5)
                                    .frame(width: (UIScreen.main.bounds.width-300), height: UIScreen.main.bounds.height)
                                    .offset(x: -(UIScreen.main.bounds.width-300)/2-150)
                                Color.black.opacity(0.5)
                                    .frame(width: (UIScreen.main.bounds.width-300), height: UIScreen.main.bounds.height)
                                    .offset(x: (UIScreen.main.bounds.width-300)/2+150)
                            })
                        .gesture(DragGesture()
                            
                            .updating($dragOffset) { value, state, transaction in
                                state = value.translation
                            }
                            .onEnded() {
                                position.width += $0.translation.width
                                position.height += $0.translation.height
                                //dragOffset = .zero
                        })
                        .gesture(MagnificationGesture()
                                    .updating($pinchOffset) { value, state, transaction in
                                        state = value
                                    }
                                    .onEnded() {
                                       pinchPosition *= $0
                                    })
                //}
                
            }
            
        }
        .navigationBarTitle("Profile image", displayMode: .inline)
        .sheet(isPresented: $showLibrary) {
            ImagePicker(profileImg: $profileImg, showLibrary: $showLibrary)
        }
        .navigationBarItems(trailing: Button(action: {
            renderedImg = takeScreenshot(origin: CGPoint(x: 0, y: (UIScreen.main.bounds.height-300)/2+150), size: CGSize(width: 300, height: 300))
            saveImag()
        }, label: {
            Text("Save")
        }))
    }
    
    private func loadImage() -> UIImage {
        if let nameID = cvgVM.person?.img {
            let filename = getDocumentsDirectory()
            print(filename)
            do {
                var str = try String(contentsOf: filename)
                str += nameID
                return UIImage(contentsOfFile: str)!
            } catch {
                print(error.localizedDescription)
            }
        }
        return UIImage()
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func saveImag() {
        if let image = renderedImg {
            if let data = image.pngData() {
                let nameID = UUID().uuidString+".png"
                let filename = getDocumentsDirectory().appendingPathComponent(nameID)
                do {
                    try data.write(to: filename)
                    cvgVM.person?.img = nameID
                    cvgVM.savePerson()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ImageView()
        }
    }
}

extension UIView {
var renderedImage: UIImage {
// rect of capure
        let rect = self.bounds
// create the context of bitmap
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
let context: CGContext = UIGraphicsGetCurrentContext()!
self.layer.render(in: context)
// get a image from current context bitmap
        let capturedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
UIGraphicsEndImageContext()
return capturedImage
    }
}

extension View {
func takeScreenshot(origin: CGPoint, size: CGSize) -> UIImage {
let window = UIWindow(frame: CGRect(origin: origin, size: size))
let hosting = UIHostingController(rootView: self)
        hosting.view.frame = window.frame
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
return hosting.view.renderedImage
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    
    
    @Binding var profileImg: UIImage?
    @Binding var showLibrary: Bool
    
    private var phpConfigurator: PHPickerConfiguration {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        return config
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let phpicker = PHPickerViewController(configuration: phpConfigurator)
        phpicker.delegate = context.coordinator
        phpicker.isEditing = true
        phpicker.setEditing(true, animated: true)
        return phpicker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            parent.showLibrary.toggle()
            
            for image in results {
                if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    image.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (img, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            self.parent.profileImg = img as? UIImage
                            
                        }
                    })
                }
            }
        }
    }
    
}
