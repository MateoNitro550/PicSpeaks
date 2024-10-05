import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Title Section
                HStack {
                    Text("PicSpeaks")
                        .font(.title)
                        .foregroundColor(Color(hex: "#871BAC"))
                    Spacer()
                    Image("drop-down")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .padding()
                Divider()

                // Navigation Links Section
                VStack(spacing: 0) {
                    NavigationLink(destination: HomeView()) {
                        HStack {
                            Image(systemName: "house.circle")
                            Text("Home")
                                .padding()
                            Spacer()
                        }
                    }
                    NavigationLink(destination: ProfileView()) {
                        HStack {
                            Image(systemName: "person")
                            Text("Account")
                                .padding()
                            Spacer()
                        }
                    }
                    NavigationLink(destination: NoteView()) {
                        HStack {
                            Image(systemName: "note.text")
                            Text("Notebook")
                                .padding()
                            Spacer()
                        }
                    }
                    NavigationLink(destination: SettingsView()) {
                        HStack {
                            Image(systemName: "gear")
                            Text("Settings")
                                .padding()
                            Spacer()
                        }
                    }
                }
            }
            .navigationBarHidden(true) // Hide the default navigation bar
        }
    }
}
//
//// Dummy views for navigation
//struct HomeView: View {
//    var body: some View {
//        Text("Home View")
//    }
//}
//
//struct NoteView: View {
//    var body: some View {
//        Text("Notebook View")
//    }
//}
//
//struct SettingsView: View {
//    var body: some View {
//        Text("Settings View")
//    }
//}
