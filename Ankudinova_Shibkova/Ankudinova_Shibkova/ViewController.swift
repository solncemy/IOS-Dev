//
//  ViewController.swift
//  Lab4
//
//  Created by Anastasia on 30.06.2023.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    private let manager: NetworkManagerProtocol = NetworkManager()
    private var characters: [CharacterResponseModel]? = []
    private var showedAlert: Bool = false
        
    @IBOutlet weak var tableView: UITableView!
        
    func reloadData() {
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    lazy var frc: NSFetchedResultsController<Character> = {
        let request = Character.fetchRequest()
        request.sortDescriptors = [
            .init(key: "id", ascending: true),
        ]
        
        let frc = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: PersistentContainer.shared.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        frc.delegate = self
        
        return frc
    }()
    
    private func createNewCharacter(character: CharacterResponseModel) {
        let newCharacter = Character(context: PersistentContainer.shared.viewContext)
        setCharacterFields(ch1: newCharacter, ch2: character)
    }
    
    private func setCharacterFields(ch1: Character, ch2: CharacterResponseModel) {
        ch1.id = Int32(ch2.id)
        ch1.gender = ch2.gender.rawValue
        ch1.image = ch2.image
        ch1.location = ch2.location.name
        ch1.name = ch2.name
        ch1.species = ch2.species.rawValue
        ch1.status = ch2.status.rawValue
    }
    
    private func loadCharacter() {
        manager.fetchCharacters { result in
            switch result {
            case let .success(response):
                let request = Character.fetchRequest()
                do {
                    let current = try PersistentContainer.shared.viewContext.fetch(request)
                    for character in response.results {
                        if let el = current.first(where: {Int($0.id) == character.id}) {
                            self.setCharacterFields(ch1: el, ch2: character)
                        } else {
                            self.createNewCharacter(character: character)
                        }
                    }
                    PersistentContainer.shared.saveContext()
                } catch {
                    print(error)
                    return
                }
            case .failure:
                print("Error of getting characters")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore && !self.showedAlert {
            let currentCounter = UserDefaults.standard.integer(forKey: "launchCounter")
            if (currentCounter != 0 && (currentCounter) % 3 == 0) {
                let dialogMessage = UIAlertController(title: "Hello!", message: "You`ve launched this app \(currentCounter) times!", preferredStyle: .alert)
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                     print("Ok button tapped")
                  })
                 dialogMessage.addAction(ok)
                self.present(dialogMessage, animated: true, completion: nil)
                self.showedAlert = true
            }
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        do {
            try frc.performFetch()
        } catch {
            print(error)
        }
        
        loadCharacter()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        reloadData()
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard
            let modalViewController = storyboard?.instantiateViewController(identifier: "ModalViewController") as? ModalViewController
        else {return}
        
        modalViewController.delegate = self
        present(modalViewController, animated: true)
        modalViewController.data = frc.object(at: indexPath)
    }
    
    //MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let characterCell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as? CharacterTableViewCell
        else { return UITableViewCell () }
        
        let cellData = frc.object(at: indexPath)
        characterCell.setUpData(cellData)
            
        return characterCell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = frc.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
}

extension ViewController: ModalViewControllerDelegate {
    
    func updateData(with id: Int, newName replace: String, idEdit idEdit: Int) {
        do {
            let request = Character.fetchRequest()
            let current = try PersistentContainer.shared.viewContext.fetch(request)
            if let el = current.first(where: {Int($0.id) == id}) {
                if idEdit == 1 {
                    el.name = replace
                } else {
                    el.location = replace
                }

                PersistentContainer.shared.saveContext()
            }
        } catch {
            print(error)
        }
    }
    
}
