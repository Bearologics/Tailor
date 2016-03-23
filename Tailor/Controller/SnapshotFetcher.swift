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
    
    func getReleases(done: (releases: [Release]?) -> ()) {
        Alamofire.request(.GET, downloadUri)
        .responseString { response in
            guard let html = response.result.value else {
                return done(releases: nil)
            }
            
            let document = try? XMLDocument(string: html)
            let body = document?.xpath("//table[@id='latest-builds']/tbody")
            
            let releases = body?.map { return self.release($0) }.flatMap { return $0 }

            done(releases: releases)
        }
    }
    
    func release(element: XMLElement) -> [Release] {
        var releases = [Release]()
        for (idx, el) in element.xpath(".//tr/td[@class='date']/time").enumerate() {
            guard let a = element.xpath(".//tr/td[@class='download']/span[@class='release']/a")[idx] else {
                continue
            }
            guard let href = a["href"] else {
                continue
            }
            releases.append(
                Release(
                    title: "\(el.stringValue), \(a.stringValue)",
                    href: href.hasPrefix("http") ? href : "https://swift.org" + href
                )
            )
        }
        return releases
    }
}
