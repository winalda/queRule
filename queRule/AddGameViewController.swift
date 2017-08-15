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
    
    //Al mostrar el teclado
    func keyBoardWillShow(notification: NSNotification)
    {
        let info = notification.userInfo!
        // Recuperamos el tamaño del teclado
        let keyBoardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue!).cgRectValue
        // El tiempo que tarda en hacerse la animacion al mostrarse el teclado
        let keyBoardTime = (info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        // Se desplazara toda la vista a la misma velocidad que el teclado sale
        
        //Esta animacion ya es antigua pero aun funciona
        UIView.animate(withDuration: keyBoardTime) { 
            self.view.frame.origin.y = -(keyBoardFrame.height)
        }
    }
    
    //Al ocultar el teclado
    func keyBoardWillHide(notification: NSNotification)
    {
        let info = notification.userInfo!
        // El tiempo que tarda en hacerse la animacion al mostrarse el teclado
        let keyBoardTime = (info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        //Esta animacion ya es antigua pero aun funciona
        UIView.animate(withDuration: keyBoardTime)
        {
            self.view.frame.origin.y = 0
        }
    }
    
    //Al tocar cualquier parte del view se cierre el teclado
    func viewTapped()
    {
        /*Se iran iterando por los todos lo metodos de la vista y en todos aquellos en lo cuales no encontremos un elemento
         Que se pueda transformar en un textField*/
        for view in self.view.subviews
        {
            if let textFiel = view as? UITextField
            {
                textFiel.resignFirstResponder()
            }
        }
    }
    
    //Mostrar la camara
    func takePictureTapped()
    {
        // PReguntamos si tienen permisos de la camara en caso de que no mostramos un alert
        guard camerePermissions else {
            let permissionsAlertController = UIAlertController(title: "Permisos", message: "No tiene los permisos para a la camara del sispositivo. Puede cambiar esta informacion en la app de Ajustes de IOS", preferredStyle: .alert)
            let okAlert = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        }
    }
    
    func datePickerChangedValue(){}
    
    func cancelButtonPressed(){}
    
    func saveButtonPressed(){}
}






