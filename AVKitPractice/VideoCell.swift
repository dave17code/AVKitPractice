//
//  VideoCell.swift
//  AVKitPractice
//
//  Created by woonKim on 2024/01/27.
//

import UIKit
import Foundation

class VideoCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailView: UIImageView!
    
    // 썸네일 세팅
    func setThumbnail(imageURL: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: imageURL),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.thumbnailView.contentMode = .scaleToFill
                    self?.thumbnailView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self?.thumbnailView.contentMode = .scaleToFill
                    self?.thumbnailView.tintColor = .lightGray
                    self?.thumbnailView.image = UIImage(systemName: "play.rectangle.fill")
                }
            }
        }
    }
    
    // 타이틀 세팅
    func setTitle(title: String) {
        self.titleLabel.text = title
    }
}
