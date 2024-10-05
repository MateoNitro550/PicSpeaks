import SwiftUI

struct MainView: View {
    @State private var selectedLanguage = "English"
    @State private var languages = ["Chinese Cantonese", "Chinese Mandarin", "English", "French", "Italian", "Japanese", "Korean", "Spanish"]
    @State private var isCameraPickerPresented = false
    @State private var isPhotoLibraryPickerPresented = false
    @State private var selectedImage: UIImage? = nil
    @State private var navigateToResultView = false
    @State private var navigateToHistoryView = false
    @State private var navigateToProfileView = false
    @State private var navigateToNoteView = false
    @State private var navigateToSettingsView = false
    @State private var navigateToHomeView = false
    

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
                                    .frame(width: 125, height: 125)
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
                                    .frame(width: 125, height: 100)
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
                    NavigationLink(destination: HistoryView(), isActive: $navigateToHistoryView) {
                        EmptyView()
                    }
                    NavigationLink(destination: ProfileView(), isActive: $navigateToProfileView) {
                        EmptyView()
                    }
                    NavigationLink(destination: HomeView(), isActive: $navigateToHomeView) {
                        EmptyView()
                    }
                    NavigationLink(destination: NoteView(), isActive: $navigateToNoteView) {
                        EmptyView()
                    }
                    
                    Button(action: {
                        navigateToHistoryView = true
                    }) {
                        VStack {
                            Image(systemName: "clock.arrow.circlepath")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .padding()
                                .foregroundColor(Color(hex: "#871BAC"))
                            Text("History")
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Menu {
                            Button(action: {
                                navigateToHomeView = true
                            }) {
                                HStack{
                                    Image(systemName: "house.circle")
                                    Text("Home")
                                }
                            }
                            
                            Button(action: {
                                navigateToProfileView = true
                            }) {
                                HStack{
                                    Image(systemName: "person")
                                    Text("Account")
                                }
                            }
                            
                            Button(action: {
                                navigateToNoteView = true
                            }) {
                                HStack{
                                    Image(systemName: "note.text")
                                    Text("Notebook")
                                }
                            }
                            Button(action: {
                                navigateToSettingsView = true
                            }) {
                                HStack{
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
                                
                            }
                            Divider()
                        }
                        
                        
                    }
                    
                } // Toolbar
            }
        }
    }
    }
