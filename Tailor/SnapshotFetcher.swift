//
//  SnapshotFetcher.swift
//  Tailor
//
//  Created by Marcus Kida on 23/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import Cocoa
import Alamofire
import Fuzi

class SnapshotFetcher: NSObject {
    let downloadUri = "http://swift.org/download"
    
    func getReleases(done: (items: [String]?) -> ()) {
        Alamofire.request(.GET, downloadUri)
        .responseString { response in
            guard let html = response.result.value else {
                return done(items: nil)
            }
            
            let document = try? XMLDocument(string: html)
            let items = document?.xpath("//table[@id='latest-builds']/tbody/tr").first.map { element in
                return element.xpath("//td[@class='date']/time")
                }.flatMap { return $0.map { return $0.attr("title")! } }
            
            done(items: items)
        }
    }
}
