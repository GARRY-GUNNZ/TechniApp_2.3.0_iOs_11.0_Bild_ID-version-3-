//
//  AddProfilViewController.swift
//  TechniApp
//
//  Created by Gаггу-Guииz  on 12/02/2017.
//  Copyright © 2017 COFELY_Technibook. All rights reserved.
//
import UIKit

class AddProfilViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
     // MARK: OUTLET
    @IBOutlet weak var vueChargement: UIView!
    @IBOutlet weak var nomProfil: UITextField!
    @IBOutlet weak var prenomProfil: UITextField!
    @IBOutlet weak var nomEquipe: UITextField!
    @IBOutlet weak var avatarProfil: UIImageView!
     // MARK: VARRIABLE
    var imageURL: URL!
    let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    let tempImageName = "temp_image.jpg"
    
    // var editedNoteRecord: CKRecord!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.vueChargement.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ajouterAvatar(_ sender: Any)
    {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)

        }
        
        
    }
    
    
    
    
     // MARK: CLOUD KIT FETCH
    @IBAction func sauveProfil(_ sender: AnyObject)
        
        
    {
        
       // let imageAvatar = UIImage(named:"51456_1448924M.png")
        let imagedata : NSData = UIImagePNGRepresentation(avatarProfil.image!)! as NSData
        UserDefaults.standard.set(imagedata, forKey: "avatar")
        UserDefaults.standard.set(nomProfil.text!, forKey: "nom")
        UserDefaults.standard.set(prenomProfil.text!, forKey: "prenom")
        UserDefaults.standard.set(nomEquipe.text!, forKey: "nomEquipe")
        UserDefaults.standard.synchronize()
        
        print(NSError.self)
         self.vueChargement.isHidden = false
    
        self.dismiss(animated: true, completion: nil)
         self.vueChargement.isHidden = true
        
        
       
    }
    
    func exit ()  {
        let alert = UIAlertController(title: "SAVE", message: "Votre Profil à été enregistré , il sera mise à jour au prochain démarrage de l'appilcation  ", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(okaction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func saveImageLocally() {
        let imageData: Data = UIImageJPEGRepresentation(avatarProfil.image!, 0.3)!
        let path = documentsDirectoryPath.appendingPathComponent(tempImageName)
        imageURL = URL(fileURLWithPath: path)
        try? imageData.write(to: imageURL, options: [.atomic])
    }
    
  
    
    
    
    
    
    // MARK: UIImagePickerControllerDelegate method implementation
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        avatarProfil.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        avatarProfil.contentMode = UIViewContentMode.scaleAspectFit
        
        saveImageLocally()
        
        avatarProfil.isHidden = false
        // btnRemoveImage.isHidden = false
        // btnSelectPhoto.isHidden = true
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}
