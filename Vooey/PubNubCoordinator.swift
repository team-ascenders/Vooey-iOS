//
//  PubNubCoordinator.swift
//  Vooey
//
//  Created by Blake Tsuzaki on 3/8/19.
//  Copyright © 2019 Modoki. All rights reserved.
//

import AVFoundation
import UIKit
import PubNub

enum AppState {
    case ftui, empty, active
}

protocol PubNubDelegate {
    func receivedTerms(_ terms: [String])
    func needsState(_ state: AppState)
}

class PubNubCoordinator: NSObject {
    static let shared = PubNubCoordinator()
    
    var client = PubNub.clientWithConfiguration(PNConfiguration(publishKey: "pub-c-35c0a342-eb63-440b-b688-89d8ced6f499", subscribeKey: "sub-c-634d2abe-28df-11e9-991a-bee2ac9fced0"))
    var delegate: PubNubDelegate?
    var player: AVPlayer?
    var shouldPlayAudio = false
    
    override init() {
        super.init()
        
        client.addListener(self)
        client.subscribeToChannels(["default"], withPresence: true)
    }
}

extension PubNubCoordinator: PNObjectEventListener {
    func client(_ client: PubNub, didReceiveMessage message: PNMessageResult) {
        guard let stringData = message.data.message as? String,
              let data = stringData.data(using: .utf8, allowLossyConversion: false) else { return }
        
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        
        if let payload = json as? [String: Any], let type = payload["type"] as? String {
            if type == "terms" {
                guard let terms = payload["terms"] as? [String] else { return }
                
                delegate?.receivedTerms(terms)
            } else if type == "audio" && shouldPlayAudio {
                guard let urlString = payload["url"] as? String,
                      let url = URL(string: urlString) else { return }
                
                let asset = AVURLAsset(url: url)
                let playerItem = AVPlayerItem(asset: asset)
                let player = AVPlayer(playerItem: playerItem)
                
                player.volume = 1.0
                player.play()
                
                self.player = player
            } else if type == "command" {
                guard let commandString = payload["command"] as? String else { return }
                
                if commandString == "ftui" {
                    delegate?.needsState(.ftui)
                }
                else if commandString == "empty" {
                    delegate?.needsState(.empty)
                }
                else if commandString == "active" {
                    delegate?.needsState(.active)
                }
                else if commandString == "kill" {
                    fatalError("Killed by Puppet")
                }
            }
        }
    }
}
