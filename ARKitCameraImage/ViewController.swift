//
//  ViewController.swift
//  ARKitCameraImage
//
//  Created by Ralf Ebert on 12.11.19.
//  Copyright © 2019 Ralf Ebert. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.delegate = self
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {

        guard let currentFrame = session.currentFrame else { return }
        let capturedImage = currentFrame.capturedImage

        debugPrint("Display size", UIScreen.main.bounds.size)
        debugPrint("Camera frame resolution", CVPixelBufferGetWidth(capturedImage), CVPixelBufferGetHeight(capturedImage))

        let ciimage = CIImage(cvImageBuffer: capturedImage)
        let transform = currentFrame.displayTransform(for: .portrait, viewportSize: UIScreen.main.bounds.size)
        var transformedImage = ciimage.transformed(by: transform)
        debugPrint("Transformed size", transformedImage.extent.size)

    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
