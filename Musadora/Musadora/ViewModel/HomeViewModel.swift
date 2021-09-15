//
//  HomeViewModel.swift
//  Musadora
//
//  Created by Rudrank Riyam on 27/06/21.
//

import Combine
import ShazamKit
import AVKit

@MainActor class HomeViewModel: NSObject, ObservableObject {
  @Published private(set) var mediaItems: [SHMediaItem] = []
  @Published private(set) var isRecognizingSong = false
  
  private let session = SHSession()
  private let engine = AVAudioEngine()
  private let feedback = UINotificationFeedbackGenerator()
  
  override init() {
    super.init()
    session.delegate = self
  }
  
  public func startRecognition() {
    feedback.prepare()
    
    do {
      if engine.isRunning {
        stopRecognition()
        return
      }
      
      try prepareAudioRecording()
      
      generateSignature()
      
      try startAudioRecording()
      
      feedback.notificationOccurred(.success)
    } catch {
      // Handle errors here
      print(error)
      feedback.notificationOccurred(.error)
    }
  }
  
  public func stopRecognition() {
    isRecognizingSong = false
    engine.stop()
    engine.inputNode.removeTap(onBus: .zero)
  }
  
  public func addToShazamLibrary() {
    SHMediaLibrary.default.add(mediaItems) { error in
      if let error = error {
        print(error)
      } else {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
      }
    }
  }
}

// MARK: Audio Recognition
extension HomeViewModel {
  private func prepareAudioRecording() throws {
    let audioSession = AVAudioSession.sharedInstance()
    
    try audioSession.setCategory(.record)
    try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
  }
  
  private func generateSignature() {
    let inputNode = engine.inputNode
    let recordingFormat = inputNode.outputFormat(forBus: .zero)
    
    inputNode.installTap(onBus: .zero, bufferSize: 1024,
                         format: recordingFormat) { [weak session] buffer, _ in
      session?.matchStreamingBuffer(buffer, at: nil)
    }
  }
  
  private func startAudioRecording() throws {
    engine.prepare()
    try engine.start()
    
    isRecognizingSong = true
  }
}

// MARK:- SHSessionDelegate
extension HomeViewModel: SHSessionDelegate {
  func session(_ session: SHSession, didFind match: SHMatch) {
    
    guard let mediaItem = match.mediaItems.first else { return }
    
    async {
      if mediaItems.contains(where: { $0.shazamID == mediaItem.shazamID }) {
        // Do nothing
      } else {
        self.mediaItems.append(mediaItem)
      }
    }
  }
}
