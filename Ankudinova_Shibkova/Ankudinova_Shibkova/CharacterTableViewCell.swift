//
//  CharacterTableViewCell.swift
//  Lab4
//
//  Created by Anastasia on 01.07.2023.
//

import UIKit

struct CharacterData {
    enum Status: String {
        case alive = "Жив"
        case dead = "Мертв"
        case unknown = "Неизвестно"
    }

    enum Gender: String {
        case female = "Женщина"
        case male = "Мужчина"
        case genderless = "Бесполый"
        case unknown = "Неизвестно"
    }

    let id: Int
    var name: String
    let status: Status
    let species: String
    let gender: Gender
    var location: String
    let image: String
}



class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    @IBOutlet weak var nameCharacterLabel: UILabel!
    
    @IBOutlet weak var nameButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpData(_ data: Character) {
        nameCharacterLabel.text = data.name
        guard let image = data.image
        else {return}
        characterImageView.download(from: image)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameCharacterLabel.text = nil
        characterImageView.image = nil
    }

}
