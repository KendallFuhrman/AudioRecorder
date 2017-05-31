//
//  ViewController.swift
//  AudioRecorder2
//
//  Created by Kendall Fuhrman on 5/30/17.
//  Copyright © 2017 Kendall Fuhrman. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    var stringToPass: String = ""
    
    @IBOutlet weak var recordB: UIButton!
    @IBOutlet weak var playB: UIButton!
    

    
    @IBAction func recordAudio(_ sender: UIButton) {
        if audioRecorder?.isRecording == false {
        audioRecorder?.record()
        print("recording")
    }
    }
    
    @IBAction func playAudio(_ sender: UIButton) {
        audioRecorder?.stop()
        print("hi")
//        performSegue(withIdentifier: "stopRecording" , sender: sender)
        
//        do {
//                try audioPlayer = AVAudioPlayer(contentsOf:
//                    (audioRecorder?.url)!)
//                audioPlayer!.delegate = self
//                audioPlayer!.prepareToPlay()
//                audioPlayer!.play()
//                print("playing")
//            } catch let error as NSError {
//                print("audioPlayer error: \(error.localizedDescription)")
//            }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fileMgr = FileManager.default
        
        let dirPaths = fileMgr.urls(for: .documentDirectory,
                                    in: .userDomainMask)
        
        let soundFileURL = dirPaths[0].appendingPathComponent("sound.caf")
        stringToPass = soundFileURL.absoluteString
        
        let recordSettings =
            [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
             AVEncoderBitRateKey: 16,
             AVNumberOfChannelsKey: 2,
             AVSampleRateKey: 44100.0] as [String : Any]
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(
                AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        
        do {
            try audioRecorder = AVAudioRecorder(url: soundFileURL,
                                                settings: recordSettings as [String : AnyObject])
            audioRecorder?.prepareToRecord()
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let pitchVC:PitchViewController = segue.destination as! PitchViewController
            
            pitchVC.receivedAudio = audioRecorder?.url

        }
    }

}

