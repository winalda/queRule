//
//  ViewController.swift
//  queRule
//
//  Created by Erick on 01/08/17.
//  Copyright © 2017 Erick. All rights reserved.
//

import UIKit
import CoreData

class GamesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterControll: UISegmentedControl!
    
    var managedObjectContext: NSManagedObjectContext? = nil
    var listGames: [Game] = [Game]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if listGames.count == 0
        {
           let imageView = UIImageView(image: UIImage(named: "img_empty_screen"))
           imageView.contentMode = .center
           collectionView.backgroundView = imageView
        }else{
            collectionView.backgroundView = UIView()
        }
        
        return listGames.count
    }
}

