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


}

