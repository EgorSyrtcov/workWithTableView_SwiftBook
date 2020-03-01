//
//  DetailViewController.swift
//  workWithTableView(SwiftBook)
//
//  Created by Egor Syrtcov on 2/26/20.
//  Copyright © 2020 Egor Syrtcov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    
    var restaurant: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: restaurant?.image ?? "Нет изображения")
        setupTableView()
        setupButton()
    }
    
    @IBAction func rateButtonAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Rate", bundle: nil)
        let rateVC = storyBoard.instantiateViewController(withIdentifier: "Rate") as! Rate
        rateVC.completion = { [weak self] (imageName) in
            self?.rateButton.setImage(UIImage(named: imageName), for: .normal)
        }
        navigationController?.present(rateVC, animated: true, completion: nil)
    }
    
    @IBAction func mapsButtonAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Map", bundle: nil)
        let mapVC = storyBoard.instantiateViewController(withIdentifier: "Map") as! Map
        mapVC.restaurant = self.restaurant 
        
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        navigationItem.title = restaurant?.name
        tableView.estimatedRowHeight = 38
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupButton() {
        let buttons = [rateButton, mapButton]
        
        buttons.forEach({$0?.layer.cornerRadius = 5; $0?.layer.borderWidth = 1; $0?.layer.borderColor = UIColor.white.cgColor })
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EateryDetailCell", for: indexPath) as? EateryDetailCell else {
            fatalError()
        }
        
        switch indexPath.row {
        case 0:
            cell.keyLabel.text = "Название"
            cell.valueLabel.text = restaurant?.name
        case 1:
            cell.keyLabel.text = "Тип"
            cell.valueLabel.text = restaurant?.type
        case 2:
            cell.keyLabel.text = "Адрес"
            cell.valueLabel.text = restaurant?.location
        case 3:
            cell.keyLabel.text = "Я там был?"
            cell.valueLabel.text = restaurant!.isVisited ? "Да" : "Нет"
        default:
            break
        }
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
