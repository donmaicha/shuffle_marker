//
//  ViewController.swift
//  shuffle_marker
//
//  Created by 福島拓希 on 2019/10/02.
//  Copyright © 2019 福島拓希. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let myView = UIImageView()
    var isShuffle = false

    /// コンストラクタ
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 143/255, green: 180/255, blue: 139/255, alpha: 1.0)

        //set view
        myView.frame = CGRect(x: 0, y: 0, width: 350, height: 600)
        myView.center = view.center
        myView.image = UIImage(named: "card_draw")
        view.addSubview(myView)

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
    @objc func rotateCard() {
        // 二重タップ防止
        self.view.isUserInteractionEnabled = false

        UIView.animate(withDuration: 0.5, animations: {
            // first transform
            self.myView.transform = CGAffineTransform(scaleX: 0.01, y: 1.0)
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 0.5, animations: {
                self.changeImge()
                // second transform
                self.myView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion:{ (finished: Bool) in
                // 二重タップ防止　解除
                self.view.isUserInteractionEnabled = true
            })
        })
        
    }

    /// 画面表示中の画像を差し替える
    func changeImge() {
        if isShuffle {
            self.myView.image = UIImage(named: "card_draw")
            self.view.backgroundColor = UIColor(red: 143/255, green: 180/255, blue: 139/255, alpha: 1.0)
            isShuffle = false
        } else {
            self.myView.image = UIImage(named: "card_shuffle")
            self.view.backgroundColor = UIColor(red: 175/255, green: 117/255, blue: 96/255, alpha: 1.0)
            isShuffle = true
        }
        
    }
}

