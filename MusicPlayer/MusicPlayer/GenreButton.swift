//
//  GenreButton.swift
//  MusicPlayer
//
//  Created by Cindy Young on 2019-06-11.
//  Copyright © 2019 James Young. All rights reserved.
//

import UIKit
import MediaPlayer

class GenreButton: UIViewController {

    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBOutlet weak var songLabel: UILabel!
    
    @IBAction func genreButtonTapped(_ sender: UIButton) {
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                self.playGenre(genre: sender.currentTitle!)
            }
        }
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        musicPlayer.stop()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        musicPlayer.skipToNextItem()
    }
    
    func playGenre(genre: String)
    {
        musicPlayer.stop()
        
        let query = MPMediaQuery()
        let predicate = MPMediaPropertyPredicate(value: genre, forProperty: MPMediaItemPropertyGenre)
        
        query.addFilterPredicate(predicate)
        
        musicPlayer.setQueue(with: query)
        musicPlayer.shuffleMode = .songs
        let song = musicPlayer.nowPlayingItem
        
        updateLabel(nowPlaying : song!)
        musicPlayer.play()
        
    }
    func updateLabel(nowPlaying song : MPMediaItem)
    {
        songLabel.text = song.title! + " - " + song.artist!
    }
    
}
