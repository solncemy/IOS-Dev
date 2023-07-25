//
//  Character+CoreDataProperties.swift
//  Ankudinova_Shibkova
//
//  Created by Анатолий Пушкарев on 21.07.2023.
//
//

import Foundation
import CoreData


extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var status: String?
    @NSManaged public var species: String?
    @NSManaged public var gender: String?
    @NSManaged public var location: String?
    @NSManaged public var id: Int32

}

extension Character : Identifiable {

}
