//
//  ShazamMusicCard.swift
//  Musadora
//
//  Created by Rudrank Riyam on 27/06/21.
//

import SwiftUI
import ShazamKit

struct ShazamMusicCard: View {
  var item: SHMediaItem
  
  var body: some View {
    HStack {
      ArtworkImage(url: url) { image in
        image
          .scaledToFit()
          .transition(.opacity.combined(with: .scale))
      }
      .cornerRadius(12.0)
      .frame(width: 120, height: 120.0)
      
      VStack(alignment: .leading, spacing: 4.0) {
        Text(name)
          .fontWeight(.bold)
          .font(.callout)
        
        Text(artistName)
          .fontWeight(.light)
          .font(.caption)
      }
      .foregroundColor(.white)
      .frame(maxWidth: .infinity, alignment: .leading)
      .multilineTextAlignment(.leading)
    }
  }
  
  private var name: String {
    item.title ?? ""
  }
  
  private var artistName: String {
    item.artist ?? ""
  }
  
  private var url: URL? {
    item.artworkURL
  }
}


struct ShazamMusicCard_Previews: PreviewProvider {
  static var previews: some View {
    ShazamMusicCard(item: SHMediaItem(properties: [:]))
  }
}
