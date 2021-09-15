//
//  ContentView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 27/06/21.
//


import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel = HomeViewModel()
  @Environment(\.openURL) var openURL
  
  var body: some View {
    NavigationView {
      VStack {
        List {
          ForEach(viewModel.mediaItems, id: \.shazamID) { item in
            Button(action: { openAppleMusic(with: item.appleMusicURL) }) {
              ShazamMusicRow(item: item)
            }
            .buttonStyle(.plain)
            .listRowSeparator(.hidden)
          }
        }
        .listStyle(.plain)
        
        HomeButtonsView(viewModel: viewModel)
      }
      .navigationTitle("Musadora")
    }
    .navigationViewStyle(.stack)
  }
  
  private func openAppleMusic(with url: URL?) {
    if let url = url {
      openURL(url)
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

