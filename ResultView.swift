import SwiftUI
import AVFoundation

struct ResultView: View {
    @State var selectedLanguage: String // State to hold the selected language
    var selectedImage: UIImage? // The selected image
    var highestScoreLabel: String?  // The highest label returned from the backend
    var translatedText: String?  // The translated word from the backend
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
            Text("Result View:")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(Color(hex: "#871BAC")) // Title color
            Divider()
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

            // Display the highest label returned by the backend
            if let label = highestScoreLabel {
                Text("Detected Object: \(label)")
                    .font(.title)
                    .padding()
            } else {
                Text("No label detected")
                    .font(.title)
                    .padding()
            }

            // Display the translated word
            if let translated = translatedText {
                Text("Translation: \(translated)")
                    .font(.title)
                    .foregroundColor(Color(hex: "#871BAC"))
                    .padding()
            } else {
                Text("Translation Unavailable")
                    .font(.title)
                    .foregroundColor(Color(hex: "#871BAC"))
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
                    HStack {
                        Image("notes-icon")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .padding()
                            .foregroundColor(Color(hex: "#871BAC"))
                    }
                }
                
                // Pronunciation Button (Speaker)
                Button(action: {
                    if let translated = translatedText {
                        speak(text: translated) // Speak the translated word in the selected language
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
