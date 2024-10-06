import SwiftUI

struct NoteView: View {
    @State private var navigateToResultView = false
    @State private var navigateToHistoryView = false
    @State private var navigateToProfileView = false
    @State private var navigateToNoteView = false
    @State private var navigateToSettingsView = false
    @State private var navigateToHomeView = false
    @State private var navigateToNoteEnterView = false
    @State private var navigateToNoteEnter2View = false
    let columnCount: Int = 1
    let gridSpacing: CGFloat = 9.0

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                NavigationLink(destination: NoteEnterView(), isActive: $navigateToNoteEnterView) {
                    EmptyView()
                }
                NavigationLink(destination: NoteEnter2View(), isActive: $navigateToNoteEnter2View) {
                    EmptyView()
                }
                LazyVGrid(columns: Array(repeating:.init(.flexible(),spacing:gridSpacing), count:columnCount),spacing:gridSpacing){
                    Button(action: {
                        navigateToNoteEnterView = true
                    }) {
                        VStack(spacing: 0){
                            Text("🇨🇳 Chinese Cantonese").font(.system(size: 30))
                        }
                    }
                    Button(action: {
                        navigateToNoteEnter2View = true
                    }) {
                        VStack(spacing: 0){
                            Text("🇨🇳 Chinese Mandarin").font(.system(size: 30))
                        }
                    }
                    Button(action: {
                        navigateToHistoryView = true
                    }) {
                        VStack(spacing: 0){
                            Text("🇺🇸 English").font(.system(size: 30))
                        }
                    }
                    Button(action: {
                        navigateToHistoryView = true
                    }) {
                        VStack(spacing: 0){
                            Text("🇫🇷 French").font(.system(size: 30))
                        }
                    }
                    Button(action: {
                        navigateToHistoryView = true
                    }) {
                        VStack(spacing: 0){
                            Text("🇮🇹 Italian").font(.system(size: 30))
                        }
                    }
                    Button(action: {
                        navigateToHistoryView = true
                    }) {
                        VStack(spacing: 0){
                            Text("🇪🇸 Spanish").font(.system(size: 30))
                        }
                    }
                    Button(action: {
                        navigateToHistoryView = true
                    }) {
                        VStack(spacing: 0){
                            Text("🇯🇵 Japanese").font(.system(size: 30))
                        }
                    }
                    Button(action: {
                        navigateToHistoryView = true
                    }) {
                        VStack(spacing: 0){
                            Text("🇰🇷 Korean").font(.system(size: 30))
                        }
                    }
                    Button(action: {
                        navigateToHistoryView = true
                    }) {
                        VStack(spacing: 0){
                            Text("🇮🇳 Hindi").font(.system(size: 30))
                        }
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
                            navigateToSettingsView = true
                        }) {
                            HStack{
                                Image(systemName: "gear")
                                Text("Settings")
                            }
                        }
                    } label: {
                        HStack {
                            Text("Notebook")
                                .font(.title)
                                .foregroundColor(Color(hex: "#871BAC"))
//                            Image("drop-down")
//                                .resizable()
//                                .frame(width: 20, height: 20)
//                                .padding(.leading, 5)
                            
                        }
                        Spacer()
                        Divider().frame(width:500)
                    }
                    .padding()
                    
                }
            }
            
        } // Toolbar Ended
        
    }
}
