import SwiftUI
import AVFoundation

struct ResultView: View {
    @State var selectedLanguage: String // State to hold the selected language
    var selectedImage: UIImage? // The selected image
    var highestScoreLabel: String?  // The highest label returned from the backend
    @State var navigateToNoteView = false
    let speechSynthesizer = AVSpeechSynthesizer()
    let availableLanguages = [
        "Chinese Cantonese",
        "Chinese Mandarin",
        "English",
        "French",
        "Japanese",
        "Korean",
        "Spanish",
        "Hindi"
    ]

    // Function to convert text to speech
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
        case "Hindi":
            return "hi-IN"
        default:
            return "en-US" // Default to English if unknown
        }
    }

    // Helper function to get the language code based on the selected language
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: languageCode(for: selectedLanguage)) // Set the voice language
        speechSynthesizer.speak(utterance) // Speak the text
    }

    var body: some View {
        VStack {
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
            
            // Display the selected image
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300)
                    .padding()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300)
                    .padding()
            }
            
            // Updated: Display the highest label returned by the backend
            if let label = highestScoreLabel {
                Text("Detected Object: \(label)")
                    .font(.title)
                    .fontWeight(.bold)  // Making the label more prominent
                    .foregroundColor(Color(hex: "#871BAC"))  // Apply the custom color
                    .padding()
            } else {
                Text("No label detected")
                    .font(.title)
                    .foregroundColor(Color.red)  // Set red color for error case
                    .padding()
            }
            
            Spacer()

            NavigationLink(destination: NoteView(), isActive: $navigateToNoteView) {
                EmptyView()
            }
            
            HStack {
                Button(action: {
                    navigateToNoteView = true
                }) {
                    HStack{
                        Image(systemName: "note.text")
                            .frame(width: 150, height: 150)
                    }
                }
                
                // Pronunciation Button (Speaker)
                Button(action: {
                    if let label = highestScoreLabel {
                        speak(text: label)  // Speak the highest scored label
                    }
                }) {
                    Image(systemName: "speaker.wave.2.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                        .foregroundColor(Color(hex: "#871BAC")) // Change icon color to custom hex
                        .accessibilityLabel("Play pronunciation")
                }
            }
        }
    }
}
