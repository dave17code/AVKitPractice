//
//  VideoInfo.swift
//  AVKitPractice
//
//  Created by woonKim on 2024/01/27.
//

import Foundation

struct VideoInfo: Decodable {
    let id: String
    let title: String
    let thumbnailUrl: URL
    let videoUrl: URL
}
