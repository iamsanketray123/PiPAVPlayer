//
//  ViewController.swift
//  PiPYoutube
//
//  Created by Sanket Ray on 1/27/19.
//  Copyright © 2019 Sanket Ray. All rights reserved.
//

import UIKit
import PIPKit
import AVFoundation
import AVKit
import XCDYouTubeKit

class ViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        var playerViewController = AVPlayerViewController()

//        
//        playerViewController.view.frame = self.view.frame
//        playerViewController.player = player
//        addChild(playerViewController)
//        view.addSubview(playerViewController.view)
//        playerViewController.didMove(toParent: self)

//        
//        weak var weakPlayerViewController: AVPlayerViewController? = playerViewController
//        XCDYouTubeClient.default().getVideoWithIdentifier("2pQ04FriBxs", completionHandler: { video, error in
//            if video != nil {
//                var streamURLs = video?.streamURLs
//                var streamURL = streamURLs?[XCDYouTubeVideoQualityHTTPLiveStreaming] ?? streamURLs?[YouTubeVideoQuality.hd720] ?? streamURLs?[YouTubeVideoQuality.medium360] ?? streamURLs?[YouTubeVideoQuality.small240] as? URL
//                if let streamURL = streamURL {
//                    weakPlayerViewController?.player = AVPlayer(url: streamURL)
//                }
//                weakPlayerViewController?.player?.play()
//            } else {
//                self.dismiss(animated: true)
//            }
//        })

        
//        var playerViewController = AVPlayerViewController()
//        present(playerViewController, animated: true)
//
//        weak var weakPlayerViewController: AVPlayerViewController? = playerViewController
//        XCDYouTubeClient.default().getVideoWithIdentifier("2pQ04FriBxs", completionHandler: { video, error in
//            if video != nil {
//                var streamURLs = video?.streamURLs
//                var streamURL = streamURLs?[XCDYouTubeVideoQualityHTTPLiveStreaming] ?? streamURLs?[YouTubeVideoQuality.hd720] ?? streamURLs?[YouTubeVideoQuality.medium360] ?? streamURLs?[YouTubeVideoQuality.small240] as? URL
//                if let streamURL = streamURL {
//                    weakPlayerViewController?.player = AVPlayer(url: streamURL)
//                }
//                weakPlayerViewController?.player?.play()
//            } else {
//                self.dismiss(animated: true)
//            }
//        })
        
    }


    @IBAction func startPiP(_ sender: Any) {
        PIPKit.show(with: PiPController.viewController())
//        playYoutubeVideo(videoIdentifier: "2pQ04FriBxs")
        

    }
    
    func playYoutubeVideo(videoIdentifier: String?) {
        
        let playerViewController = AVPlayerViewController()
        self.present(playerViewController, animated: true, completion: nil)
        
        XCDYouTubeClient.default().getVideoWithIdentifier(videoIdentifier) { [weak playerViewController] (video: XCDYouTubeVideo?, error: Error?) in
            if let streamURLs = video?.streamURLs, let streamURL = (streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?? streamURLs[YouTubeVideoQuality.hd720] ?? streamURLs[YouTubeVideoQuality.hd720] ?? streamURLs[YouTubeVideoQuality.medium360]) {
                let player = AVPlayer(url: streamURL)
                
                playerViewController?.view.frame = self.view.frame
                playerViewController?.player = player
                self.addChild(playerViewController!)
                self.view.addSubview(playerViewController!.view)
                playerViewController?.didMove(toParent: self)
                
                playerViewController?.player?.play()
                
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}


