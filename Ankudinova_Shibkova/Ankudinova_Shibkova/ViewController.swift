//
//  ViewController.swift
//  Lab4
//
//  Created by Anastasia on 30.06.2023.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let manager: NetworkManagerProtocol = NetworkManager()
    private var characters: [CharacterResponseModel]? = []
    
//    private var data: [CharacterData] = [
//        CharacterData(id: 1, name: "Рик Санчез", status: CharacterData.Status.alive, species: "Человек", gender: CharacterData.Gender.male, location: "Земля", image: "Рик"),
//
//        CharacterData(id: 2, name: "Морти Смит", status: CharacterData.Status.alive, species: "Человек", gender: CharacterData.Gender.male, location: "Земля", image: "Морти"),
//
//        CharacterData(id: 3, name: "Саммер Смит", status: CharacterData.Status.alive, species: "Человек", gender: CharacterData.Gender.female, location: "Земля", image: "Саммер"),
//
//        CharacterData(id: 4, name: "Мистер Жопосранчик", status: CharacterData.Status.alive, species: "Инопланетянин", gender: CharacterData.Gender.unknown, location: "Неизвестно", image: "Мистер"),
//
//        CharacterData(id: 5, name: "Говорящий кот", status: CharacterData.Status.alive, species: "Животное", gender: CharacterData.Gender.unknown, location: "Космос", image: "Кот")
//    ]
    
    @IBOutlet weak var tableView: UITableView!
        
    func reloadData() {
        tableView.reloadData()
    }
    
    private func loadCharacter() {
        manager.fetchCharacters { result in
            switch result {
            case let .success(response):
                self.characters = response.results
//                self.updateCharacterListState(.data)
                self.reloadData()
            case .failure:
//                self.updateCharacterListState(.error)
                print("Error of getting characters")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadCharacter()
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard
            let modalViewController = storyboard?.instantiateViewController(identifier: "ModalViewController") as? ModalViewController
        else {return}
        guard let characters = characters
        else {return}
        
        modalViewController.delegate = self
        present(modalViewController, animated: true)
        modalViewController.data = characters[indexPath.row]
    }
    
    //MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let characterCell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as? CharacterTableViewCell
        else { return UITableViewCell () }
        
        guard let cellData = self.characters?[indexPath.row]
        else { return UITableViewCell () }
        
        characterCell.setUpData(cellData)
            
        return characterCell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters?.count ?? 0
    }
    
}

extension ViewController: ModalViewControllerDelegate {
    func updateData(with id: Int, newName replace: String, idEdit idEdit: Int) {
        if let index = characters?.firstIndex(where: { $0.id == id}) {
            if idEdit == 1 {
                characters?[index].name = replace
            } else {
                characters?[index].location.name = replace
            }
            
            tableView.reloadData()
        }
    }
}
