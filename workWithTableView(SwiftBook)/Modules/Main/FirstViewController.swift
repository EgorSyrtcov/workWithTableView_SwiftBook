//
//  FirstViewController.swift
//  workWithTableView(SwiftBook)
//
//  Created by Egor Syrtcov on 2/26/20.
//  Copyright © 2020 Egor Syrtcov. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private let cornerRadiusCell: CGFloat = 32.5
    private let searchController = UISearchController(searchResultsController: nil)
    
    
    private var restaurants: [Restaurant] = [
        Restaurant(name: "Ogonek Grill", type: "кафе", location: "Республика Беларусь, город Гомель, улица Катунина 14", image: "ogonek.jpg", isVisited: false, rateSmile: nil),
        Restaurant(name: "Елу", type: "ресторан", location: "Республика Беларусь, город Гомель, улица проспект Победы 4", image: "elu.jpg", isVisited: false, rateSmile: nil),
        Restaurant(name: "Bonsai", type: "ресторан", location: "Республика Беларусь, город Гомель, улица Пушкина 14", image: "bonsai.jpg", isVisited: false, rateSmile: nil),
        Restaurant(name: "Дастархан", type: "Пиццерия", location: "Республика Беларусь, город Гомель, улица Крестьянская 14", image: "dastarhan.jpg", isVisited: false, rateSmile: nil),
        Restaurant(name: "Индикитай", type: "ресторан", location: "Республика Беларусь, город Гомель, проспект Ленина 6", image: "indokitay.jpg", isVisited: false, rateSmile: nil),
         Restaurant(name: "Х.О", type: "ресторан", location: "Республика Беларусь, город Гомель, проспект Ленина 10", image: "x.o.jpg", isVisited: false, rateSmile: nil),
         Restaurant(name: "Балкан Гриль", type: "ресторан", location: "Республика Беларусь, город Гомель, улица Советская 32", image: "balkan.jpg", isVisited: false, rateSmile: nil),
         Restaurant(name: "Respublica", type: "ресторан", location: "Республика Беларусь, город Гомель, улица Привокзальная 3а", image: "respublika.jpg", isVisited: false, rateSmile: nil),
         Restaurant(name: "Speak Easy", type: "ресторан", location: "Республика Беларусь, город Гомель, улица Билецкий спуск 1", image: "speakeasy.jpg", isVisited: false, rateSmile: nil),
         Restaurant(name: "Morris Pub", type: "ресторан", location: "Республика Беларусь, город Гомель, улица Советская 12", image: "morris.jpg", isVisited: false, rateSmile: nil),
         Restaurant(name: "Вкусные истории", type: "ресторан", location: "Республика Беларусь, город Гомель, улица Пушкина 14", image: "istorii.jpg", isVisited: false, rateSmile: nil),
         Restaurant(name: "Классик", type: "ресторан", location: "Республика Беларусь, город Гомель, проспект Ленина 20", image: "klassik.jpg", isVisited: false, rateSmile: nil),
         Restaurant(name: "Love&Life", type: "ресторан", location: "Республика Беларусь, город Гомель, проспект Ленина 33", image: "love.jpg", isVisited: false, rateSmile: nil),
         Restaurant(name: "Шик", type: "ресторан", location: "Республика Беларусь, город Гомель, улица Ланге 5", image: "shok.jpg", isVisited: false, rateSmile: nil),
         Restaurant(name: "Бочка", type: "ресторан", location: "Республика Беларусь, город Гомель, улица Пушкина 7", image: "bochka.jpg", isVisited: false, rateSmile: nil),
    ]
    
    private var filteredRestaurant = [Restaurant]()

    private var isFiltered: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return searchController.isActive && !text.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
        
        setupSearchController()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    @IBAction func addBarButtonItemAction(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "AddRestaurant", bundle: nil)
        let addRestaurantVC = storyBoard.instantiateViewController(withIdentifier: "AddRestaurant") as! AddRestaurant
        
        navigationController?.pushViewController(addRestaurantVC, animated: true)
    }
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isFiltered ? filteredRestaurant.count : restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? EateriesTableViewCell
        
        let restaurant: Restaurant
        restaurant = isFiltered ? filteredRestaurant[indexPath.row] : restaurants[indexPath.row]
        
        cell?.nameLabel.text = restaurant.name
        cell?.locationLabel.text = restaurant.location
        cell?.typeLabel.text = restaurant.type
        cell?.thumbnailImageView?.image = UIImage(named: restaurant.image)
        cell?.thumbnailImageView.layer.cornerRadius = cornerRadiusCell
        
        cell?.accessoryType = restaurant.isVisited ? .checkmark : .none
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "DetailViewController", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let restaurant: Restaurant
        restaurant = isFiltered ? filteredRestaurant[indexPath.row] : restaurants[indexPath.row]
    
        detailVC.restaurant = restaurant
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

extension FirstViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredRestaurant = restaurants.filter({ (restaurant: Restaurant) -> Bool in
            return restaurant.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}
