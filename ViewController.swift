//
//  ViewController.swift
//  Aqua Hydrate
//
//  Created by Varsha Balaji on 8/16/20.
//  Copyright © 2020 Varsha Balaji. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?

    @IBOutlet weak var SignUpButton: UIButton!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //set up video in the background
        setUpVideo()
    }
    
    func setUpVideo(){
        
        //Get the path to the resource in the bundle
        //fyi : everything in the app is into a bundle so you need to find the specific path within the bundle that links to the video
        let bundlePath = Bundle.main.path(forResource: "waterdrop", ofType: "mp4")
        //if it cant find the specifiv video it will return nil
        guard bundlePath != nil else{
            return
        }
        
        //Create a URL from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        //Create the video player item
        //AVPlayer item is the actual video
        let PlayerItem = AVPlayerItem(url: url)
        
        //Create the player
        videoPlayer = AVPlayer(playerItem: PlayerItem)
        
        //Create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        //Adjust the size and frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.6, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        //Add it and play it
        videoPlayer?.play()
    }
    
    func setUpElements(){
        Utilities.styleFilledButton(SignUpButton)
        Utilities.styleHollowButton(LoginButton)
    }


}

