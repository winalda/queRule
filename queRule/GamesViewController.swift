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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
        
        let game = listGames[indexPath.row]
        
        cell.lblTitle.text = game.title
        
        var highlightColor = #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
        
        if !game.borrowed
        {
            highlightColor = #colorLiteral(red: 0.2196078431, green: 0.2862745098, blue: 0.8588235294, alpha: 1)
        }
        
        cell.lblBorrowed.attributedText = formatColours(string: "PRESTADO: \(game.borrowed ? "SI" : "NO")", color: highlightColor)
        
        if let borrowerTo = game.borrowedTo
        {
            cell.lblBorrowedTo.attributedText = formatColours(string: "A: \(borrowerTo)", color: highlightColor)
        }else{
            cell.lblBorrowedTo.attributedText = formatColours(string: "A: --", color: highlightColor)
        }
        
        if let borrowerDate = game.borrowedDate as Date?
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            cell.lblBorrowedDate.attributedText = formatColours(string: "Fecha: \(dateFormatter.string(from: borrowerDate))", color: highlightColor)
        }else{
            cell.lblBorrowedDate.attributedText = formatColours(string: "Fecha: --", color: highlightColor)
        }
        
        if let image = game.image as Data?
        {
            cell.imageView.image = UIImage(data: image)
        }
        
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.2
        
        return cell
    }
}

