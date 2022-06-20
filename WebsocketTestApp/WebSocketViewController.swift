//
//  ViewController.swift
//  WebsocketTestApp
//
//  Created by hayden on 2022/6/15.
//

import UIKit
import Starscream

class WebSocketViewController: UIViewController {
    
    var socket: WebSocket?
    var isConnected = false
    
    var messages: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSocket()
    }
    
    func setupSocket() {
        let serverUrl = "wss://socketsbay.com/wss/v2/2/demo/"
        if let url = URL(string: serverUrl) {
            let request = URLRequest(url: url)
            socket = WebSocket(request: request)
            socket?.delegate = self
            socket?.connect()
        } else {
            // TODO: error handling
        }
    }
}

extension WebSocketViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCell.reuseIdentifier, for: indexPath as IndexPath) as? MessageCell else { fatalError("Unable to dequeue MessageCell.") }
        let message = messages[indexPath.row]
        cell.configure(with: message)
        return cell
    }
}

extension WebSocketViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width / 5.0)
    }
}

extension WebSocketViewController: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocketClient) {
        switch event {
        case .connected(let header):
            isConnected = true
            print("websocket is connected: \(header)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code \(code)")
        case .text(let string):
            messages.append(string)
            print("Received text: \(string)")
        case .binary(let data):
            print("Received data: \(data.count)")
        case .pong( _):
            print("pong")
        case .ping( _):
            print("ping")
        case .error(let optional):
            isConnected = false
            print("error:\(String(describing: optional))")
        case .viabilityChanged(let bool):
            print("viabilityChanged\(bool)")
        case .reconnectSuggested(let bool):
            print("reconnectSuggested\(bool)")
        case .cancelled:
            isConnected = false
            print("cancelled")
        }
    }
}

