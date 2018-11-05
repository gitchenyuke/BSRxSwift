//
//  MeViewController.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/15.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import Gifu

class MeViewController: BSBaseViewController {
    
    var imageView: GIFImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "我"
        
        imageView = GIFImageView.init(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        imageView.backgroundColor = UIColor.red
        view.addSubview(imageView)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if imageView.isAnimatingGIF {
            imageView.stopAnimatingGIF()
        }else{
            imageView.startAnimatingGIF()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        imageView.prepareForReuse()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.animate()
    }
    
    func animate() {
        
        imageView.animate(withGIFURL: URL.init(string: "http://wimg.spriteapp.cn/ugc/2018/10/30/5bd7d60320dbc.gif")!) {
            print("It is animating!")
        }
    }
    
}
