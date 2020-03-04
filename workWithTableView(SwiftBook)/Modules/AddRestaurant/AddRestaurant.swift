//
//  AddRestaurant.swift
//  workWithTableView(SwiftBook)
//
//  Created by Egor Syrtcov on 2/27/20.
//  Copyright © 2020 Egor Syrtcov. All rights reserved.
//

import UIKit
import CoreData

class AddRestaurant: UITableViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    private var isVisited = false
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let alertController = UIAlertController(title: "Источник фотографии", message: nil, preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] (action) in
                self?.chooseImagePickerAction(source: .camera)
            }
            let fotoLibAction = UIAlertAction(title: "Фото", style: .default) { [weak self] (action) in
                self?.chooseImagePickerAction(source: .photoLibrary)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cameraAction)
            alertController.addAction(fotoLibAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func chooseImagePickerAction(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelBarItemButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBarButtonItem(_ sender: UIBarButtonItem) {
        if nameTextField.text == "" || adressTextField.text == "" || typeTextField.text == "" {
            let alertController = UIAlertController(title: "", message: "Не все поля заполнены", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(ok)
            present(alertController, animated: true, completion: nil)
        } else {
            let restaurant = Restaurant(context: CoreDataStack.context)
            restaurant.name = nameTextField.text
            restaurant.location = adressTextField.text
            restaurant.type = typeTextField.text
            restaurant.isVisited = isVisited
            
            if let image = imageView.image {
                restaurant.image = image.pngData()
            }
            
            CoreDataStack.saveContext()
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func togglesVisitedPressed(_ sender: UIButton) {
        if sender == yesButton {
            sender.backgroundColor = UIColor.greenButton()
            noButton.backgroundColor = UIColor.greenButton()
            isVisited = true
        } else {
            sender.backgroundColor = UIColor.redButton()
            yesButton.backgroundColor = UIColor.greenButton()
            isVisited = false
        }
    }
}

extension AddRestaurant: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
}
