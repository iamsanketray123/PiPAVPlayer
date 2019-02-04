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

    @IBAction func startPiP(_ sender: Any) {
        PIPKit.show(with: PiPController.viewController())
    }
    
}


