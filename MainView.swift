import SwiftUI

struct MainView: View {
    @State private var selectedLanguage = "English"
    @State private var languages = ["Chinese Cantonese", "Chinese Mandarin", "English", "French", "Italian", "Japanese", "Korean", "Spanish"]
    @State private var isCameraPickerPresented = false
    @State private var isPhotoLibraryPickerPresented = false
    @State private var selectedImage: UIImage? = nil
    @State private var navigateToResultView = false

    var body: some View {
        NavigationView {
            VStack {
                Text("PicSpeaks")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(Color(hex: "#5C0F76"))

                HStack {
                    // Camera Button
                    Button(action: {
                        isCameraPickerPresented = true
                    }) {
                        VStack {
                            Image(systemName: "camera")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding()
                                .foregroundColor(Color(hex: "#871BAC"))
                            Text("Camera")
                                .foregroundColor(Color(hex: "#871BAC"))
                        }
                    }
                    .sheet(isPresented: $isCameraPickerPresented, onDismiss: {
                        if selectedImage != nil {
                            navigateToResultView = true
                        }
                    }) {
                        ImagePicker(isCamera: true, selectedImage: $selectedImage)
                    }

                    // Photo Library Button
                    Button(action: {
                        isPhotoLibraryPickerPresented = true
                    }) {
                        VStack {
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding()
                                .foregroundColor(Color(hex: "#871BAC"))
                            Text("Photo Library")
                                .foregroundColor(Color(hex: "#871BAC"))
                        }
                    }
                    .sheet(isPresented: $isPhotoLibraryPickerPresented, onDismiss: {
                        if selectedImage != nil {
                            navigateToResultView = true
                        }
                    }) {
                        ImagePicker(isCamera: false, selectedImage: $selectedImage)
                    }
                }
                .padding()

                // Language Picker
                Text("Target Language")
                    .font(.title)
                    .foregroundColor(Color(hex: "#871BAC"))

                Spacer().frame(height: 0)

                Picker("Target Language", selection: $selectedLanguage) {
                    ForEach(languages, id: \.self) { language in
                        Text(language)
                            .font(.title)
                            .foregroundColor(Color(hex: "#800080"))
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding()
                .frame(maxWidth: .infinity, minHeight: 150)
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)

                // Navigation Link to ResultView
                NavigationLink(destination: ResultView(selectedLanguage: selectedLanguage, selectedImage: selectedImage), isActive: $navigateToResultView) {
                    EmptyView()
                }
            }
        }
    }
}
