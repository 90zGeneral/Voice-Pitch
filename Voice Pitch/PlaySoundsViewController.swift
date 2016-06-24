//
//  PlaySoundsViewController.swift
//  Voice Pitch
//
//  Created by Roydon Jeffrey on 6/22/16.
//  Copyright © 2016 Italyte. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    //Declare all the play back sound effect buttons
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darthVaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    //This inherits the url file path from the prepareForSegue method within the RecordSoundsViewController class
    var recordedAudioURL: NSURL!
    
    //These variables will manipulate the play back sound effects
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    //Organize the play back sounds with an integer value type
    enum ButtonType: Int {
        case Snail = 0, Rabbit, ChipMunk, DarthVader, Echo, Reverb
    }
    
    //This method controls all the play back sound effect buttons when tapped
    @IBAction func playSoundForButton(sender: UIButton) {
        print("play sound button pressed")
        
        //Check and evaluate each case in the enum above based on their tag numbers from storyboard as their integer values
        switch (ButtonType(rawValue: sender.tag)!) {
        case .Snail:
            playSound(rate: 0.5)
        case .Rabbit:
            playSound(rate: 1.5)
        case .ChipMunk:
            playSound(pitch: 1000)
        case .DarthVader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        
        //Set the status of the play back to playing
        configureUI(.Playing)
    }
    
    //Terminate the play back sound
    @IBAction func stopButtonPressed(sender: UIButton) {
        print("stop audio button pressed")
        
        //Call this function when stop button tapped
        stopAudio()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Call this function when view loads on screen
        setupAudio()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //Don't allow play back sounds to play upon view appearing on the screen
        configureUI(.NotPlaying)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
