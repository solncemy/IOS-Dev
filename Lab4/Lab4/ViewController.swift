//
//  ViewController.swift
//  Lab4
//
//  Created by Anastasia on 30.06.2023.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var data: [CharacterData] = [
        CharacterData(id: 1, name: "Рик Санчез", status: CharacterData.Status.alive, species: "Человек", gender: CharacterData.Gender.male, location: "Земля", image: "Рик"),
        
        CharacterData(id: 2, name: "Морти Смит", status: CharacterData.Status.alive, species: "Человек", gender: CharacterData.Gender.male, location: "Земля", image: "Морти"),
        
        CharacterData(id: 3, name: "Саммер Смит", status: CharacterData.Status.alive, species: "Человек", gender: CharacterData.Gender.female, location: "Земля", image: "Саммер"),
        
        CharacterData(id: 4, name: "Мистер Жопосранчик", status: CharacterData.Status.alive, species: "Инопланетянин", gender: CharacterData.Gender.unknown, location: "Неизвестно", image: "Мистер"),
        
        CharacterData(id: 5, name: "Говорящий кот", status: CharacterData.Status.alive, species: "Животное", gender: CharacterData.Gender.unknown, location: "Космос", image: "Кот")
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard
            let modalViewController = storyboard?.instantiateViewController(identifier: "ModalViewController") as? ModalViewController
        else {return}
        
        modalViewController.delegate = self
        
        present(modalViewController, animated: true)
        
        modalViewController.data = data[indexPath.row]
        
    }
    
    //MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let characterCell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as? CharacterTableViewCell
        else { return UITableViewCell () }
        
        let cellData = data[indexPath.row]
        
        characterCell.setUpData(cellData)
            
        return characterCell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
}

extension ViewController: ModalViewControllerDelegate {
    func updateData(with id: Int, newName replace: String, idEdit idEdit: Int) {
        if let index = data.firstIndex(where: { $0.id == id}) {
            if idEdit == 1 {
                data[index].name = replace
            } else {
                data[index].location = replace
            }
            
            tableView.reloadData()
        }
    }
}
