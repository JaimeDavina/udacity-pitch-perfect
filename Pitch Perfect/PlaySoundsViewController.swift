//
//  PlaySoundsView.swift
//  Pitch Perfect
//
//  Created by Ra Ra Ra on 3/11/15.
//  Copyright (c) 2015 Ra Ra Ra. All rights reserved.
//

import UIKit

protocol PlaySoundsDelegate {
    func playSoundsGetRecordingURL() -> NSURL
}
class PlaySoundsViewController: UIViewController {
    
    var delegate: PlaySoundsDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
