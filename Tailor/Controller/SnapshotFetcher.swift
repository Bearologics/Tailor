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

private extension String {
    static let bodyQuery = "//table[@id='latest-builds']/tbody"
}

class SnapshotFetcher: NSObject {
    let downloadUri = "https://swift.org/download"

    func getReleases(_ done: @escaping (_ releases: [Release]?) -> ()) {
        Alamofire.request(downloadUri)
        .responseString { response in
            guard let html = response.result.value else {
                return done(nil)
            }
            
            done(
                try? XMLDocument(string: html).xpath(.bodyQuery)
                    .enumerated().flatMap { Release.generate($0, element: $1) }
            )
        }
    }
}
