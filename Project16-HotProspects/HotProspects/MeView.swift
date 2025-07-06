//
//  MeView.swift
//  HotProspects
//
//  Created by Victoria Slyunko on 4/7/25.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    
    // Store user input using @AppStorage so it's saved across app launches
    @AppStorage("name") private var name = "Anonymous"
    @AppStorage("emailAddress") private var emailAddress = "anonymous@gmail.com"
    
    @State private var qrCode = UIImage()
    
    // Core Image context used to render CIImages into CGImages
    let context = CIContext()
    // Core Image filter to generate QR codes
    let filter = CIFilter.qrCodeGenerator ()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                
                TextField("Email", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                
                // Display a generated QR code from name and email
                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        ShareLink(item: Image(uiImage: qrCode), preview: SharePreview("Share QR Code", image: Image(uiImage: qrCode)))
                    }
            }
            .navigationTitle("Your Code")
            .onAppear(perform: updateCode)
            .onChange(of: name, updateCode)
            .onChange(of: emailAddress, updateCode)
        }
    }
    
    func updateCode() {
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }
    
    // Generate a QR code from a string and return it as a UIImage
    func generateQRCode(from string: String) -> UIImage {
        
        // Convert the input string to UTF-8 data
        filter.message = Data(string.utf8)
        
        // Get CIImage output from the filter and render it into a CGImage
        if let outputImage = filter.outputImage,
            let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                // Return the final UIImage
                return UIImage(cgImage: cgImage)
            }
        
        // Return an error symbol if QR generation fails
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    MeView()
}
