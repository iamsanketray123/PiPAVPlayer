//
//  PiPController.swift
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

struct YouTubeVideoQuality {
    static let hd720 = NSNumber(value: XCDYouTubeVideoQuality.HD720.rawValue)
    static let medium360 = NSNumber(value: XCDYouTubeVideoQuality.medium360.rawValue)
    static let small240 = NSNumber(value: XCDYouTubeVideoQuality.small240.rawValue)
}

class PiPController: UIViewController, PIPUsable {
    
    var initialState: PIPState { return .pip }
    
    var pipSize: CGSize = CGSize(width: 256, height: 188)
    let player : AVPlayer? = nil
    
    
    
    let playerVC = AVPlayerViewController()
    
    fileprivate func playYoutube(identifier: String) {
        
//        let url = URL(fileURLWithPath: "https://s3.amazonaws.com/kargopolov/kukushka.mp3")
//        let url = URL(fileURLWithPath: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
//        let player = AVPlayer(url: url)
//        playerVC.view.frame = self.view.frame
//        playerVC.player = player
//        addChild(playerVC)
//        view.addSubview(playerVC.view)
//        playerVC.didMove(toParent: self)
//        player.play()
        
        let playerViewController = AVPlayerViewController()
        
        self.view.addSubview(playerViewController.view)
        playerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        playerViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playerViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        playerViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        let cancel = UIButton(type: .system)
        self.view.addSubview(cancel)
        cancel.anchor(top: self.view.topAnchor, left: nil, bottom: nil, right: self.view.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 24, height: 24)
        cancel.setImage(UIImage(named: "cancel")?.withRenderingMode(.alwaysOriginal), for: .normal)
        cancel.addTarget(self, action: #selector(fuckingClose), for: .touchUpInside)
        
        playerViewController.view.layer.cornerRadius = 8
        playerViewController.view.layer.masksToBounds = true
        
        playerViewController.player = player
        addChild(playerViewController)
        view.addSubview(playerViewController.view)
        playerViewController.didMove(toParent: self)
        
        
        weak var weakPlayerViewController: AVPlayerViewController? = playerViewController
        XCDYouTubeClient.default().getVideoWithIdentifier(identifier, completionHandler: { video, error in
            if video != nil {
                var streamURLs = video?.streamURLs
                let streamURL = streamURLs?[XCDYouTubeVideoQualityHTTPLiveStreaming] ?? streamURLs?[YouTubeVideoQuality.hd720] ?? streamURLs?[YouTubeVideoQuality.medium360] ?? streamURLs?[YouTubeVideoQuality.small240]
                if let streamURL = streamURL {
                    weakPlayerViewController?.player = AVPlayer(url: streamURL)
                }
                weakPlayerViewController?.player?.play()
            } else {
                self.dismiss(animated: true)
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        
        playYoutube(identifier: "JeBzqDov-3M&t=5s")
        
    }

    
    @objc func fuckingClose() {
        print("closing")
        PIPKit.dismiss(animated: true)
    }
    
    
    class func viewController() -> PiPController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "PiPController") as? PiPController else {
            fatalError("PiPController is null")
        }
        return viewController
    }
    
}


// I always have a colors stuct for all the cusom colors in my app
// How it's used: let backgroundColor = Colors.darkGrey

struct Colors {
    static let uReactRed    = UIColor(red: 231.0/255.0, green: 60.0/255.0, blue: 60.0/255.0, alpha: 1.0)
    static let darkGrey     = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
    static let veryDarkGrey = UIColor(red: 25.0/255.0, green: 25.0/255.0, blue: 25.0/255.0, alpha: 1.0)
    static let lightGrey    = UIColor(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 1.0)
    static let white        = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let black        = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
}

// I put all my cell identifiers for Table/Collection Views in here as well
// How it's used: let cell = tableView.dequeueReusableCell(withIdentifier: Cells.reaction) as! ReactionCell

struct Cells {
    static let reaction             = "ReactionCell"
    static let addReaction          = "AddReactionCell"
    static let removeReaction       = "RemoveReactionCell"
}


// These next 2 structs work together, and it's how I adjust for screen size when necessary
// Most of the time auto-layout handles things, but sometimes to need a fine adjustment for one screen size
// How it's used:  If DeviceTypes.iPhone5 { // do iPhone5 specific stuff }

struct ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}


struct DeviceTypes {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale
    
    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXr               = idiom == .phone && ScreenSize.maxLength == 828.0
    static let isiPhoneXsMax            = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0
    
    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMax || isiPhoneXr
    }
    
    
}

extension UIView {
    func anchor(top : NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop : CGFloat, paddingLeft : CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width : CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
