//
//  ViewController.swift
//  workWithTableView(SwiftBook)
//
//  Created by Egor Syrtcov on 2/26/20.
//  Copyright © 2020 Egor Syrtcov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let restaurantNames = ["Ogonek Grill", "Елу", "Bonsai", "Дастархан", "Индикитай", "Х.О", "Балкан Гриль", "Respublica", "Speak Easy", "Morris Pub", "Вкусные истории", "Классик", "Love&Life", "Шик", "Бочка"]
    
    let restaurantImages = ["ogonek.jpg", "elu.jpg", "bonsai.jpg", "dastarhan.jpg" ,"indokitay.jpg" ,"x.o.jpg", "balkan.jpg", "respublika.jpg", "speakeasy.jpg", "morris.jpg","istorii.jpg", "klassik.jpg", "love.jpg", "shok.jpg", "bochka.jpg"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let restauren = restaurantNames[indexPath.row]
        let imageReatauren = restaurantImages[indexPath.row]
        cell?.textLabel?.text = restauren
        cell?.imageView?.image = UIImage(named: imageReatauren)
        return cell!
    }
    
}
