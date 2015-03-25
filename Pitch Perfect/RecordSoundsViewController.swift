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
    @IBOutlet weak var recordLabel: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    var audioRecording: AudioRecording!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        recordButton.enabled = true
        audioRecording = AudioRecording()
    }
    private func setupRecordingSession() {
        let session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        session.setActive(true, error: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        recordButton.enabled = true
        stopButton.hidden = true
        recordLabel.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressRecord(sender: UIButton) {
        
        let session = AVAudioSession.sharedInstance()
        if session.respondsToSelector("requestRecordPermission") && session.recordPermission() != AVAudioSessionRecordPermission.Granted {
            AVAudioSession.sharedInstance().requestRecordPermission() { (granted) in
                if granted {
                    self.setupRecordingSession()
                    self.startRecording()
                }
            }

        } else {
            
            self.setupRecordingSession()
            self.startRecording()
        }
    
    }
    
    private func startRecording() {
        audioRecorder = AVAudioRecorder(URL: audioRecording.fileURL, settings: nil, error: nil)
        
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        recordButton.enabled = false
        recordLabel.hidden = false
        stopButton.hidden = false
    }
    
    @IBAction func didPressStop(sender: UIButton) {
        audioRecorder.stop()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if flag {
            performSegueWithIdentifier("showPlaySounds", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var controller = segue.destinationViewController as PlaySoundsViewController
        controller.delegate = self
        let session = AVAudioSession.sharedInstance()
        session.setActive(false, error: nil)
    }

    func playSoundsGetRecordingURL() -> NSURL {
        return audioRecording.fileURL
    }

}

