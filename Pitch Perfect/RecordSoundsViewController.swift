//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Ra Ra Ra on 3/11/15.
//  Copyright (c) 2015 Ra Ra Ra. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate, PlaySoundsDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    let fileName = "pitch-perfect-recording"
    var recordingURL: NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        recordingURL = NSURL(fileURLWithPath: fileName)
    }
    
    override func viewWillAppear(animated: Bool) {
        recordButton.enabled = true
        stopButton.hidden = true
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressRecord(sender: UIButton) {
        recordButton.enabled = false
        stopButton.hidden = false
        
        if AVAudioSession.sharedInstance().recordPermission() != AVAudioSessionRecordPermission.Granted {
            AVAudioSession.sharedInstance().requestRecordPermission() { (granted) in
                // don't do anything
            }
        } else {
            var settings = [
                AVFormatIDKey: kAudioFormatAppleLossless,
                AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
                AVEncoderBitRateKey : 320000,
                AVNumberOfChannelsKey: 2,
                AVSampleRateKey : 44100.0
            ]
            var error: NSErrorPointer!
            audioRecorder = AVAudioRecorder(URL: recordingURL, settings: settings, error: error)
            
            if error == nil {
                audioRecorder.delegate = self
                audioRecorder.prepareToRecord()
            }
        }
    }
    
    @IBAction func didPressStop(sender: UIButton) {
        audioRecorder.stop()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        performSegueWithIdentifier("showPlaySounds", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var controller = sender?.destinationViewController as PlaySoundsViewController
        controller.delegate = self
    }

    func playSoundsGetRecordingURL() -> NSURL {
        return recordingURL
    }

}

