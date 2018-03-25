//
//  AirDropData.swift
//  CustomUTI-Airdrop
//
//  Created by Sayantan Chakraborty on 25/03/18.
//  Copyright © 2018 Sayantan Chakraborty. All rights reserved.
//

import Foundation
import UIKit

class AirDropData: NSObject, UIActivityItemSource {
    let url:URL
    let subject:String
    
    init(url:URL,subject:String) {
        self.url = url
        self.subject = subject
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return self.url
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivityType?) -> String {
        return self.subject
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivityType?) -> Any? {
        return self.url
    }
    
//    func activityViewController(_ activityViewController: UIActivityViewController, dataTypeIdentifierForActivityType activityType: UIActivityType?) -> String {
//        return "customdata"
//    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, thumbnailImageForActivityType activityType: UIActivityType?, suggestedSize size: CGSize) -> UIImage? {
        if activityType == UIActivityType.airDrop {
            return UIImage(named: "share")
        }
        return nil
    }
}
