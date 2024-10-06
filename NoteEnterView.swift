import SwiftUI

import Foundation
struct NoteEnterView: View {
    @State private var navigateToResultView = false
    @State private var navigateToHistoryView = false
    @State private var navigateToProfileView = false
    @State private var navigateToNoteView = false
    @State private var navigateToSettingsView = false
    @State private var navigateToHomeView = false
    @State private var navigateToNoteEnterView = false
    @State private var rotationAngle: Double = 0
    @State private var isFlipped = false
      
      var body: some View {
          NavigationView {
              VStack(spacing: 0) {
                  // Flipping Rectangle Section
                  ZStack {
                      RoundedRectangle(cornerRadius: 20)
                          .foregroundColor(isFlipped ? .blue : .orange)
                          .frame(width: 300, height: 300)
                          .overlay(
                              ZStack {
                                  if isFlipped {
                                      // Back Side
//                                      Text("Mesa")
//
//                                          )
                                      Text("zhuōzi (桌子)")
                                          .font(.title)
                                          .foregroundColor(.white)
                                          .rotation3DEffect(Angle(degrees: 180), // Keep text readable
                                                            axis: (x: 0, y: 1, z: 0))
                                  } else {
                                      // Front Side
                                      
                                      Image("table-image").resizable().frame(width: 170, height: 170)
                                  }
                              }
                          )
                          .rotation3DEffect(
                              Angle(degrees: isFlipped ? 180 : 0),
                              axis: (x: 0, y: 1, z: 0)
                          )
                          .animation(.easeInOut(duration: 0.8), value: isFlipped)
                          .onTapGesture {
                              isFlipped.toggle()
                          }
                  }
                  .padding(.top, 50)
                  
                  Spacer()
              }
              .toolbar {
                  ToolbarItem(placement: .navigationBarLeading) {
                      Menu {
                          Button(action: {
                              // Navigate to home
                          }) {
                              HStack {
                                  Image(systemName: "person")
                                  Text("Person")
                              }
                          }
                          Button(action: {
                              // Navigate to note view
                          }) {
                              HStack {
                                  Image(systemName: "note.text")
                                  Text("Notebook")
                              }
                          }
                          Button(action: {
                              // Navigate to settings
                          }) {
                              HStack {
                                  Image(systemName: "gear")
                                  Text("Settings")
                              }
                          }
                      } label: {
                          HStack {
                              Text("Accounts")
                                  .font(.title)
                                  .foregroundColor(Color(hex: "#871BAC"))
                          }
                      }
                  }
              }
          }
      }
  }
   struct NoteEnterView_Previews: PreviewProvider {
       static var previews: some View {
           NoteEnterView()
       }
   }
