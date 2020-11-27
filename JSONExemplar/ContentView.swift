//
//  ContentView.swift
//  JSONExemplar
//
//  Created by Salvarajah, Prajina on 2020-11-26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var dogImage = UIImage()
    @State private var foxImage = UIImage()
    @State private var typeOfAnimal = 2
    
    let typeOfAnimals = ["doggo", "fox"]
        
    
    var body: some View {
        NavigationView {
            VStack {
                
                Picker ("What animal you want?", selection: $typeOfAnimal) {
                    ForEach (0 ..< typeOfAnimals.count) {
                    Text("\(self.typeOfAnimals[$0])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Button(action: {
                    // get a new dog
                    chooseTypeOfAnimal()
                }, label: {
                    Text("More pls ; - ;")
                })
                
                Image(uiImage: dogImage)
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                Spacer()
                
            }
            .navigationTitle("Bow WOW!")
        }
    }

    // < ** Get the dog pictures ** >
    
        // Get a random pooch pic!
    func fetchMoreCuteness() {
        
        // 1. Prepare a URLRequest to send our encoded data as JSON
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        // 2. Run the request and process the response
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // handle the result here – attempt to unwrap optional data provided by task
            guard let doggieData = data else {
                
                // Show the error message
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                
                return
            }
            
            // It seems to have worked? Let's see what we have
            print(String(data: doggieData, encoding: .utf8)!)
            
            // Now decode from JSON into an array of Swift native data types
            if let decodedDoggieData = try? JSONDecoder().decode(RandomDog.self, from: doggieData) {
                
                print("Doggie data decoded from JSON successfully")
                print("URL is: \(decodedDoggieData.message)")
                
                // Now fetch the image at the address we were given
                fetchImage(from: decodedDoggieData.message)
                
            } else {
                
                print("Invalid response from server.")
            }
            
        }.resume()
        
    }
    
        // Get the actual image data
    func fetchImage(from address: String) {
        
        // 1. Prepare a URL that points to the image to be loaded
        let url = URL(string: address)!
        
        // 2. Run the request and process the response
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // handle the result here – attempt to unwrap optional data provided by task
            guard let imageData = data else {
                
                // Show the error message
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                
                return
            }
            
            // Update the UI on the main thread
            DispatchQueue.main.async {
                
                // Attempt to create an instance of UIImage using the data from the server
                guard let loadedDog = UIImage(data: imageData) else {
                    
                    // If we could not load the image from the server, show a default image
                    dogImage = UIImage(named: "example")!
                    return
                }
                
                // Set the image loaded from the server so that it shows in the user interface
                dogImage = loadedDog
                
            }
            
        }.resume()
        
    }
    
    
    // < ** Get the fox pictures ** >
    
        //Get a random fox pic
    
    func fetchFoxCuteness() {
        
        // 1. Prepare a URLRequest to send our encoded data as JSON
        let url = URL(string: "https://randomfox.ca/floof/")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        // 2. Run the request and process the response
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // handle the result here – attempt to unwrap optional data provided by task
            guard let foxData = data else {
                
                // Show the error message
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                
                return
            }
            
            // It seems to have worked? Let's see what we have
            print(String(data: foxData, encoding: .utf8)!)
            
            // Now decode from JSON into an array of Swift native data types
            if let decodedFoxData = try? JSONDecoder().decode(RandomFox.self, from: foxData) {
                
                print("Fox data decoded from JSON successfully")
                print("URL is: \(decodedFoxData.image)")
                
                // Now fetch the image at the address we were given
                fetchImage(from: decodedFoxData.image)
                
            } else {
                
                print("Invalid response from server.")
            }
            
        }.resume()
        
    }
    
        // Get the actual image data
    func fetchFoxImage(from address: String) {
        
        // 1. Prepare a URL that points to the image to be loaded
        let url = URL(string: address)!
        
        // 2. Run the request and process the response
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // handle the result here – attempt to unwrap optional data provided by task
            guard let imageData = data else {
                
                // Show the error message
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                
                return
            }
            
            // Update the UI on the main thread
            DispatchQueue.main.async {
                
                // Attempt to create an instance of UIImage using the data from the server
                guard let loadedFox = UIImage(data: imageData) else {
                    
                    // If we could not load the image from the server, show a default image
                    foxImage = UIImage(named:"fox")!
                    return
                }
                
                // Set the image loaded from the server so that it shows in the user interface
                foxImage = loadedFox
                
            }
            
        }.resume()
        
    }
    
// a switch statement that should hook up with the picker to get a animal chosen
   
    func chooseTypeOfAnimal() {

    switch typeOfAnimal {
    case 0:
    // show a dog picture
    return
        fetchMoreCuteness()
    case 1:
    // show fox pictures
    return
        fetchFoxCuteness()

    default:
        break
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
