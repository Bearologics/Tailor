//
//  Xcode+ReleaseSuffix.swift
//  Tailor
//
//  Created by Marcus Kida on 01.12.19.
//  Copyright © 2019 Marcus Kida. All rights reserved.
//

import XCModel

extension Xcode {
    func getReleaseSuffix() -> String {
        switch version.release {
        case .beta(let betaNumber):
            return "Beta \(betaNumber)"
        case .dp(let dpNumber):
            return "Developer Preview \(dpNumber)"
        case .gmSeed(let gmSeedNumber):
            return "GM Seed \(gmSeedNumber)"
        case .gm:
            return "GM"
        }
    }
}
