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
        
            VStack{
                
                
                Spacer()
                
                if let image = viewModel.image
                {
                    image
                    .resizable()
                    .foregroundColor(Color.pink)
                    .frame(width: 40%, height: 60%)
                    .padding()
                }
                else
                {
                    Image(systemName: "Photo")
                 
                    .frame(width: 300, height: 500)
                    
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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar
            {
                ToolbarItem(placement: .principal)
                {
                    Text("Photo Generator")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                }
            }
            
           
        
        }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
