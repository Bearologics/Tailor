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

    func getReleases(done: (releases: [Release]?) -> ()) {
        Alamofire.request(.GET, downloadUri)
        .responseString { response in
            guard let html = response.result.value else {
                return done(releases: nil)
            }
            
            done(releases:
                try? XMLDocument(string: html).xpath(.bodyQuery)
                    .enumerate().map {
                        return Release.generate($0, element: $1)
                    }.flatMap { return $0 }
            )
        }
    }
}
