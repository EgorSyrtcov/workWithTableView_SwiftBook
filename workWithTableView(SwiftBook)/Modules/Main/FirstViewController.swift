//
//  FirstViewController.swift
//  workWithTableView(SwiftBook)
//
//  Created by Egor Syrtcov on 2/26/20.
//  Copyright © 2020 Egor Syrtcov. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let cornerRadiusCell: CGFloat = 32.5
    
    var restaurants: [Restaurant] = [
        Restaurant(name: "Ogonek Grill", type: "ресторан", location: "Республика Беларусь, город Гомель, улица Советская 137", image: "ogonek.jpg", isVisited: false),
        Restaurant(name: "Елу", type: "ресторан", location: "Гомель", image: "elu.jpg", isVisited: false),
        Restaurant(name: "Bonsai", type: "ресторан", location: "Республика Беларусь, город Гомель, проспект Ленина 217", image: "bonsai.jpg", isVisited: false),
        Restaurant(name: "Дастархан", type: "Пиццерия", location: "Гомель", image: "dastarhan.jpg", isVisited: false),
        Restaurant(name: "Индикитай", type: "ресторан", location: "Гомель", image: "indokitay.jpg", isVisited: false),
         Restaurant(name: "Х.О", type: "ресторан", location: "Гомель", image: "x.o.jpg", isVisited: false),
         Restaurant(name: "Балкан Гриль", type: "ресторан", location: "Республика Беларусь, город Гомель, улица Интенданская 37", image: "balkan.jpg", isVisited: false),
         Restaurant(name: "Respublica", type: "ресторан", location: "Гомель", image: "respublika.jpg", isVisited: false),
         Restaurant(name: "Speak Easy", type: "ресторан", location: "Гомель", image: "speakeasy.jpg", isVisited: false),
         Restaurant(name: "Morris Pub", type: "ресторан", location: "Гомель", image: "morris.jpg", isVisited: false),
         Restaurant(name: "Вкусные истории", type: "ресторан", location: "Республика Беларусь, город Гомель, Речицкий Проспект 417", image: "istorii.jpg", isVisited: false),
         Restaurant(name: "Классик", type: "ресторан", location: "Гомель", image: "klassik.jpg", isVisited: false),
         Restaurant(name: "Love&Life", type: "ресторан", location: "Гомель", image: "love.jpg", isVisited: false),
         Restaurant(name: "Шик", type: "ресторан", location: "Гомель", image: "shok.jpg", isVisited: false),
         Restaurant(name: "Бочка", type: "ресторан", location: "Республика Беларусь, город Гомель, улица Бочкина 378", image: "bochka.jpg", isVisited: false),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? EateriesTableViewCell
        let namesRestaurant = restaurants[indexPath.row]
        
        cell?.nameLabel.text = namesRestaurant.name
        cell?.locationLabel.text = namesRestaurant.location
        cell?.typeLabel.text = namesRestaurant.type
        cell?.thumbnailImageView?.image = UIImage(named: namesRestaurant.image)
        cell?.thumbnailImageView.layer.cornerRadius = cornerRadiusCell
        
        cell?.accessoryType = namesRestaurant.isVisited ? .checkmark : .none
        
        return cell!
    }
    
//    private func showAlert(indexPath: IndexPath, _ tableView: UITableView) {
//        let ac = UIAlertController(title: nil, message: "Выберите действие", preferredStyle: .actionSheet)
//        let call = UIAlertAction(title: "Позвонить: +375(29)119591\(indexPath.row)", style: .default) { (action: UIAlertAction) -> Void in
//            let alertCont = UIAlertController(title: nil, message: "Вызов не может быть совершен", preferredStyle: .alert)
//            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
//            alertCont.addAction(ok)
//            self.present(alertCont, animated: true, completion: nil)
//        }
//
//        let isVisitedTitle = self.restaurantIsVisited[indexPath.row] ? "Я не был здесь" : "Я был здесь"
//
//        let isVisited = UIAlertAction(title: isVisitedTitle, style: .default) { (action) in
//            let cell = tableView.cellForRow(at: indexPath)
//
//            self.restaurantIsVisited[indexPath.row] = !self.restaurantIsVisited[indexPath.row]
//            cell?.accessoryType = self.restaurantIsVisited[indexPath.row] ? .checkmark : .none
//        }
//
//        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
//        ac.addAction(cancel)
//        ac.addAction(call)
//        ac.addAction(isVisited)
//        present(ac, animated: true, completion: nil)
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        showAlert(indexPath: indexPath, tableView)
        let storyBoard = UIStoryboard(name: "DetailViewController", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.restaurant = restaurants[indexPath.row]
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let share = UITableViewRowAction(style: .normal, title: "Поделиться") { (action, indexPath) in
            let defaultText = "Я сейчас в " + self.restaurants[indexPath.row].location
            
            if let image = UIImage(named: self.restaurants[indexPath.row].image) {
                let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }
        
        let delete = UITableViewRowAction(style: .default, title: "Удалить") { (action, indexPath) in
            self.restaurants.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        share.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        return [delete, share]
    }
    
}
