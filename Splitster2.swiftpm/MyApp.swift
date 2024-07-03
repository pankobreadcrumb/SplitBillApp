// MyApp.swift
import SwiftUI

@main
struct MyApp: App {
    @State private var shouldNavigate = false
    @State private var isTitleVisible = true  // To control the visibility of the title
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ZStack {
                    if shouldNavigate {
                        ContentView()
                    } else {
                        Text("Divvy")
                            .font(.largeTitle)
                            .foregroundColor(.purple)
                            .opacity(isTitleVisible ? 1 : 0)  // Apply opacity based on isTitleVisible
                            .onAppear {
                                // After 3 seconds, start fading out the title
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    withAnimation(.easeOut(duration: 1.8)) {  // 2 seconds fade-out duration
                                        isTitleVisible = false
                                    }
                                    
                                    // After the 1.5 seconds of fading, navigate to ContentView
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        withAnimation {
                                            shouldNavigate = true
                                        }
                                        }
                                    }
                            }
                    }
                }
            }
        }
    }
}
