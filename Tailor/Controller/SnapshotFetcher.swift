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
    
    func getReleases(done: (entries: [Entry]?) -> ()) {
        Alamofire.request(.GET, downloadUri)
        .responseString { response in
            guard let html = response.result.value else {
                return done(entries: nil)
            }
            
            let document = try? XMLDocument(string: html)
            let items = document?.xpath("//table[@id='latest-builds']/tbody/tr").first.map { element in
                return element.xpath("//td[@class='date']/time")
            }.flatMap { return $0.map { return $0.attr("title") } }

            done(entries: items?.map { let o = ($0 != nil); return Entry(title: o ? $0! : "", enabled: o ? true : false) })
        }
    }
}
