//
//  CameraController.swift
//  Fietshare
//
//  Created by Student on 07/11/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import AVFoundation
class CameraController: UIViewController {

    var backCamera: AVCaptureDevice?;
    var frontCamera: AVCaptureDevice?;
    var captureSession = AVCaptureSession();
    var currentCamera: AVCaptureDevice?;
    var photoOutput: AVCapturePhotoOutput?;
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?;
    var image: UIImage?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession();
        setupDevice();
        setupInputOutput();
        setupPreviewLayer()
        startRunningCaptureSession();
        // Do any additional setup after loading the view.
    }
    func setupCaptureSession()
    {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo;
    }
    
    func setupDevice()
    {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified);
        let devices = deviceDiscoverySession.devices;
        for device in devices
        {
            if device.position == AVCaptureDevice.Position.back
            {
                backCamera=device;
            }
            else if device.position == AVCaptureDevice.Position.front{
                frontCamera=device;
            }
        }
        currentCamera=backCamera;
    }
    
    func setupInputOutput()
    {
        do
        {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!);
            captureSession.addInput(captureDeviceInput);
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!);
        }
        catch
        {
            print(error);
        }
    }
    
    func setupPreviewLayer()
    {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill;
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer! , at: 0);
        
    }
    
    func startRunningCaptureSession()
    {
        captureSession.startRunning();
    }
    
    @IBAction func onClickEscape(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cameraButton_TouchUpInside(_ sender: Any) {
        let settings = AVCapturePhotoSettings();
        photoOutput?.capturePhoto(with: settings, delegate: self);
        //performSegue(withIdentifier: "showPhoto_Segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showPhoto_Segue"
        {
            let previewVC = segue.destination as!  PreviewController
            previewVC.image = self.image;
        }
    }

}

extension CameraController: AVCapturePhotoCaptureDelegate
{
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?)
    {
        if let imageData = photo.fileDataRepresentation()
        {
            image = UIImage(data: imageData);
            performSegue(withIdentifier: "showPhoto_Segue", sender: nil);
        }
    }
}
