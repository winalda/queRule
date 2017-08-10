//
//  AddGameViewController.swift
//  queRule
//
//  Created by Erick on 01/08/17.
//  Copyright © 2017 Erick. All rights reserved.
//

import UIKit
import CoreData

protocol AddGameViewControllerDelegate {
    func didAddGame()
}

class AddGameViewController: UIViewController {

    @IBOutlet weak var gameImageView : UIImageView!
    @IBOutlet weak var borrowedSwitch : UISwitch!
    @IBOutlet weak var txtTitle : UITextField!
    @IBOutlet weak var txtBorrowedTo : UITextField!
    @IBOutlet weak var txtBorrowedDate : UITextField!
    @IBOutlet weak var btnDelete : UIButton!
    
    var managedObjectContext : NSManagedObjectContext!
    var imagePickerController = UIImagePickerController()
    
    var camerePermissions: Bool = false
    
    var delegate: AddGameViewControllerDelegate?
    
    var game: Game? = nil
    
    var datePicker : UIDatePicker!
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
}
