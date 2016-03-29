//
//  Release.swift
//  Tailor
//
//  Created by Marcus Kida on 23/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import Foundation
import Fuzi

private extension String {
    static let releaseTimeQuery = ".//tr/td[@class='date']/time"
    static let h3Query = "//h3"
    static let releaseQuery = ".//tr/td[@class='download']/span[@class='release']/a"
}

private extension String {
    func asSwiftUri() -> String {
        return self.hasPrefix("http") ? self : "https://swift.org\(self)"
    }
}

struct Release {
    let title: String
    let hrefs: [String]
}

extension Release {
    static func generate(index: Int, element: XMLElement) -> [Release] {
        var releases = [Release]()
        let els = Set(element.xpath(.releaseTimeQuery).flatMap { return $0.stringValue }).map { return String($0) }
        els.forEach { el in
            var title = el
            if let h3 = element.xpath(.h3Query)[index]?.stringValue {
                title = "\(h3): \(el)"
            }
            let pth = element.xpath(.releaseQuery)
            var hrefs = [String]()
            pth.forEach { href in
                guard let href = href["href"] else {
                    return
                }
                hrefs.append(href.asSwiftUri())
            }
            
            releases.append(
                Release(
                    title: title,
                    hrefs: hrefs
                )
            )
        }
        return releases
    }
}