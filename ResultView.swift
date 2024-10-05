import SwiftUI
import AVFoundation // Import AVFoundation for Text-to-Speech

struct ResultView: View {
    @State private var selectedLanguage: String // State to hold the selected language
    @State private var navigateToNoteView = false
    let availableLanguages = [
        "Chinese Cantonese",
        "Chinese Mandarin",
        "English",
        "French",
        "Japanese",
        "Korean",
        "Spanish"
    ] // List of available languages sorted alphabetically

    var selectedImage: UIImage? // Accept the selected image
    
    // Dictionary to map translations (you can expand this)
    let translations: [String: (String, String)] = [
        "Chinese Cantonese": ("枱", "Table"),
        "Chinese Mandarin": ("桌子", "Table"),
        "English": ("Table", "Table"),
        "French": ("Pasta", "Table"),
        "Japanese": ("テーブル", "Table"),
        "Korean": ("테이블", "Table"),
        "Spanish": ("Mesa", "Table")
    ]
    
    // Speech synthesizer instance
    let speechSynthesizer = AVSpeechSynthesizer()

    init(selectedLanguage: String, selectedImage: UIImage?) {
        _selectedLanguage = State(initialValue: selectedLanguage) // Initialize selectedLanguage with the value from MainView
        self.selectedImage = selectedImage
    }
    
    var body: some View {
        VStack {
            // App title
            Text("PicSpeaks")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(Color(hex: "#871BAC")) // Change title color to custom hex

            // Display and allow user to pick the target language
            HStack {
                Text("Language: ")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#871BAC")) // Change text color to custom hex
                
                Picker("Language", selection: $selectedLanguage) { // Bind to selectedLanguage
                    ForEach(availableLanguages.sorted(), id: \.self) { language in // Sort languages alphabetically
                        Text(language).tag(language) // Use tags to link to the state variable
                    }
                }
                .pickerStyle(MenuPickerStyle()) // Use menu picker style to allow changing
                .font(.title2)
                .foregroundColor(Color(hex: "#871BAC")) // Change picker text color to custom hex
            }
            .padding()

            // Display the selected or captured image
            if let image = selectedImage {
                Image(uiImage: image) // Display the actual selected image
                    .resizable()
                    .aspectRatio(contentMode: .fit) // Maintain the original aspect ratio
                    .frame(maxWidth: 300) // Limit the maximum width
                    .padding()
            } else {
                // If no image is available, show a placeholder
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300) // Limit the maximum width
                    .padding()
            }

            // Translated Word Display (Target language)
            if let translation = translations[selectedLanguage] {
                Text(translation.0) // Show translated word
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(Color(hex: "#871BAC")) // Change text color to custom hex
            } else {
                Text("Translation Unavailable")
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(Color(hex: "#871BAC")) // Change text color to custom hex
            }
            
            NavigationLink(destination: NoteView(), isActive: $navigateToNoteView) {
                EmptyView()
            }
            HStack {
                Button(action: {
                    navigateToNoteView = true
                }) {
                    HStack{
                        Image(systemName: "note.text")
                        .frame(width: 150,height: 150)                    }
                }
                // Pronunciation Button (Speaker)
                Button(action: {
                    if let translation = translations[selectedLanguage] {
                        speak(text: translation.0) // Speak the translated word in the selected language
                    }
                }) {
                    Image(systemName: "speaker.wave.2.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                        .foregroundColor(Color(hex: "#871BAC")) // Change icon color to custom hex
                        .accessibilityLabel("Play pronunciation")
                }
                
                // Word in the default language (English)
                if let translation = translations[selectedLanguage] {
                    Text(translation.1) // Show English word
                        .font(.title2)
                        .padding()
                        .foregroundColor(Color(hex: "#871BAC")) // Change text color to custom hex
                }
            }
            Spacer()
        }
    }
    
    // Function to convert text to speech
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: languageCode(for: selectedLanguage)) // Set the voice language
        speechSynthesizer.speak(utterance) // Speak the text
    }
    
    // Helper function to get the language code based on the selected language
    func languageCode(for language: String) -> String {
        switch language {
        case "Chinese Cantonese":
            return "zh-HK"
        case "Chinese Mandarin":
            return "zh-CN"
        case "English":
            return "en-US"
        case "French":
            return "fr-FR"
        case "Japanese":
            return "ja-JP"
        case "Korean":
            return "ko-KR"
        case "Spanish":
            return "es-ES"
        default:
            return "en-US" // Default to English if unknown
        }
    }
}
