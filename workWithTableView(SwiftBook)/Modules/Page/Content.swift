//
//  Content.swift
//  workWithTableView(SwiftBook)
//
//  Created by Egor Syrtcov on 3/2/20.
//  Copyright © 2020 Egor Syrtcov. All rights reserved.
//

import UIKit

class Content: UIViewController {
    
    @IBOutlet weak var hearedLabel: UILabel!
    @IBOutlet weak var subHeader: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pageButton: UIButton!
    
    var header = ""
    var subheader = ""
    var imageFile = ""
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContent()
        setupButtonPressed()
    }
    
    private func setupContent() {
        hearedLabel.text = header
        subHeader.text = subheader
        imageView.image = UIImage(named: imageFile)
        pageControl.numberOfPages = 2
        pageControl.currentPage = index
        
        switch index {
        case 0: pageButton.setTitle("Дальше", for: .normal)
        case 1: pageButton.setTitle("Открыть", for: .normal)
        default:
            break
        }
    }
    
    private func setupButtonPressed() {
        pageButton.layer.cornerRadius = 15
        pageButton.clipsToBounds = true
        pageButton.layer.borderWidth = 2
    }
    
    @IBAction func pageButtonPresed(_ sender: UIButton) {
        switch index {
        case 0:
            let pageVC = parent as! PageVC
            pageVC.nextVC(atIndex: index)
        case 1:
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "wasIntroWatched")
            userDefaults.synchronize()
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
}
