//
//  GameViewController.swift
//  AR
//
//  Created by Zachary Cheshire on 1/9/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import AVFoundation

class GameViewController: UIViewController {

    @IBOutlet weak var cameraView: UIView!
    
    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    var preview: AVCaptureVideoPreviewLayer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // create a capture session for the camera input
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        
        // Choose the back camera as input device
        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let cameraError as NSError {
            error = cameraError
            input = nil
        }
        
        // check if the camera input is available
        if error == nil && captureSession.canAddInput(input) {
            // ad camera input to the capture session
            captureSession.addInput(input)
            let photoImageOutput = AVCapturePhotoOutput()
            
            // Create an UIlayer with the capture session output
            photoImageOutput.photoSettingsForSceneMonitoring = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecJPEG])
            if captureSession.canAddOutput(photoImageOutput) {
                captureSession.addOutput(photoImageOutput)
                
                preview = AVCaptureVideoPreviewLayer(session: captureSession)
                preview?.videoGravity = AVLayerVideoGravityResizeAspectFill
                preview?.connection.videoOrientation = AVCaptureVideoOrientation.portrait
                preview?.frame = cameraView.frame
                cameraView.layer.addSublayer(preview!)
                captureSession.startRunning()
            }
        }
        
    }

}
