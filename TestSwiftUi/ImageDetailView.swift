//
//  ImageDetail.swift
//  TestSwiftUi
//
//  Created by Jyoti Gupta on 15/10/24.
//

import SwiftUI

struct ImageDetailView: View {
    let images: [ImageModel]
    @State var selectedIndex: Int // Make selectedIndex dynamic by using @State
    
    let rows = [GridItem(.flexible())]
    
    var body: some View {
        ScrollViewReader { scrollViewProxy in
            VStack {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 8) {
                        ForEach(images.indices, id: \.self) { index in
                            GeometryReader { geo in
                                AsyncImage(url: URL(string: images[index].avatar ?? "")) { image in
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.main.bounds.width, height: 200)
                                        .id(index)
                                        .onAppear {
                                            updateSelectedIndex(using: geo.frame(in: .global), index: index)
                                        }
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: UIScreen.main.bounds.width, height: 200)
                                        .background(Color.gray.opacity(0.2))
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width, height: 200) // GeometryReader needs a fixed size
                        }
                    }
                    .background(Color.red.opacity(0.3))
                }
                .scrollTargetBehavior(.paging)
                .onAppear {
                    // Scroll to the selected index when the view appears
                    scrollToIndex(scrollViewProxy: scrollViewProxy)
                }

                // Dynamic text that updates based on the current visible image
                if selectedIndex < images.count {
                    Text(images[selectedIndex].first_name ?? "Unknown")
                        .font(.headline)
                        .padding()
                }
                
                Spacer()
            }
            .navigationTitle("Image Detail")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // Function to scroll to the selected index when the view appears
     func scrollToIndex(scrollViewProxy: ScrollViewProxy) {
        if images.indices.contains(selectedIndex) {
            scrollViewProxy.scrollTo(selectedIndex, anchor: .center)
        }
    }
    
    // Function to update the selected index dynamically as the user scrolls
     func updateSelectedIndex(using frame: CGRect, index: Int) {
        let screenMidX = UIScreen.main.bounds.midX
        if abs(frame.midX - screenMidX) < UIScreen.main.bounds.width / 2 {
            // If the image is near the center of the screen, update selectedIndex
            selectedIndex = index
        }
    }
}


