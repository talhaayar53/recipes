//
//  CollectionViewCell.swift
//  Yemektarifleri
//
//  Created by TALHA AYAR on 9.10.2018.
//  Copyright © 2018 TALHA AYAR. All rights reserved.
//

import UIKit
import CoreData
import PinterestLayout



class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var hrefLabel: UILabel!
    @IBOutlet weak var foodName: UILabel!
    @IBAction func favoriteButton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newFood = NSEntityDescription.insertNewObject(forEntityName: "Recipes", into: context)
        newFood.setValue(foodName.text, forKey: "title")
        newFood.setValue(hrefLabel.text, forKey: "href")
        print("saved")
        do {
            try context.save()
            print("saved")
            
        } catch {
            print("error")
        }
        
    
}
}
