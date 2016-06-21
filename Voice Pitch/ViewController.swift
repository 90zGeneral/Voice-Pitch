//
//  ViewController.swift
//  Voice Pitch
//
//  Created by Roydon Jeffrey on 6/21/16.
//  Copyright © 2016 Italyte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var recordLabel: UILabel!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var stopRecordingButton: UIButton!
    
    @IBAction func record(sender: AnyObject) {
        
        recordButton.enabled = false
        stopRecordingButton.enabled = true
        recordLabel.text = "Recording in progress"
        
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        
        recordButton.enabled = true
        stopRecordingButton.enabled = false
        recordLabel.text = "Tap to Record"
        
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


}

