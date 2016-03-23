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
    
    func uniq<S: SequenceType, E: Hashable where E==S.Generator.Element>(source: S) -> [E] {
        var seen: [E:Bool] = [:]
        return source.filter { seen.updateValue(true, forKey: $0) == nil }
    }
    
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
        let els = uniq(element.xpath(".//tr/td[@class='date']/time").flatMap { return $0.stringValue })
        els.forEach { el in
            let pth = element.xpath(".//tr/td[@class='download']/span[@class='release']/a")
            var hrefs = [String]()
            pth.forEach { href in
                guard let href = href["href"] else {
                    return
                }
                hrefs.append(href.hasPrefix("http") ? href : "https://swift.org" + href)
            }
            
            releases.append(
                Release(
                    title: el,
                    hrefs: hrefs
                )
            )
        }
        return releases
    }
}
