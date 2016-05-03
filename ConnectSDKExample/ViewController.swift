//
//  ViewController.swift
//  ConnectSDKExample
//
//  Created by jaeseung.ko on 2016. 4. 28..
//  Copyright © 2016년 jasonko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DevicePickerDelegate, ConnectableDeviceDelegate {
    
    @IBOutlet var resultTextView: UITextView!
    
    var _discoveryManager : DiscoveryManager?
    var _device : ConnectableDevice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        _discoveryManager = DiscoveryManager.sharedManager()
        _discoveryManager!.startDiscovery()
        
        _discoveryManager!.devicePicker().delegate = self;
        _discoveryManager!.devicePicker().showPicker(nil)
    }

    @IBAction func hShareIamge(sender: AnyObject) {
        _discoveryManager?.devicePicker().delegate = self
        _discoveryManager?.devicePicker().showPicker(sender)
    }
    
    @IBAction func launchChHomeAction(sender: AnyObject) {
        _device?.launcher().launchApp("channelplus.us", success: { (launchSession) in
            print("Success to launch CH+ Home") 

            }, failure: { (error) in
                print("Fail to launch CH+ Home")
        })
    }
    
    @IBAction func launchLiveTVAction(sender: AnyObject) {
        _device?.launcher().launchApp("com.webos.app.livetv", success: { (launchSession) in
            print("Success to launch CH+ Home")
            
            }, failure: { (error) in
                print("Fail to launch CH+ Home")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func connectableDeviceReady(device: ConnectableDevice!) {
        print("Connectable Device Ready : \(device.id)")
    }
    
    func connectableDeviceDisconnected(device: ConnectableDevice!, withError error: NSError!) {
        
        print("Connectable Device Disconnected : \(device.id)")
    }
    
    func devicePicker(picker: DevicePicker!, didSelectDevice device: ConnectableDevice!) {
        
        _device = device
        _device!.delegate = self
        _device!.connect()
        
        let modelName = _device!.modelName
        let address = _device!.address
        let id = _device!.id
        let modelNumber = _device!.modelNumber
        let lastknownIPAddress = _device!.lastKnownIPAddress
        
        let resultString = "Model Name : \(modelName)\nFriendly Name : \(_device!.friendlyName)\nIP Address : \(address)\nID : \(id)\n"
        
        resultTextView!.text = resultString
        
    }

}

