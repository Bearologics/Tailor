//
//  SnapshotFetcher.swift
//  Tailor
//
//  Created by Marcus Kida on 23/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import Cocoa

class SnapshotFetcher: NSObject {
    let downloadUri = URL(string: "https://xcodereleases.com/data.json")!

    func getReleases(_ done: @escaping (_ releases: [Release]?) -> ()) {
        let request = URLRequest(url: downloadUri)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            guard let releases = try? JSONDecoder().decode([Release].self, from: data) else {
                return
            }
            done(releases)
        }.resume()
    }
}
