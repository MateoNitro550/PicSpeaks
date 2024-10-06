import SwiftUI

struct SettingsView: View {
    @State private var navigateToResultView = false
    @State private var navigateToHistoryView = false
    @State private var navigateToProfileView = false
    @State private var navigateToNoteView = false
    @State private var navigateToSettingsView = false
    @State private var navigateToHomeView = false
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Title Section
                Button(action: {
                    navigateToHistoryView = true
                }) {
                    VStack {
                        
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
                    } label: {
                        HStack {
                            Text("Settings")
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
