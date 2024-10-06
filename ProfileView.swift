import SwiftUI

struct ProfileView: View {
    @State private var navigateToResultView = false
    @State private var navigateToHistoryView = false
    @State private var navigateToProfileView = false
    @State private var navigateToNoteView = false
    @State private var navigateToSettingsView = false
    @State private var navigateToHomeView = false
    @State private var text: String = ""
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Title Section
                Button(action: {
                    navigateToHistoryView = true
                }) {
                    VStack {
                        HStack{
                            Text("Profile Photos: ").padding()
                            Image(systemName: "person")
                        }
                        HStack{
                            Text("Name: ")
                            TextField("Name...", text: $text)
                        }
                        HStack{
                            Text("User ID: ").padding()
                        }
                        HStack{
                            Text("QR Code: ").padding()
                        }
                        HStack{
                            Text("Email: ").padding()
                        }
                        HStack{
                            Text("Password & Security: ").padding()
                        }
                    }.fontWeight(.bold)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {

                            Button(action: {
                                navigateToHomeView = true
                            }) {
                                HStack{
                                    Image(systemName: "person")
                                    Text("Person")
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
                                Text("Accounts")
                                    .font(.title)
                                    .foregroundColor(Color(hex: "#871BAC"))
//                                Image("drop-down")
//                                    .resizable()
//                                    .frame(width: 20, height: 20)
//                                    .padding(.leading, 5)
                                    
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
