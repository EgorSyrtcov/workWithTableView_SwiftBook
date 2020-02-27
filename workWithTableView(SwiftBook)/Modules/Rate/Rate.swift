//
//  Rate.swift
//  workWithTableView(SwiftBook)
//
//  Created by Egor Syrtcov on 2/27/20.
//  Copyright © 2020 Egor Syrtcov. All rights reserved.
//

import UIKit

class Rate: UIViewController {
    
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var brillingButton: UIButton!

    var completion: ((_ imageName: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBlurEffect()
        setupStartButtonAnimated()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        endButtonAnimated()
    }
    
    private func endButtonAnimated() {
        let buttonArray = [badButton, goodButton, brillingButton]
        for (index, button) in buttonArray.enumerated() {
            let delay = Double(index) * 0.4
            UIView.animate(withDuration: 0.8, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                button?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    
    private func setupStartButtonAnimated() {
        badButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        goodButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        brillingButton.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    
    private func setupBlurEffect() {
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            self.view.insertSubview(blurEffectView, at: 1)
    }
    
    @IBAction func backButtonToVC(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rateRestourant(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            completion?("bad")
        case 1:
            completion?("good")
        case 2:
            completion?("brilliant")
        default:
            break
        }
        dismiss(animated: true, completion: nil)
    }
    
}
