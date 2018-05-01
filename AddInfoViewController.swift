//
//  AddInfoViewController.swift
//  TechniApp
//
//  Created by Gаггу-Guииz  on 01/07/2017.
//  Copyright © 2017 COFELY_Technibook. All rights reserved.
//

import UIKit
import CloudKit
import QuartzCore


  protocol AddInfoViewControllerDelegate {
    func didSaveNote(_ noteRecord: CKRecord, wasEditingNote: Bool)
    
    
    }

class AddInfoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
  // MARK: OUTLET
    
    @IBOutlet weak var viewWait: UIView!
    @IBOutlet weak var nomClient: UITextField!
    @IBOutlet weak var prenomClient: UITextField!
    @IBOutlet weak var telClient: UITextField!
    @IBOutlet weak var emailClient: UITextField!
    @IBOutlet weak var fonctionClient: UITextField!
    @IBOutlet weak var avatarContra: UIImageView!
    @IBOutlet weak var btnRemoveImage: UIButton!
    @IBOutlet weak var numeroContrat: UILabel!
    @IBOutlet weak var nomContrats: UILabel!
   
       // MARK: VARRIABLE
    var numeroContratseg = String ()
    var contratseg = String()
    var delegate: AddInfoViewControllerDelegate!
    var editeInfoRecord: CKRecord!
    var isEditingNote: Bool!
    var imageURL: URL!
    let tempImageName = "temp_image.jpg"
    var arrContrat: Array<CKRecord> = []
    
    let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    
    
    

   
     // MARK: FETCH CONTRAT
    
func fetchInfoContrat() {
        
        
        self.viewWait.isHidden = false
       // view.bringSubview(toFront: viewWait)
    
    
    let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
    
    let publicDatabase = monContainaire.publicCloudDatabase
    
        let predicate = NSPredicate(format: "numerosContrat = %@ AND nomContrat = %@", argumentArray: [ numeroContratseg,contratseg])
        
        let query = CKQuery(recordType: "InfoContrats", predicate: predicate)
    
        publicDatabase.perform(query, inZoneWith: nil) { (results, error) -> Void in
            if error != nil {
                 print(error as Any)
            }
            else {
                 print(results as Any)
                
               for result in results! {
                    self.arrContrat = [result]
                    
                    
                    self.nomClient.text = result.value(forKey: "NomClient") as? String
                    self.prenomClient.text = result.value(forKey: "PrenomClient") as? String
                self.emailClient.text = result.value(forKey: "EmailClient") as? String
                self.fonctionClient.text = result.value(forKey: "FonctionClient") as? String
                self.telClient.text = result.value(forKey: "TelClient") as? String
                
                
                
                    let imageAsset: CKAsset = (result.value(forKey: "AvatarClient") as? CKAsset)!
                    self.avatarContra.image = UIImage(contentsOfFile: imageAsset.fileURL.path)
                
                }
                
                DispatchQueue.main.async(execute: { () -> Void in
                   // self.tblNotes.reloadData()
                    //self.tblNotes.isHidden = false
                    self.viewWait.isHidden = true
                    
                    
                })
            }
        }
    }

        
        
        
        
        
        
        
        
        
        
        
    
    
    
    
    
    
    
    

    @IBAction func cancel(_ sender: Any) {
        
        _ = navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)

    }
    
    // MARK: VIEW LIFE
    
  override func viewDidLoad() {
       
        
        super.viewDidLoad()
        self.viewWait.isHidden = false
         btnRemoveImage.isHidden = false
        fetchInfoContrat()
         
        numeroContrat.text = numeroContratseg
       nomContrats.text = contratseg

        
        let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(AddInfoViewController.handleSwipeDownGestureRecognizer(_:)))
        swipeDownGestureRecognizer.direction = UISwipeGestureRecognizerDirection.down
        view.addGestureRecognizer(swipeDownGestureRecognizer)
    
        if let editedNote = editeInfoRecord {
            
            
            nomClient.text = editedNote.value(forKey: "NomClient") as? String
            prenomClient.text = (editedNote.value(forKey: "PrenomClient") as? String)
            telClient.text = editedNote.value(forKey: "TelClient") as? String
            emailClient.text = editedNote.value(forKey: "EmailClient") as? String
            fonctionClient.text = editedNote.value(forKey: "FonctionClient") as? String
            contratseg = (editedNote.value(forKey: "nomContrat") as? String)!
            numeroContratseg = (editedNote.value(forKey: "numerosContrat") as? String)!
            
            
            let imageAsset: CKAsset = editedNote.value(forKey: "AvatarClient") as! CKAsset
            avatarContra.image = UIImage(contentsOfFile: imageAsset.fileURL.path)
            avatarContra.contentMode = UIViewContentMode.scaleAspectFit
            
            imageURL = imageAsset.fileURL
            
            avatarContra.isHidden = false
            btnRemoveImage.isHidden = false
           // btnSelectPhoto.isHidden = true
            
         ///TEST //////////////////////////////
        }

        self.viewWait.isHidden = true
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK:  SAVE BOUTON
    
    @IBAction func sauveProfil(_ sender: AnyObject)
    {
  
    if nomClient.text == " " || telClient.text == " "  {
    return
  }
    
    self.viewWait.isHidden = false
   // view.bringSubview(toFront: viewWait)
    navigationController?.setNavigationBarHidden(true, animated: true)
    
    var noteRecord: CKRecord!
    
   // let etat = "en Stock"
    if let editedNote = editeInfoRecord {
        noteRecord = editedNote
        isEditingNote = true
    }
    else {
    let timestampAsString = String(format: "%f", Date.timeIntervalSinceReferenceDate)
    let timestampParts = timestampAsString.components(separatedBy: ".")
    let noteID = CKRecordID(recordName: timestampParts[0])
    
    noteRecord = CKRecord(recordType: "InfoContrats", recordID: noteID)
        
    
    isEditingNote = false
    }
    
    noteRecord.setObject(nomClient.text as CKRecordValue?, forKey: "NomClient")
    noteRecord.setObject(prenomClient.text as CKRecordValue?, forKey: "PrenomClient")
    noteRecord.setObject(emailClient.text as CKRecordValue?, forKey: "EmailClient")
    noteRecord.setObject(numeroContrat.text as CKRecordValue?, forKey: "numerosContrat")
    noteRecord.setObject(nomContrats.text as CKRecordValue?, forKey: "nomContrat")
    noteRecord.setObject(fonctionClient.text as CKRecordValue?, forKey: "FonctionClient")
  noteRecord.setObject(telClient.text as CKRecordValue?, forKey: "TelClient")
        
         noteRecord.setObject(Date() as CKRecordValue?, forKey: "noteEditedDate")
        
    
    
    
    if let url = imageURL {
        let imageAsset = CKAsset(fileURL: url)
        noteRecord.setObject(imageAsset, forKey: "AvatarClient")
    }
    else {
    let fileURL = Bundle.main.url(forResource: "no_image", withExtension: "png")
    let imageAsset = CKAsset(fileURL: fileURL!)
    noteRecord.setObject(imageAsset, forKey: "AvatarClient")
    }
    
        let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
        
        let publicDatabase = monContainaire.publicCloudDatabase
    
    publicDatabase.save(noteRecord, completionHandler: { (record, error) -> Void in
    if (error != nil) {
    print("error")
    }
    else {
    
   // self.delegate.didSaveNote(noteRecord, wasEditingNote: isEditingNote)
    }
    
   DispatchQueue.main.async(execute: { () -> Void in
    
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    self.viewWait.isHidden = true
    })
    })
}

    @objc func handleSwipeDownGestureRecognizer(_ swipeGestureRecognizer: UISwipeGestureRecognizer) {
        prenomClient.resignFirstResponder()
        nomClient.resignFirstResponder()
    }

// MARK: ADD PHOTOS
    @IBAction func addPhotoContra(_ sender: Any)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
        func saveImageLocally() {
            let imageData: Data = UIImageJPEGRepresentation(avatarContra.image!, 0.8)!
            let path = documentsDirectoryPath.appendingPathComponent(tempImageName)
            imageURL = URL(fileURLWithPath: path)
            try? imageData.write(to: imageURL, options: [.atomic])
        }
        
        
        // MARK: UIImagePickerControllerDelegate method implementation
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            avatarContra.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            avatarContra.contentMode = UIViewContentMode.scaleAspectFit
            
            saveImageLocally()
            
            avatarContra.isHidden = false
            btnRemoveImage.isHidden = false
            // btnSelectPhoto.isHidden = true
            
            self.dismiss(animated: true, completion: nil)
        }
        

    @IBAction func unsetImage(_ sender: AnyObject) {
        avatarContra.image = nil
        
        avatarContra.isHidden = true
        btnRemoveImage.isHidden = true
       // btnSelectPhoto.isHidden = false
        
        imageURL = nil
    }
    
}
