//
//  FirstViewController.swift
//  workWithTableView(SwiftBook)
//
//  Created by Egor Syrtcov on 2/26/20.
//  Copyright © 2020 Egor Syrtcov. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private let cornerRadiusCell: CGFloat = 32.5
    private let searchController = UISearchController(searchResultsController: nil)
    var fetchResultsController: NSFetchedResultsController<Restaurant>!
    
    private var restaurants: [Restaurant] = []
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
        
        setupFetchRequest()
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userDefaults = UserDefaults.standard
        let wasIntroWatched = userDefaults.bool(forKey: "wasIntroWatched")
        
        guard !wasIntroWatched else { return }
        
        let storyBoard = UIStoryboard(name: "Content", bundle: nil)
        if let pageVC = storyBoard.instantiateViewController(withIdentifier: "PageVC") as? PageVC {
            present(pageVC, animated: true, completion: nil)
        }
    }
    
    private func setupFetchRequest() {
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultsController.delegate = self
        
        do {
            try fetchResultsController.performFetch()
            restaurants = fetchResultsController.fetchedObjects!
        } catch let error as NSError {
            print("Error load fetchRequest \(error.localizedDescription)")
        }
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
        
        //Mark: Default photo string to Data
        let imageDefaultString = UIImage(named: "photo")
        let imageToData = imageDefaultString?.pngData()
        
        cell?.thumbnailImageView.image = UIImage(data: restaurant.image ?? imageToData! )
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
            let defaultText = "Я сейчас в " + self.restaurants[indexPath.row].location!
            
            if let image = UIImage(data: self.restaurants[indexPath.row].image! as Data) {
                let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }
        
        let delete = UITableViewRowAction(style: .default, title: "Удалить") { (action, indexPath) in
            self.restaurants.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            let objectToDelete = self.fetchResultsController.object(at: indexPath)
            CoreDataStack.context.delete(objectToDelete)
            CoreDataStack.saveContext()
        }
        share.backgroundColor = UIColor.blueShara()
        return [delete, share]
    }
}

extension FirstViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredRestaurant = restaurants.filter({ (restaurant: Restaurant) -> Bool in
            return restaurant.name!.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}

extension FirstViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let indexPath = newIndexPath else { break }
            tableView.insertRows(at: [indexPath], with: .fade)
        case .delete:
             guard let indexPath = newIndexPath else { break }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .update:
            guard let indexPath = newIndexPath else { break }
            tableView.reloadRows(at: [indexPath], with: .fade)
       default:
            tableView.reloadData()
        }
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
