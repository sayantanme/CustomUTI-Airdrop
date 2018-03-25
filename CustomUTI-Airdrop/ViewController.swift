//
//  ViewController.swift
//  CustomUTI-Airdrop
//
//  Created by Sayantan Chakraborty on 24/03/18.
//  Copyright © 2018 Sayantan Chakraborty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var filePath:URL?
    var contentsOfFile = ""
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView), name: NSNotification.Name(rawValue: "updateTextView"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func shareDocumentType(_ sender: UIBarButtonItem) {
        let path = Bundle.main.path(forResource: "random", ofType: "customdata")
        let url = URL(fileURLWithPath: path!)
        let item = AirDropData(url: url, subject: "random")
        let items = [item]
        //print(path)
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityController.excludedActivityTypes = [.addToReadingList,.assignToContact,.copyToPasteboard,.markupAsPDF,.message,.saveToCameraRoll,.print,.postToWeibo,.postToTwitter,.postToTencentWeibo,.postToFlickr,.postToFacebook,.openInIBooks,.message]
        if let popoverPresentationController = activityController.popoverPresentationController {
            popoverPresentationController.barButtonItem = sender
        }
        present(activityController, animated: true, completion: nil)
    }
    
    func showText(text:String){
        textView.text = text
    }
    
    @objc fileprivate func updateTextView(){
        let fileM = FileManager.default
        let documentsUrls = fileM.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do{
            let fileUrls = try fileM.contentsOfDirectory(at: documentsUrls, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            let customFiles = fileUrls.filter{$0.pathExtension == "customdata"}
            guard customFiles.count > 0 else {
                return
            }
            filePath = customFiles[0]
            if let fPath = filePath{
                let text = try String(contentsOf: fPath)
                contentsOfFile = text
                showText(text: contentsOfFile)
            }
            print(fileUrls)
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
}

