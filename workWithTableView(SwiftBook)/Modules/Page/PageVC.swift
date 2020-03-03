//
//  PageVC.swift
//  workWithTableView(SwiftBook)
//
//  Created by Egor Syrtcov on 3/2/20.
//  Copyright © 2020 Egor Syrtcov. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController {
    
    var headerArray = ["Записывайте", "Находите"]
    var subHeaderArray = ["Создавайте свой список любимых ресторанов", "Найдите и отметьте на карте ваши любимые рестораны"]
    var imageArray = ["food", "iphoneMap"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstVC = displayViewController(atIndex: 0) {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func nextVC(atIndex index: Int) {
        if let contentVC = displayViewController(atIndex: index + 1) {
            setViewControllers([contentVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func displayViewController(atIndex index: Int) -> Content? {
        guard index >= 0 else { return nil }
        guard index < headerArray.count else { return nil}
        let storyBoard = UIStoryboard(name: "Content", bundle: nil)
        guard let contentVC = storyBoard.instantiateViewController(withIdentifier: "Content") as? Content else { return nil }
        contentVC.imageFile = imageArray[index]
        contentVC.header = headerArray[index]
        contentVC.subheader = subHeaderArray[index]
        contentVC.index = index
        
        return contentVC
    }
}

extension PageVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! Content).index
        index -= 1
        return displayViewController(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! Content).index
        index += 1
        return displayViewController(atIndex: index)
    }
}
