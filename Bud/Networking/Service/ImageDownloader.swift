//
//  ImageDownloader.swift
//  Bud
//
//  Created by Ke Ma on 01/09/2018.
//  Copyright © 2018 Ke Ma. All rights reserved.
//

import Foundation
import UIKit

public typealias ImageDownloaderCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol Downloader: class {
    func exec(_ url: URL, completion: @escaping ImageDownloaderCompletion)
}

class ImageDownloader: Downloader {
    
    private var task: URLSessionDownloadTask?
    
    func exec(_ url: URL, completion: @escaping ImageDownloaderCompletion) {
        let session = URLSession.shared
        task = session.downloadTask(with: url, completionHandler: { (location, response, error) in
            do {
                
                if location != nil {
                    let data = try Data(contentsOf: location!)
                    completion(data, response, error)
                } else {
                    completion(nil, nil, error)
                }
            } catch {
                completion(nil, nil, error)
            }
        })
        task?.resume()
    }
}
