//
//  ViewController.swift
//  Voice Pitch
//
//  Created by Roydon Jeffrey on 6/21/16.
//  Copyright © 2016 Italyte. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet var recordLabel: UILabel!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    @IBAction func record(sender: AnyObject) {
        
        recordButton.enabled = false
        stopRecordingButton.enabled = true
        recordLabel.text = "Recording in progress"
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        
        recordButton.enabled = true
        stopRecordingButton.enabled = false
        recordLabel.text = "Tap to Record"
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopRecordingButton.enabled = false
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AVAudioRecorder finished saving the recording")
        
        if flag {
            self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        }else {
            print("Failure to successfully save recording")
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            
            let recordedAudioURL = sender as! NSURL
            
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }


}

