//
//  ContentView.swift
//  TestSwiftUi
//
//  Created by Jyoti Gupta on 10/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var images: [ImageModel] = []
    @ObservedObject var vm = ViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(Array(vm.personeDataMode.enumerated()), id: \.element.id) { index, image in
                        NavigationLink(destination: ImageDetailView(images: vm.personeDataMode, selectedIndex: index)) {
                            AsyncImage(url: URL(string: image.avatar ?? "")) { image in
                                image.resizable()
                                     .aspectRatio(contentMode: .fill)
                                     .frame(width: UIScreen.main.bounds.width/2 - 20, height: UIScreen.main.bounds.height/4)
                            } placeholder: {
                               // ProgressView()
                            }
                            .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Image Gallery")
            .onAppear {
                fetchImages()
            }
        }
    }
    
    func fetchImages() {
        Task{
            await vm.implementAPICallAndConvertItinModel()
        }
    }
}
