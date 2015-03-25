//
//  AudioRecording.swift
//  Pitch Perfect
//
//  Created by Ra Ra Ra on 3/24/15.
//  Copyright (c) 2015 Ra Ra Ra. All rights reserved.
//

import Foundation

class AudioRecording {
    let basePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
    var fileURL = NSURL()
    
    init() {
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [basePath, recordingName]
        if let url = NSURL.fileURLWithPathComponents(pathArray) {
            fileURL = url
        }
    }
}