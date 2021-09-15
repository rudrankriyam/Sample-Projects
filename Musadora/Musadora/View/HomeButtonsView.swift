//
//  HomeButtonsView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 27/06/21.
//

import SwiftUI

struct HomeButtonsView: View {
  @ObservedObject var viewModel: HomeViewModel
  
  private let size = 50.0
  
  private var isRecognizingSong: Bool {
    viewModel.isRecognizingSong
  }
  
  var body: some View {
    HStack {
      Button(action: { viewModel.addToShazamLibrary() }) {
          Image(systemName: ButtonImageType.addToLibrary)
          .imageButton(with: size, color: .green)
      }
      
      Spacer()
      
      Button(action: { viewModel.startRecognition() }) {
          Image(ButtonImageType.startRecognition)
          .imageButton(with: size * 2, color: .clear)
      }
      .disabled(isRecognizingSong)
      .scaleEffect(isRecognizingSong ? 0.8 : 1)
      .animation(songRecognitionAnimation(), value: isRecognizingSong)
      
      Spacer()
      
      Button(action: { viewModel.stopRecognition() }) {
          Image(systemName: ButtonImageType.stopRecognition)
          .imageButton(with: size, color: .red)
      }
    }
    .padding(.horizontal, 24)
  }
  
  private func songRecognitionAnimation() -> Animation {
    isRecognizingSong ? .easeInOut(duration: 1.5).repeatForever() : .default
  }
}

struct HomeButtonsView_Previews: PreviewProvider {
  static var previews: some View {
    HomeButtonsView(viewModel: HomeViewModel())
  }
}
