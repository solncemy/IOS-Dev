//
//  ViewController.swift
//  Lab3
//
//  Created by Anastasia on 26.06.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var iconInitials: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var underline: UILabel!
    @IBOutlet weak var university: UILabel!
    @IBOutlet weak var nameUniversity: UILabel!
    
    @IBOutlet weak var city: UILabel!
    
    @IBOutlet weak var imgEditUni: UIImageView!
    @IBOutlet weak var buttonEditUni: UIButton!
    @IBOutlet weak var buttonEditCity: UIButton!
    @IBOutlet weak var nameCity: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconInitials.frame = CGRect(origin: .init(x: self.view.frame.width / 2, y: 100), size: CGSize(width: 200, height: 200))
        iconInitials.center.x = self.view.frame.width / 2
        iconInitials.layer.cornerRadius = self.view.frame.width / 4
        iconInitials.text = "AA"
        iconInitials.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 100.0)
        
        
        fullName.frame = CGRect(x: self.view.frame.width / 2, y: 350, width: self.view.frame.width, height: 25)
        fullName.center.x = self.view.frame.width / 2
        fullName.text = "Anastasiia Ankudinova"
        fullName.font = UIFont.systemFont(ofSize: 23)
        
      
        underline.frame = CGRect(x: self.view.frame.width / 2, y: 370, width: self.view.frame.width, height: 20)
        underline.center.x = self.view.frame.width / 2
        underline.text = "___________________________________"
        
        university.frame = CGRect(x: 40, y: 400, width: self.view.frame.width, height: 20)
        university.text = "University"
        university.textColor = .lightGray
        
        nameUniversity.frame = CGRect(x: 40, y: 420, width: self.view.frame.width - 60, height: 60)
        nameUniversity.numberOfLines = 0
        nameUniversity.text = "Innopolis University\nComputer science"
        
        city.frame = CGRect(x: 40, y: 480, width: self.view.frame.width, height: 20)
        city.text = "City"
        city.textColor = .lightGray
        
        nameCity.frame = CGRect(x: 40, y: 510, width: self.view.frame.width - 60, height: 20)
        nameCity.text = "Yoshkar-Ola"
        
        buttonEditUni.setTitle("", for: .normal)
        buttonEditUni.addTarget(self, action: #selector(buttonEditUniTapped), for: .touchUpInside)
        
        buttonEditCity.setTitle("", for: .normal)
        buttonEditCity.addTarget(self, action: #selector(buttonEditCityTapped), for: .touchUpInside)
    }
    
    //из обучающего видео
    @objc func buttonEditUniTapped() {
                let widget = UIAlertController(title: "Enter new value", message: nil, preferredStyle: .alert)
        widget.addTextField { (textField) in
                    textField.placeholder = "University"
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let changeAction = UIAlertAction(title: "Done", style: .default) { (_) in
                    if let newText = widget.textFields?.first?.text {
                        self.nameUniversity.text = newText
                    }
                }
        widget.addAction(cancelAction)
        widget.addAction(changeAction)
                present(widget, animated: true, completion: nil)
                nameUniversity.isUserInteractionEnabled = true
            }
    
    @objc func buttonEditCityTapped() {
                let widget = UIAlertController(title: "Enter new value", message: nil, preferredStyle: .alert)
        widget.addTextField { (textField) in
                    textField.placeholder = "City"
                }

                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let changeAction = UIAlertAction(title: "Done", style: .default) { (_) in
                    if let newText = widget.textFields?.first?.text {
                        self.nameCity.text = newText
                    }
                }
        widget.addAction(cancelAction)
        widget.addAction(changeAction)
                present(widget, animated: true, completion: nil)

                nameCity.isUserInteractionEnabled = true
            }
    
}

