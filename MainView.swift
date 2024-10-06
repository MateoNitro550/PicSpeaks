import SwiftUI

struct MainView: View {
    @State private var selectedLanguage = "English"
    @State private var languages = ["Chinese Cantonese", "Chinese Mandarin", "English", "French", "Hindi", "Italian", "Japanese", "Korean", "Spanish"]
    @State private var isCameraPickerPresented = false
    @State private var isPhotoLibraryPickerPresented = false
    @State private var selectedImage: UIImage? = nil
    @State private var highestScoreLabel: String? = nil  // Store highest label from backend
    @State private var translatedText: String? = nil  // Store translated text from backend
    @State private var navigateToResultView = false
    @State private var navigateToHistoryView = false
    @State private var navigateToProfileView = false
    @State private var navigateToNoteView = false
    @State private var navigateToSettingsView = false

    // Function to send the image to Flask backend and receive the highest score label and translation
    func sendImageToBackend() {
        guard let image = selectedImage else { return }

        // Convert UIImage to JPEG data
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }

        // Convert image data to base64 string
        let base64String = imageData.base64EncodedString()

        // Create the URL for the POST request
        guard let url = URL(string: "https://19e5-192-31-236-1.ngrok-free.app/upload") else {
            print("Invalid URL")
            return
        }

        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Create the JSON body
        let jsonBody = [
            "image": base64String,
            "language": selectedLanguage
        ]

        // Convert dictionary to JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody) else { return }

        // Send the request
        let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data, let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let highestLabel = jsonResponse["highest_score_label"] as? String,
               let translatedText = jsonResponse["translated_text"] as? String {
                DispatchQueue.main.async {
                    self.highestScoreLabel = highestLabel  // Store highest label returned from the backend
                    self.translatedText = translatedText  // Store translated word
                    self.navigateToResultView = true  // Navigate to ResultView
                }
            }
        }

        task.resume()
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        // Camera Button
                        Button(action: {
                            isCameraPickerPresented = true
                        }) {
                            VStack {
                                Image(systemName: "camera")
                                    .resizable()
                                    .frame(width: 115, height: 125)
                                    .padding()
                                    .foregroundColor(Color(hex: "#871BAC"))
                                Text("Camera")
                                    .foregroundColor(Color(hex: "#871BAC"))
                            }
                        }
                        .sheet(isPresented: $isCameraPickerPresented, onDismiss: {
                            if selectedImage != nil {
                                sendImageToBackend()  // Send image after dismiss
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
                                    .frame(width: 115, height: 125)
                                    .padding()
                                    .foregroundColor(Color(hex: "#871BAC"))
                                Text("Photo Library")
                                    .foregroundColor(Color(hex: "#871BAC"))
                            }
                        }
                        .sheet(isPresented: $isPhotoLibraryPickerPresented, onDismiss: {
                            if selectedImage != nil {
                                sendImageToBackend()  // Send image after dismiss
                            }
                        }) {
                            ImagePicker(isCamera: false, selectedImage: $selectedImage)
                        }

                    }
                    .padding()

                    // Language Picker
                    Text("Target Language:")
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
                    NavigationLink(destination: ResultView(selectedLanguage: selectedLanguage, selectedImage: selectedImage, highestScoreLabel: highestScoreLabel, translatedText: translatedText), isActive: $navigateToResultView) {
                        EmptyView()
                    }
                    NavigationLink(destination: HistoryView(), isActive: $navigateToHistoryView) {
                                            EmptyView()
                                        }
                                        NavigationLink(destination: ProfileView(), isActive: $navigateToProfileView) {
                                            EmptyView()
                                        }
                                        NavigationLink(destination: NoteView(), isActive: $navigateToNoteView) {
                                            EmptyView()
                                        }
                                        NavigationLink(destination: SettingsView(), isActive: $navigateToSettingsView) {
                                            EmptyView()
                                        }

                    Button(action: {
                        navigateToHistoryView = true
                    }) {
                        VStack(spacing: 0){
                            Image(systemName: "clock.arrow.circlepath")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .padding()
                                .foregroundColor(Color(hex: "#871BAC"))
                            Text("History").foregroundColor(Color(hex: "#871BAC")).fontWeight(.bold)
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Menu {
                            Button(action: {
                                navigateToProfileView = true
                            }) {
                                HStack {
                                    Image(systemName: "person")
                                    Text("Account")
                                }
                            }
                            Button(action: {
                                navigateToNoteView = true
                            }) {
                                HStack {
                                    Image(systemName: "note.text")
                                    Text("Notebook")
                                }
                            }
                            Button(action: {
                                navigateToSettingsView = true
                            }) {
                                HStack {
                                    Image(systemName: "gear")
                                    Text("Settings")
                                }
                            }
                        } label: {
                            HStack {
                                Text("PicSpeaks")
                                    .font(.title)
                                    .foregroundColor(Color(hex: "#871BAC"))
                                Image("drop-down")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.leading, 5)
                            }
                            Spacer()
                            Divider().frame(width: 500)
                        }
                        .padding()
                    }
                }
            }
        }
    }
}
