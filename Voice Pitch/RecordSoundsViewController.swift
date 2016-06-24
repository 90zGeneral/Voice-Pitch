//
//  ViewController.swift
//  Voice Pitch
//
//  Created by Roydon Jeffrey on 6/21/16.
//  Copyright © 2016 Italyte. All rights reserved.
//

import UIKit
import AVFoundation            //Import to gain access to all the functionalities and configurations of this framework

//To allow this viewController to be responsive to objects from the AVAudioRecorder class
class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    //Create the necessary varibles for the view
    @IBOutlet var recordLabel: UILabel!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var stopRecordingButton: UIButton!
    
    //Create variable with type AVAudioRecorder to access its methods at a later point
    var audioRecorder: AVAudioRecorder!
    
    //Determines what happens upon click
    @IBAction func record(sender: AnyObject) {
        
        //Disable the record button after it has been tapped
        recordButton.enabled = false
        
        //Activate the stopRecord button and change recordLabel text
        stopRecordingButton.enabled = true
        recordLabel.text = "Recording in progress"
        
        //Find the complete directory path where the recording will live inside an array and convert it (1st element in array) to a String
        let dirPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        
        //Create a name for the recording with its file extention as a String
        let recordingName = "recordedVoice.wav"
        
        //Store the complete recording path and the file name in an array as separate elements
        let pathArray = [dirPath, recordingName]
        
        //Create a new complete URL for the recording using the elements from pathArray
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        //Create a session for the audio and set its categories to record and play back the audio
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        //Assure that audioRecorder will have a filePath with the recording by using the Error Handler "try!" and unwrap filePath's value 
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        
        //The audioRecorder will receive messages from the viewController through the AVAudioRecorderDelegate protocol
        audioRecorder.delegate = self
        
        //Turn on level metering for audio waves, create file & prepare to record the audio, then start the recording to the file
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    //To stop the audio recording
    @IBAction func stopRecording(sender: AnyObject) {
        
        //Reactivate the record button, deactivate the stop button, change recordLabel back to original text
        recordButton.enabled = true
        stopRecordingButton.enabled = false
        recordLabel.text = "Tap to Record"
        
        //Terminate the audioRecorder
        audioRecorder.stop()
        
        //Create a session for the audio and assure that its setActive value is set to false
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
        
        //Disable the stopRecord button right before the view appears
        stopRecordingButton.enabled = false
        
    }
    
    //Finish the recording and check whether it was successfull saved
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AVAudioRecorder finished saving the recording")
        
        //If successful, transition to the viewController with a "stopRecording" Identifier name along with the url for the audio
        if flag {
            self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        }else {
            print("Failure to successfully save recording")
        }
    }
    
    //Set up the segue between the 2 viewControllers
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //Check and run this statement if the viewController's identifier has a value of "stopRecording"
        if segue.identifier == "stopRecording" {
            
            //Make PlaySoundsViewController the destination viewController before the segue executes and assign it to this constant
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            
            //Assign the recorded audio file path as an NSURL type to this constant
            let recordedAudioURL = sender as! NSURL
            
            //Assign this NSURL value to the recordedAudioURL variable declared inside the PlaySoundsViewController class
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
        
    }


}

