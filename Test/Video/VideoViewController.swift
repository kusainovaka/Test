//
//  VideoViewController.swift
//  Test
//
//  Created by Kamila Kusainova on 15.11.2018.
//  Copyright © 2018 Kamila Kusainova. All rights reserved.
//

import UIKit
import AVKit

class VideoViewController: UIViewController {
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 230, height: 40)
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    var videoName = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImage)
        backgroundImage.image = #imageLiteral(resourceName: "Pug")
        backgroundImage.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "VideoCell")
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(view.bounds.maxY / 2)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getVideo()
    }
    
    func getVideo() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            fileURLs.forEach { (name) in
                let nameVideo = name.absoluteString
                videoName.append(nameVideo)
            }
        } catch {
            debugPrint("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
    }
    
    func removeString(_ sentence: String) -> String {
        var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString
        documentsURL.insert(string: "/private", int: 7)
        var allString = sentence
        if let range = allString.range(of: documentsURL) {
            allString.removeSubrange(range)
        }
        return allString.components(separatedBy: ".")[0]
    }
}

extension VideoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
        cell.videoName.text = removeString(videoName[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoUrl = URL(string: videoName[indexPath.row])
        let player = AVPlayer(url: videoUrl!)
        let playerViewController = AVPlayerViewController()
        
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}

extension String {
    mutating func insert(string: String,int: Int) {
        self.insert(contentsOf: string, at:string.index(string.startIndex, offsetBy: int) )
    }
}
