//
//  SecondViewController.swift
//  Yemektarifleri
//
//  Created by TALHA AYAR on 9.10.2018.
//  Copyright © 2018 TALHA AYAR. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData
import PinterestLayout


class FavoritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var titleArray = [String]()
    var hrefArray = [String]()
var titleString = ""
    var hrefString = ""
    @IBOutlet weak var favoritesCollection: UICollectionView!
    
    var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(FavoritesViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.blue
        
        return refreshControl
    }()
    override func viewDidLoad() {
        self.navigationItem.title = "Favorites"
        super.viewDidLoad()
        favoritesCollection.delegate = self
        favoritesCollection.dataSource = self
        
        self.favoritesCollection.addSubview(self.refreshControl)
        
      
        fetchData()
        
    }
    
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        fetchData()
        self.favoritesCollection.reloadData()
        refreshControl.endRefreshing()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoritesCollection.dequeueReusableCell(withReuseIdentifier: "favoritesCell", for: indexPath) as! FavoritesCollectionViewCell
        cell.recipeName.text = titleArray[indexPath.item]
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10;
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.layer.shadowRadius = 5.0;
        cell.layer.shadowOpacity = 5;
        cell.layer.masksToBounds = false
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        self.hrefString = (self.hrefArray[indexPath.row])
         performSegue(withIdentifier: "favToDetails", sender: nil)
      
        
    }
    
    func fetchData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipes")
        request.returnsObjectsAsFaults = false
        do {
            let results =  try context.fetch(request)
            if results.count > 0 {
                self.titleArray.removeAll(keepingCapacity: false)
                self.hrefArray.removeAll(keepingCapacity: false)
                
                for result in results as! [NSManagedObject] {
                    if let title = result.value(forKey: "title")  {
                        self.titleArray.append(title as! String)
                    }
                    if let href = result.value(forKey: "href") {
                        self.hrefArray.append(href as! String)
                    }
                  
                    self.favoritesCollection.reloadData()
                }
                
            }
            
            
        } catch {
            print("error")
        }
        print(hrefString)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if "favToDetails" == segue.identifier {
            let destin = segue.destination as! DetailsViewController
            destin.urlString = self.hrefString
            
        }
    }
  
}

