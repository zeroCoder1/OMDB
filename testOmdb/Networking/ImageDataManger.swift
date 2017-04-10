//
//  ImageDataManger.swift
//  testOmdb
//
//  Created by shrutesh sharma on 25/02/17.
//  Copyright © 2017 Singularity. All rights reserved.
//

import Foundation
import UIKit

class ImageDataManager {
    fileprivate let directory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    
    func pathForFilename(_ filename: String) -> String {
        return directory.appendingPathComponent(filename)
    }
    
    func storeImageData(_ imageData: Data, withFileName filename: String) {
        try? imageData.write(to: URL(fileURLWithPath: pathForFilename(filename)), options: [.atomic])
    }
    
    func fetchImageWithFileName(_ filename: String) -> UIImage? {
        return UIImage(contentsOfFile: pathForFilename(filename))
    }
    
    func deletePhoto(_ filename: String) {
        do {
            try FileManager.default.removeItem(atPath: pathForFilename(filename))
        }  catch {
            print(error)
        }
    }
}
