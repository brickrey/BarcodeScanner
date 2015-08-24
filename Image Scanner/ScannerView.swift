//
//  ScannerView.swift
//  Image Scanner
//
//  Created by Brick Reyes Zambrano on 22/8/15.
//  Copyright © 2015 Brick Reyes Zambrano. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerView: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    /// Object that coordinate the flow of data from AV input devices to outputs.
    let session : AVCaptureSession = AVCaptureSession()
    @IBOutlet var cameraView: UIView!
    @IBOutlet var barCodeType: UILabel!
    @IBOutlet var barCodeString: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            /// Capture input data from selected device.
            let input = try AVCaptureDeviceInput(device: AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo))
            // Add a type of device that will capture the data.
            session.addInput(input)
        }catch let error as NSError{
            NSLog(error.description)
        }
        /// Intercepter of Metadata
        let outputMetadata = AVCaptureMetadataOutput()
        outputMetadata.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        // Add metadata intercepter into the flow of data.
        session.addOutput(outputMetadata)
        // Capture all posible metadata.
        outputMetadata.metadataObjectTypes = outputMetadata.availableMetadataObjectTypes
        /// Captures video as it is being captured by an input device.
        let video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = cameraView.bounds
        video.videoGravity = AVLayerVideoGravityResizeAspectFill
        // Add video layer into the current view.
        cameraView.layer.addSublayer(video)
        
        // Start the scanner. You'll have to end it yourself later.
        session.startRunning()
    }
    
    @IBAction func newScan(sender: AnyObject) {
        barCodeType.text = " "
        barCodeString.text = " "
        // Start the scanner.
        session.startRunning()
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        // The scanner is capable of capturing multiple 2-dimensional barcodes in one scan.
        for metadata in metadataObjects {
            // If actual metadata type match any of the one needed
            if Utility.barCodeTypes.contains(metadata.type) {
                NSLog((metadata as! AVMetadataMachineReadableCodeObject).stringValue)
                // Stop scanner.
                self.session.stopRunning()
                // Show barcode type.
                barCodeType.text = metadata.type
                // Show barcode data.
                barCodeString.text = (metadata as! AVMetadataMachineReadableCodeObject).stringValue
                break
            }
        }
    }
    
}