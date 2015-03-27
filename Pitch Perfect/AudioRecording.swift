//
//  AudioRecording.swift
//  Pitch Perfect
//
//  Created by Ra Ra Ra on 3/24/15.
//  Copyright (c) 2015 Ra Ra Ra. All rights reserved.
//

import Foundation

class AudioRecording {
    var url = NSURL()
    var title = "I am never used anywhere."
    
    init(fileUrl: NSURL, fileTitle: String) {
        url = fileUrl
        title = fileTitle
    }
    
    class func getDefaultURL() -> NSURL? {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let name = formatter.stringFromDate(currentDateTime) + ".wav"
        let pathArray = [path, name]
        return NSURL.fileURLWithPathComponents(pathArray)
    }
   
}