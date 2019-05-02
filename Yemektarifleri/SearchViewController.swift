//
//  SearchViewController.swift
//  Yemektarifleri
//
//  Created by TALHA AYAR on 9.10.2018.
//  Copyright © 2018 TALHA AYAR. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PinterestLayout

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
   var items = [
    PinterestItem(image: UIImage(named: "recipe.png")!, text: "text"),
    PinterestItem(image: UIImage(named: "recipe.png")!, text: "text"),
    PinterestItem(image: UIImage(named: "recipe.png")!, text: "text"),
    PinterestItem(image: UIImage(named: "recipe.png")!, text: "text"),
    PinterestItem(image: UIImage(named: "recipe.png")!, text: "text")
    ]
  
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var recipeArray = [[String:AnyObject]]()
    var selectedTitle = ""
    var selectedHref = ""
    
    
    
    override func viewDidLoad() {
      
        self.navigationItem.title = "Search"
        navigationItem.titleView?.backgroundColor = UIColor.groupTableViewBackground
        navigationController?.navigationBar.barTintColor = UIColor.groupTableViewBackground
        tabBarController?.tabBar.barTintColor = UIColor.groupTableViewBackground
       
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        
        self.collectionView.layer.cornerRadius = 10
        self.collectionView.layer.masksToBounds = true
        super.viewDidLoad()
        
        
        UISearchBar.appearance().setImage(UIImage(named: "search.png"), for: UISearchBar.Icon.search, state: UIControl.State.normal)
        

        
       
       
    }
    
    func searchRecipe (foodName : String, page : Int) {
        print("http://www.recipepuppy.com/api/?q=" + foodName + "&p=" + String(page))
        Alamofire.request("http://www.recipepuppy.com/api/?q=" + foodName + "&p=" + String(page)).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let res = JSON(responseData.result.value!)
                
                if let resData = res["results"].arrayObject {
                    self.recipeArray = resData as! [[String: AnyObject]]
                }
                if self.recipeArray.count > 0 {
                    self.collectionView.reloadData()
                    
                }
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        var dict = recipeArray[indexPath.item]
       cell.foodName.text = dict["title"] as? String
        cell.hrefLabel.text = dict["href"] as? String
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
        selectedTitle = (recipeArray[indexPath.item])["title"] as! String
        selectedHref = (recipeArray[indexPath.item])["href"] as! String
        self.collectionView.backgroundView?.backgroundColor = UIColor.groupTableViewBackground
        performSegue(withIdentifier: "searchToDetails", sender: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchRecipe(foodName: searchBar.text!, page: 1)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if "toDetails" == segue.identifier {
            let dest = segue.destination as! FavoritesViewController
            dest.titleString = selectedTitle
            dest.hrefString = selectedHref
            
        }
        if "searchToDetails" == segue.identifier {
            let desti = segue.destination as! DetailsViewController
            desti.urlString = selectedHref
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 2{
            
            return CGSize(width: 150, height: 100)
            
        }else if collectionView.tag == 4 {
            
            
            return CGSize(width: 222, height: 200)
            
        }else{
            
            
            return CGSize(width: 10, height: 10)
        }
    }

}

