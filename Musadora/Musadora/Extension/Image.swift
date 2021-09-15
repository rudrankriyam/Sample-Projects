//
//  Image.swift
//  Musadora
//
//  Created by Rudrank Riyam on 27/06/21.
//

import SwiftUI

extension Image {
  func imageButton(with size: CGFloat, color: Color) -> some View {
    self
      .resizable()
      .scaledToFit()
      .frame(width: size, height: size)
      .foregroundColor(color)
  }
}

struct ButtonImageType {
    static let addToLibrary = "square.and.arrow.down.fill"
    static let startRecognition = "shazamIcon"
    static let stopRecognition = "stop.circle.fill"
}
