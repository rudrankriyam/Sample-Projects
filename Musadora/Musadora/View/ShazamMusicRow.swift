//
//  ShazamMusicRow.swift
//  Musadora
//
//  Created by Rudrank Riyam on 27/06/21.
//

import SwiftUI
import ShazamKit

struct ShazamMusicRow: View {
  var item: SHMediaItem
  
  var body: some View {
    ZStack {
      ArtworkImage(url: item.artworkURL) { image in
        image
          .scaledToFill()
          .layoutPriority(-1)
          .transition(.opacity.combined(with: .scale))
      }
      
      ShazamMusicCard(item: item)
            .background(.ultraThinMaterial)
    }
    .cornerRadius(12.0)
    .padding(4.0)
  }
}

struct ShazamMusicRow_Previews: PreviewProvider {
  static var previews: some View {
    ShazamMusicRow(item: SHMediaItem(properties: [:]))
  }
}
