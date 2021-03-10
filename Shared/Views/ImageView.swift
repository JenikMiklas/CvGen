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
    
    var body: some View {
        ZStack {
            if profileImg == nil && renderedImg == nil {
                NoImgView(showLibrary: $showLibrary)
            } else if (profileImg != nil && renderedImg == nil) {
                SelectImgView(profileImg: $profileImg)
            } else {
                SavedImgView(showLibrary: $showLibrary, renderedImg: $renderedImg)
            }
        }
        .navigationBarTitle("Profile image", displayMode: .inline)
        .sheet(isPresented: $showLibrary) {
            ImagePicker(profileImg: $profileImg, showLibrary: $showLibrary)
        }
        .navigationBarItems(leading: Button(action: {
            profileImg = nil
        }, label: {
            Text(profileImg != nil ? "Cancel" : "")
        }), trailing: Button(action: {
            renderedImg = takeScreenshot(origin: CGPoint(x: 0, y: (UIScreen.main.bounds.height-200)/2+100), size: CGSize(width: 200, height: 200))
            profileImg = nil
            //print(cvgVM.getDocumentsDirectory())
            saveImag()
        }, label: {
            Text( profileImg != nil ? "Save" : "")
        }))
        .onAppear {
            if renderedImg == nil {
                if cvgVM.person?.img != nil {
                    renderedImg = loadImage()
                }
            }
        }
        
    }
    
    private func loadImage() -> UIImage {
        if let nameID = cvgVM.person?.img {
            var filename = cvgVM.getDocumentsDirectory().relativePath
            filename += "/"+nameID
            //print(filename)
            //let path = Bundle.main.bundlePath.appending("/").appending(nameID)
            //print(path)
            return UIImage(contentsOfFile: filename) ?? UIImage()
            /*do {
                var str = try String(contentsOf: filename, encoding: .utf8)
                str += nameID
                return UIImage(contentsOfFile: str)!
            } catch {
                print(error.localizedDescription)
            }*/
        }
        return UIImage()
    }
    
    private func saveImag() {
        if let image = renderedImg {
            if let data = image.jpegData(compressionQuality: 0.6) {
                var nameID: String
                if let imgName = cvgVM.person?.img { nameID = imgName }
                else { nameID = UUID().uuidString+".jpg" }
                let filename = cvgVM.getDocumentsDirectory().appendingPathComponent(nameID)
                //let path = Bundle.main.resourceURL?.appendingPathComponent(nameID)
                //print(path)
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
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths[0])
        return paths[0]
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ImageView()
        }
    }
}

struct NoImgView: View {
    
    @Binding var showLibrary: Bool
    
    var body: some View {
        Button(action: { showLibrary.toggle() }, label: {
            Image(systemName: "camera")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
        })
        .frame(width: 200, height: 200)
        .background(Color.gray)
        .cornerRadius(10)
        .foregroundColor(.primary)
        .overlay(
            Text("Tap to select picture").offset(y: 190)
        )
    }
}

struct SavedImgView: View {
    
    @Binding var showLibrary: Bool
    @Binding var renderedImg: UIImage?
    
    var body: some View {
        Button(action: {
            showLibrary.toggle()
            renderedImg = nil
        }, label: {
            Image(uiImage: renderedImg ?? UIImage())
                .frame(width: 200, height: 200)
        })
        .frame(width: 200, height: 200)
        .background(Color.gray)
        .cornerRadius(10)
        .foregroundColor(.primary)
        .overlay(
            Text("Tap to select picture").offset(y: 190)
        )
    }
}

struct SelectImgView: View {
    
    @Binding var profileImg: UIImage?
    
    @GestureState private var dragOffset: CGSize = .zero
    @State private var position: CGSize = .zero
    
    @GestureState private var pinchOffset: CGFloat = 1
    @State private var pinchPosition: CGFloat = 1
    
    var body: some View {
        Image(uiImage: profileImg ?? UIImage())
            .resizable()
            .scaledToFill()
            .scaleEffect(pinchOffset * pinchPosition)
            .offset(x: dragOffset.width + position.width, y: dragOffset.height + position.height)
            .overlay(
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(width: 200, height: (UIScreen.main.bounds.height-200))
                        .offset(y: (UIScreen.main.bounds.height-200)/2+100)
                    Color.black.opacity(0.5)
                        .frame(width: 200, height: (UIScreen.main.bounds.height-200))
                        .offset(y: -(UIScreen.main.bounds.height-200)/2-100)
                    Color.black.opacity(0.5)
                        .frame(width: (UIScreen.main.bounds.width-200), height: UIScreen.main.bounds.height)
                        .offset(x: -(UIScreen.main.bounds.width-200)/2-100)
                    Color.black.opacity(0.5)
                        .frame(width: (UIScreen.main.bounds.width-200), height: UIScreen.main.bounds.height)
                        .offset(x: (UIScreen.main.bounds.width-200)/2+100)
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
