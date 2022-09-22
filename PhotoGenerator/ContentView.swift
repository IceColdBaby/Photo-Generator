//
//  ContentView.swift
//  PhotoGenerator
//
//  Created by Giannis Mouratidis on 20/9/22.
//

import SwiftUI



class ViewModel: ObservableObject
{
    @Published var image: Image?
    func fetchNewImage(){
        
        guard let url = URL(string:"https://random.imagecdn.app/500/500")
        else
        {
            return
        }
        let task = URLSession.shared.dataTask(with: url)
        {
            data, _, _ in
            guard let data = data
            else
            {
                return
            }
            DispatchQueue.main.async
            {
                guard let uiImage = UIImage(data:data)
                else
                {
                    return
                }
                self.image=Image(uiImage: uiImage)
                
            }
        }
        task.resume()
    }
}

struct ContentView: View {
    
    
    
    @StateObject var viewModel = ViewModel()
    var body: some View {
        
        VStack(alignment: .center, spacing: 1.0){
            
            Text("Photo Generator")
                .font(.headline)
                .fontWeight(.black)
                .foregroundColor(Color.blue)
                .multilineTextAlignment(.center)
                .frame(width: 100.0, height: 100.0)
                .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/)
                .accessibilityIdentifier(/*@START_MENU_TOKEN@*/"Identifier"/*@END_MENU_TOKEN@*/)
                .shadow(radius: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            
            
            Spacer()
            
            if let image = viewModel.image
            {
                image
                    .resizable()
                    .foregroundColor(Color.pink)
                    .padding()
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.pink/*@END_MENU_TOKEN@*/)
                  
            }
            else
            {
                Image(systemName: "Photo")
                    
                
                    
                
            }
            Spacer()
            
            
            
            Button
            {
                viewModel.fetchNewImage()
            } label:
            {
                Text("New Image !")
                    .bold()
                    .frame(width: 250, height: 40)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            
            
            
            
        }
        
        
        
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
