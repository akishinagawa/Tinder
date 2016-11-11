//
//  CardsViewController.swift
//  Tinder
//
//  Created by Akifumi Shinagawa on 11/10/16.
//  Copyright © 2016 CodePath/akifumi shinagawa. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    var draggableView: DraggableImageView!
    
    var originalImageCenter:CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        imageView.image = UIImage(named: "codepath_logo")
//        imageView.caption = "CodePath starts new class for designers"
    
        let views = Bundle.main.loadNibNamed("DraggableImageView", owner: self, options: nil) as? [UIView]
        
        draggableView = views![0] as! DraggableImageView

        view.addSubview(draggableView)
        draggableView.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        
        
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.profilePanGestureRecognizer(_:)))
        
        draggableView.isUserInteractionEnabled = true
        draggableView.addGestureRecognizer(gestureRecognizer)
        
        
        let tapGestureR = UITapGestureRecognizer(target: draggableView, action: #selector(self.profileTap(_:)))
        draggableView.addGestureRecognizer(tapGestureR)
    }

    func profileTap(_ sender: UITapGestureRecognizer) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        sb.instantiateViewController(withIdentifier: "ProfileViewController")
        

        
        self.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func profilePanGestureRecognizer(_ sender: UIPanGestureRecognizer) {
        
 
        let translation  = sender.translation(in: view)
        
        var isStartFromBottom = false
     
        
        
        switch sender.state {
        case .began:
            originalImageCenter = draggableView.center
            
            if translation.y >= 0.5 {
                isStartFromBottom = false
            }
            else {
                isStartFromBottom = true
            }
            
            
        case .changed:
            
            if isStartFromBottom == true {
                draggableView.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 8) * (translation.x * 0.01) * -1)
                draggableView.center.x = originalImageCenter.x + translation.x
                draggableView.center.y = originalImageCenter.y + translation.y
            }
            else {
                draggableView.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 8) * (translation.x * 0.01))
                draggableView.center.x = originalImageCenter.x + translation.x
                draggableView.center.y = originalImageCenter.y + translation.y
            }
            
            if translation.x > 50 {
                draggableView.center.x = 1000
            } else if translation.x < -50 {
                draggableView.center.x = -1000
                
            }
            
            
            
        case .ended:
            
//            draggableView.center.x = translation.x
            print()
            
        default:
            return
            
            
        }
        
        
        
        
        
        
    }

}





