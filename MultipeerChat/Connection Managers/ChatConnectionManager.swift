//
//  ChatConnectionManager.swift
//  MultipeerChat
//
//  Created by darklightsak_office on 20/1/2564 BE.
//  Copyright © 2564 BE Surasak W. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class ChatConnectionManager: NSObject, ObservableObject {
    private static let service = "multipeer-chat"
    
    @Published var messages: [ChatMessage] = []
    @Published var peers: [MCPeerID] = []
    @Published var connectedToChat = false
    
    let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    private var advertiserAssistant: MCNearbyServiceAdvertiser?
    private var session: MCSession?
    private var isHosting = false
    
    func send(_ message: String) {
        let chatMessage = ChatMessage(displayName: myPeerId.displayName, body: message)
        messages.append(chatMessage)
        
        guard
            let session = session,
            let data = message.data(using: .utf8),
            !session.connectedPeers.isEmpty
        else { return }
        
        do {
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func sendHistory(to peer: MCPeerID) {
        let tempFile = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("messages.data")
        guard let historyData = try? JSONEncoder().encode(messages) else { return }
        try? historyData.write(to: tempFile)
        session?.sendResource(at: tempFile, withName: "Chat_History", toPeer: peer, withCompletionHandler: { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        })
    }
    
    func join() {
        peers.removeAll()
        messages.removeAll()
        connectedToChat = true
        session = MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: .required)
        session?.delegate = self
    }
}

extension ChatConnectionManager: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            if !peers.contains(peerID) {
                DispatchQueue.main.async {
                    self.peers.insert(peerID, at: 0)
                }
                if isHosting {
                    sendHistory(to: peerID)
                }
            }
        case .notConnected:
            DispatchQueue.main.async {
                if let index = self.peers.firstIndex(of: peerID) {
                    self.peers.remove(at: index)
                }
                if self.peers.isEmpty && !self.isHosting {
                    self.connectedToChat = false
                }
            }
        case .connecting:
            print("Connecting to: \(peerID.displayName)")
        @unknown default:
             print("Unknow state: \(state)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        guard let message = String(data: data, encoding: .utf8) else { return }
        let chatMessage = ChatMessage(displayName: peerID.displayName, body: message)
        DispatchQueue.main.async {
            self.messages.append(chatMessage)
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print("Receiving chat history")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        guard
            let localURL = localURL,
            let data = try? Data(contentsOf: localURL),
            let messages = try? JSONDecoder().decode([ChatMessage].self, from: data)
        else { return }
        
        DispatchQueue.main.async {
            self.messages.insert(contentsOf: messages, at: 0)
        }
    }
}
