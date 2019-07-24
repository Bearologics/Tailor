//
//  SnapshotFetcher.swift
//  Tailor
//
//  Created by Marcus Kida on 23/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import Cocoa

class SnapshotFetcher: NSObject {
    enum Error {
        case noData(String)
    }
    
    let downloadUri = URL(string: "https://xcodereleases.com/data.json")!

    func getReleases(_ done: @escaping (_ releases: [Xcode]?, _ error: Error?) -> ()) {
        let request = URLRequest(url: downloadUri)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return done(nil, .noData("Error loading Xcode versions."))
            }
            guard let releases = try? JSONDecoder().decode([Xcode].self, from: data) else {
                return
            }
            done(releases, nil)
        }.resume()
    }
}
