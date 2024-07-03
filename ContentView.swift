import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                NavigationLink(destination: ImportReceiptView()) {
                    CustomButton(title: "Import a Receipt")
                        .cornerRadius(20)
                }
                
                NavigationLink(destination: ManualVals()) {
                    CustomButton(title: "Manual Entry")
                        .cornerRadius(20)
                }
                
                NavigationLink(destination: TakePhotoView()) {
                    CustomButton(title: "Take Photo")
                    .cornerRadius(20)
                }
            }
        }
    }
}

struct CustomButton: View {
    var title: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(title)
            Spacer()
        }
            .frame(width: 160, height: 50)
            .padding()
            .background(Color("MainPurple"))
            .foregroundColor(.white)
            .cornerRadius(0)
        }
    }

