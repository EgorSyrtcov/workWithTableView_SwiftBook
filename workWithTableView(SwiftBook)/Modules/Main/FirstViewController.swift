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
        Restaurant(name: "Ogonek Grill", type: "кафе", location: "Республика Беларусь, город Гомель, улица Катунина 14", image: "ogonek.jpg", isVisited: false),
        Restaurant(name: "Елу", type: "ресторан", location: "Республика Беларусь, город Гомель, улица проспект Победы 4", image: "elu.jpg", isVisited: false),
        Restaurant(name: "Bonsai", type: "ресторан", location: "Республика Беларусь, город Гомель, улица Пушкина 14", image: "bonsai.jpg", isVisited: false),
        Restaurant(name: "Дастархан", type: "Пиццерия", location: "Республика Беларусь, город Гомель, улица Крестьянская 14", image: "dastarhan.jpg", isVisited: false),
        Restaurant(name: "Индикитай", type: "ресторан", location: "Республика Беларусь, город Гомель, проспект Ленина 6", image: "indokitay.jpg", isVisited: false),
         Restaurant(name: "Х.О", type: "ресторан", location: "Республика Беларусь, город Гомель, проспект Ленина 10", image: "x.o.jpg", isVisited: false),
         Restaurant(name: "Балкан Гриль", type: "ресторан", location: "Республика Беларусь, город Гомель, улица Советская 32", image: "balkan.jpg", isVisited: false),
         Restaurant(name: "Respublica", type: "ресторан", location: "Республика Беларусь, город Гомель, улица Привокзальная 3а", image: "respublika.jpg", isVisited: false),
         Restaurant(name: "Speak Easy", type: "ресторан", location: "Республика Беларусь, город Гомель, улица Билецкий спуск 1", image: "speakeasy.jpg", isVisited: false),
         Restaurant(name: "Morris Pub", type: "ресторан", location: "Республика Беларусь, город Гомель, улица Советская 12", image: "morris.jpg", isVisited: false),
         Restaurant(name: "Вкусные истории", type: "ресторан", location: "Республика Беларусь, город Гомель, улица Пушкина 14", image: "istorii.jpg", isVisited: false),
         Restaurant(name: "Классик", type: "ресторан", location: "Республика Беларусь, город Гомель, проспект Ленина 20", image: "klassik.jpg", isVisited: false),
         Restaurant(name: "Love&Life", type: "ресторан", location: "Республика Беларусь, город Гомель, проспект Ленина 33", image: "love.jpg", isVisited: false),
         Restaurant(name: "Шик", type: "ресторан", location: "Республика Беларусь, город Гомель, улица Ланге 5", image: "shok.jpg", isVisited: false),
         Restaurant(name: "Бочка", type: "ресторан", location: "Республика Беларусь, город Гомель, улица Пушкина 7", image: "bochka.jpg", isVisited: false),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func addBarButtonItemAction(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "AddRestaurant", bundle: nil)
        let addRestaurantVC = storyBoard.instantiateViewController(withIdentifier: "AddRestaurant") as! AddRestaurant
        
        navigationController?.pushViewController(addRestaurantVC, animated: true)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
