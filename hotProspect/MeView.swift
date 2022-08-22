//
//  MeView.swift
//  hotProspect
//
//  Created by Sampel on 03/08/2022.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI


struct MeView: View {
    @State private var  name = "Anomynous"
    @State private var emailAddress =  "you@yoursite.com"
    @State private var qrCode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                
                TextField("email address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                
                Image(uiImage : qrCode)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu{
                        Button {
                 
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: qrCode)
                        }label: {
                            Label("Save to phone", systemImage: "square.and.arrow.down")
                        }
                    }
            }
            .navigationTitle("Your code")
            .onAppear(perform: updateCode)
            .onChange(of: name){ _ in updateCode()}
            .onChange(of: emailAddress){ _ in updateCode()}
        }
    }
    
    func updateCode() {
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }
    func generateQRCode (from string : String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImg)
                
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
