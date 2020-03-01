//
//  ViewController.swift
//  shuffle_marker
//
//  Created by donmaicha on 2019/10/02.
//  Copyright © 2019 donmaicha. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var myView: UIImageView!
    var audioPlayer : AVAudioPlayer!
    
    // 背景色(緑)
    let bgGreen = UIColor(red: 143/255, green: 180/255, blue: 139/255, alpha: 1.0)
    // 背景色(赤)
    let bgRed = UIColor(red: 175/255, green: 117/255, blue: 96/255, alpha: 1.0)
    // shuffleモードかどうか
    var isShuffle = false
    
    // 何秒shuffleモードを表示するか
    var shuffleModeTime: Double = 10.0
    
    // shuffleモードタイマー
    var shuffleModeTimer: Timer? = nil
    
    /// コンストラクタ
    override func viewDidLoad() {
        super.viewDidLoad()
        // UIGestureのインスタンス
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        
        // UIGestureのデリゲート
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        
        // viewに追加
        self.view.addGestureRecognizer(tapGesture)
    }
    
    /// 画面をタップした時の処理
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        // タップ直後に中身を実行
        if sender.state == .ended {
            rotateCard()
        }
        
    }
    
    /// カードをくるっとひっくり返すアニメーション
    func rotateCard() {
        // 二重タップ防止
        self.view.isUserInteractionEnabled = false
        
        playMp3(target: "card-turn-over1")

        UIView.animate(withDuration: 0.5, animations: {
            // first transform
            self.myView.transform = CGAffineTransform(scaleX: 0.01, y: 1.0)
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 0.5, animations: {
                self.changeImge()
                // second transform
                self.myView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion:{ (finished: Bool) in
                // 二重タップ防止 解除
                self.view.isUserInteractionEnabled = true
            })
        })
        
    }

    /// 画面表示中の画像を差し替える
    func changeImge() {
        if isShuffle {
            self.myView.image = UIImage(named: "card_draw")
            self.view.backgroundColor = bgGreen
            isShuffle = false
            // タイマーを停止する
            shuffleModeTimer?.invalidate()
        } else {
            self.myView.image = UIImage(named: "card_shuffle")
            self.view.backgroundColor = bgRed
            isShuffle = true
            shuffleModeTimer = Timer.scheduledTimer(timeInterval: shuffleModeTime, target: self, selector: #selector(self.ShowPopup), userInfo: nil, repeats: false)
        }
        
    }
    
    /// ダイアログ表示
    @objc func ShowPopup() {
        alert(title: "確認", message: "シャッフルしましたか?")
    }
    
    /// YesNoダイアログ作成
    /// - parameter title: タイトル
    /// - parameter message: 内容
    var alertController: UIAlertController!
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "YES",
                                       style: .default,
                                       handler: {
                                           // ボタンが押された時の処理を書く（クロージャ実装）
                                           (action: UIAlertAction!) -> Void in
                                        self.rotateCard()
                                       }))
        alertController.addAction(UIAlertAction(title: "NO",
                                       style: .default,
                                       handler: nil))
        present(alertController, animated: true)
    }
    
    /// MP３ファイルの再生処理
    /// - parameter target: 再生したいファイル名
    func playMp3(target:String) {
        // mp3を再生する
        if let url = Bundle.main.url(forResource: target, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer.play()
            } catch {
                audioPlayer = nil
            }
        } else {
            fatalError("Url is nil")
        }
        
    }
}

