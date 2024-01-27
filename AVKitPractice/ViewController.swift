//
//  TableViewController.swift
//  AVKitPractice
//
//  Created by woonKim on 2024/01/27.
//

import UIKit
import AVKit

class ViewController: UITableViewController {
    var videoInfoList: [VideoInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Data Fetch
        self.fetchData()
    }
    
    private func fetchData() {
        guard let url = URL(string: "https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json") else {
            return
        }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let videoInfoList = try JSONDecoder().decode([VideoInfo].self, from: data)
                self.videoInfoList = videoInfoList
                self.tableView.reloadData()
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    // AVPlayerController를 띄우는 로직
    private func presentPlayerViewController(videoURL: URL) {
        // AVPlayerController 생성
        let playerController = AVPlayerViewController()
        
        // AVPlayer 생성
        let player = AVPlayer(url: videoURL as URL)
        
        // AVPlayer 할당
        playerController.player = player
        
        // AVPlayerController 노출
        self.present(playerController, animated: true) {
            player.play()
        }
        
    }
}

extension ViewController {
    // count 반환 (데이터)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoInfoList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.videoInfoList[indexPath.row]
        presentPlayerViewController(videoURL: product.videoUrl)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? VideoCell else {
            return UITableViewCell()
        }
        
        let product = self.videoInfoList[indexPath.row]
        
        cell.setThumbnail(imageURL: product.thumbnailUrl)
        cell.setTitle(title: product.title)
        
        return cell
    }
}
