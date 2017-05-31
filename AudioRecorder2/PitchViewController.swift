//
//  PitchViewController.swift
//  AudioRecorder2
//
//  Created by Kendall Fuhrman on 5/31/17.
//  Copyright © 2017 Kendall Fuhrman. All rights reserved.
//

import UIKit
import AVFoundation

class PitchViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    var receivedAudio: URL!
    var audioPlayer: AVAudioPlayer!
    var engine: AVAudioEngine!
    var file: AVAudioFile!
   
    @IBAction func slowPlay(_ sender: UIButton) {
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: (receivedAudio)!)
                audioPlayer!.delegate = self
                audioPlayer!.prepareToPlay()
                audioPlayer!.enableRate = true
                audioPlayer!.rate = 0.5
                audioPlayer!.play()
                print("playing")
     } catch
            let error as NSError {
                print("audioPlayer error: \(error.localizedDescription)")
            }

    }
    
    @IBAction func fastPlay(_ sender: UIButton) {
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: (receivedAudio)!)
            audioPlayer!.delegate = self
            audioPlayer!.prepareToPlay()
            audioPlayer!.enableRate = true
            audioPlayer!.rate = 2
            audioPlayer!.play()
            print("playing")
        } catch
            let error as NSError {
                print("audioPlayer error: \(error.localizedDescription)")
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        engine = AVAudioEngine()
        do{
            file = try AVAudioFile(forReading: receivedAudio!, commonFormat: AVAudioCommonFormat.pcmFormatFloat32, interleaved: false)
        } catch let error as NSError {
            //soundFile = nil
            fatalError("Error creating soundFile, \(error.localizedDescription)")
        }
        }

    @IBAction func highPlay(_ sender: UIButton) {

        
        let audioPlayerNode = AVAudioPlayerNode()
        
        audioPlayerNode.stop()
        engine.stop()
        engine.reset()
        
        engine.attach(audioPlayerNode)
        
        let changeAudioUnitTime = AVAudioUnitTimePitch()
        
        changeAudioUnitTime.pitch = 1000
        
        engine.attach(changeAudioUnitTime)
        engine.connect(audioPlayerNode, to: changeAudioUnitTime, format: nil)
        engine.connect(changeAudioUnitTime, to: engine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(file!, at: nil, completionHandler: nil)
        
        do{
                try engine.start()
        } catch {
            print("Blame it on Rohit")
        }
        audioPlayerNode.play()
        }

    @IBAction func lowPlay(_ sender: Any) {
        
        let audioPlayerNode = AVAudioPlayerNode()
        
        audioPlayerNode.stop()
        engine.stop()
        engine.reset()
        
        engine.attach(audioPlayerNode)
        
        let changeAudioUnitTime = AVAudioUnitTimePitch()
        
        changeAudioUnitTime.pitch = -200
        
        engine.attach(changeAudioUnitTime)
        engine.connect(audioPlayerNode, to: changeAudioUnitTime, format: nil)
        engine.connect(changeAudioUnitTime, to: engine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(file!, at: nil, completionHandler: nil)
        
        do{
            try engine.start()
        } catch {
            print("Blame it on Rohit")
        }
        audioPlayerNode.play()
        print ("low")
    }
    
    @IBAction func alienPlay(_ sender: UIButton) {
        
        
        let audioPlayerNode = AVAudioPlayerNode()
        
        audioPlayerNode.stop()
        engine.stop()
        engine.reset()
        
        engine.attach(audioPlayerNode)
        
        let changeAudioUnitTime = AVAudioUnitTimePitch()
        
        changeAudioUnitTime.pitch = 1000
        changeAudioUnitTime.rate = 3
        engine.attach(changeAudioUnitTime)
        engine.connect(audioPlayerNode, to: changeAudioUnitTime, format: nil)
        engine.connect(changeAudioUnitTime, to: engine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(file!, at: nil, completionHandler: nil)
        
        do{
            try engine.start()
        } catch {
            print("Blame it on Rohit")
        }
        audioPlayerNode.play()

    }
    
    @IBAction func robotPlay(_ sender: UIButton) {
        
        
        let audioPlayerNode = AVAudioPlayerNode()
        
        audioPlayerNode.stop()
        engine.stop()
        engine.reset()
        
        engine.attach(audioPlayerNode)
        
        let changeAudioUnitTime = AVAudioUnitTimePitch()
        
        changeAudioUnitTime.pitch = -200
        changeAudioUnitTime.rate = 0.5
        
        engine.attach(changeAudioUnitTime)
        engine.connect(audioPlayerNode, to: changeAudioUnitTime, format: nil)
        engine.connect(changeAudioUnitTime, to: engine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(file!, at: nil, completionHandler: nil)
        
        do{
            try engine.start()
        } catch {
            print("Blame it on Rohit")
        }
        audioPlayerNode.play()
    }


    @IBAction func stopAudio(_ sender: UIButton) {
        
        audioPlayer.stop()
        engine.stop()
        
    }
    

}

