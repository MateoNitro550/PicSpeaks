<h1 align="center">PicSpeaks</h1>

<p align="center">
  <img src="./assets/Logo.png"> 
</p> 

## What is PicSpeaks?

PicSpeaks is an iOS app designed to provide real-time object detection and translation into a target language. By integrating **SwiftUI** for the frontend and a **Flask** backend, the app leverages the **Google Cloud Vision API** to detect objects in images and the **Google Cloud Translation API** to translate detected labels into the chosen language. The translated word can also be pronounced aloud using **AVSpeechSynthesizer**.

## Demo

Check out the demo video below to see PicSpeaks in action:

<p align="center">
  <img src="./assets/demo.mp4"> 
</p>

## Features
- **Image selection**: Pick images from your camera or photo library.
- **Object detection**: Real-time identification of objects in images using Google Cloud Vision API.
- **Translation**: Translate detected labels into a target language via Google Cloud Translation API.
- **Speech output**: Listen to the translated words pronounced in the target language using AVSpeechSynthesizer.

## Technologies
- **Frontend**: SwiftUI (iOS)
- **Backend**: Flask (Python)
- **APIs**: Google Cloud Vision API, Google Cloud Translation API
- **Speech**: AVSpeechSynthesizer (iOS)


## How It Works

1. **MainView**: Users can select an image from their camera or photo library and choose a target language. The selected image is sent to the backend for processing.
   
<p align="center">
  <img src="./assets/MainView.png"> 
</p>

2. **ResultView**: Once processed, the app displays the detected objects with their corresponding labels and translations, and offers the option to hear the translation pronounced aloud.


<p align="center">
  <img src="./assets/ResultView.png"> 
</p>
