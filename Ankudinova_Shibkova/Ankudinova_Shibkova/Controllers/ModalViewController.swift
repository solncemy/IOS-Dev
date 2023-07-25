//
//  ModalViewController.swift
//  Lab4
//
//  Created by Anastasia on 01.07.2023.
//

import UIKit

protocol ModalViewControllerDelegate: AnyObject {
    func updateData(with id: Int, newName: String, idEdit: Int)
    func deleteCharacterData(with id: Int32)
}

final class ModalViewController: UIViewController {
    
    var data: Character? {
        didSet {
            guard let data else {return}
            setUpData(data)
        }
    }
    
    weak var delegate: ModalViewControllerDelegate?
    
    @IBOutlet weak var nameEditButton: UIButton!
    @IBOutlet weak var statusEditButton: UIButton!
    @IBOutlet weak var speciesEditButton: UIButton!
    @IBOutlet weak var genderEditButton: UIButton!
    @IBOutlet weak var locationEditButton: UIButton!
    
    @IBOutlet weak var imageViewNew: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    private func setUpData(_ data: Character) {
        nameLabel.text = data.name
        statusLabel.text = data.status
        speciesLabel.text = data.species
        genderLabel.text = data.gender
        locationLabel.text = data.location
        
        guard let image = data.image
        else {return}
        imageViewNew.download(from: image)
    }
    
    @IBAction func deleteBottonDipTap(_ sender: Any) {
    
        guard let data else {return}
        delegate?.deleteCharacterData(with: data.id)
    }
    
    @IBAction func nameEditButtonDidTap() {
            let idEdit = 1
            let alertController = UIAlertController(title: "Введите новое значение", message: nil, preferredStyle: .alert)
            alertController.addTextField { (textField) in
                textField.placeholder = "Имя"
            }
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            let changeAction = UIAlertAction(title: "Сохранить", style: .default) { [weak self] (_) in
                guard let self = self,
                                  let data = data,
                                  let newText = alertController.textFields?.first?.text
                            else { return }
                
                self.nameLabel.text = newText
                self.delegate?.updateData(with: Int(data.id), newName: newText, idEdit: idEdit)
            }
            alertController.addAction(cancelAction)
            alertController.addAction(changeAction)
            
            present(alertController, animated: true, completion: nil)
            
            nameLabel.isUserInteractionEnabled = true
        }
    
    @IBAction func locationEditButtonDidTap() {
            let idEdit = 2
            let alertController = UIAlertController(title: "Введите новое значение", message: nil, preferredStyle: .alert)
            alertController.addTextField { (textField) in
                textField.placeholder = "Место"
            }
            var tempText: String = ""
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            let changeAction = UIAlertAction(title: "Сохранить", style: .default) { [weak self] (_) in
                guard let self = self,
                                  let data = data,
                                  let newText = alertController.textFields?.first?.text
                            else { return }
                
                self.locationLabel.text = newText
        
                self.delegate?.updateData(with: Int(data.id), newName: newText, idEdit: idEdit)
            }
        
            alertController.addAction(cancelAction)
            alertController.addAction(changeAction)
            
            present(alertController, animated: true, completion: nil)
            
            locationLabel.isUserInteractionEnabled = true
        }
}


