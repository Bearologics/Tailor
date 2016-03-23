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
    let downloadUri = "https://swift.org/download"
    
    func getReleases(done: (releases: [Entry]?) -> ()) {
        Alamofire.request(.GET, downloadUri)
        .responseString { response in
            guard let html = response.result.value else {
                return done(releases: nil)
            }
            
            let items = try? XMLDocument(string: html)
                .xpath("//span[@class='release']/a[@title='Download']").map { element in
                return Entry(
                    title: element.stringValue,
                    href: "https://swift.org\(element.attr("href")!)"
                )
            }
            
            done(releases: items)
        }
    }
}
