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

class AddGameViewController: UIViewController, UIImagePickerControllerDelegate {

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

        dateFormatter.dateFormat = "dd/MM/yyy"
        
        // Keyboard -> teclado
        
        // Cuando se muestra el teclado (KeyBoard)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
        // Cuando se esconde el teclado
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        // Se crea un gesto para que el usuario precione en la parte interior del view se esconda el teclado
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        // Se le asigna el gesto al view
        self.view.addGestureRecognizer(tapGesture)
        
        // Se crea un gesto para cuando el usuario selecciona la imagen
        let takePictureGesture = UITapGestureRecognizer(target: self, action: #selector(takePictureTapped))
        // Se le asigna el gesto a la view
        self.gameImageView.addGestureRecognizer(takePictureGesture)

        imagePickerController.delegate = self
        // allowsEditing permite hacer recortes de una imagen
        imagePickerController.allowsEditing = true
        
        // El datePiker es la tabla que se muestra con todas las fechas en forma de una ruleta
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 210, width: 320, height: 216))
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerChangedValue), for: .valueChanged)
        // Y se lo asignamos a txtBorrowedDate
        txtBorrowedDate.inputView = datePicker
        
        
        if game == nil{
            self.title = "Añador juego"
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
            
            self.btnDelete.isHidden = true
            self.borrowedSwitch.isOn = false
        }else{
            self.title = "Detalles"
            self.txtTitle.text = game?.title
            if let borrowed = game?.borrowed{
                self.borrowedSwitch.isOn = borrowed
            }
            
            self.txtBorrowedTo.text = game?.borrowedTo
            
            if let borrowedDate = game?.borrowedDate{
                self.txtBorrowedDate.text = dateFormatter.string(from: borrowedDate as Date)
            }
            
            if let imageDate = game?.image as Data?{
                self.gameImageView.image = UIImage(data: imageDate)
            }
            
            self.btnDelete.isHidden = true
        }
        
        if !borrowedSwitch.isOn{
            txtBorrowedTo.isEnabled = false
            txtBorrowedDate.isEnabled = false
        }
    }
    
    // Cuando se utilizan los metodos de notification es necesario agregar un NSNotification
    
    func keyBoardWillShow(notification: NSNotification)
    {
        let info = notification.userInfo!
        // Recuperamos el tamaño del teclado
        let keyBoardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue!).cgRectValue
    }
    
    func keyBoardWillHide(notification: NSNotification)
    {
     }
    
    func viewTapped(){}
    
    func takePictureTapped(){}
    
    func datePickerChangedValue(){}
    
    func cancelButtonPressed(){}
    
    func saveButtonPressed(){}
}






