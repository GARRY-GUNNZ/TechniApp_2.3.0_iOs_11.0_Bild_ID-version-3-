//
//  EditNoteViewController.swift
//  TechniApp
//
//  Created by Gаггу-Guииz  on 23/07/2016.
//  Copyright © 2016 COFELY_Technibook. All rights reserved.
//

import UIKit
import QuartzCore
import CloudKit


protocol EditNoteViewControllerDelegate {
    func didSaveNote(_ noteRecord: CKRecord, wasEditingNote: Bool)
}


class EditNoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var txtNoteTitle: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var btnSelectPhoto: UIButton!
    
    @IBOutlet weak var btnRemoveImage: UIButton!
    
    @IBOutlet weak var viewWait: UIView!
    
    @IBOutlet weak var textfieldMarque: YoshikoTextField!
    @IBOutlet weak var texfiledPuissance: YoshikoTextField!
    @IBOutlet weak var textfieldReference: YoshikoTextField!
    
    var nomBatiseg = String ()
    var instalseg = String ()
    var contratseg = String()
    
    @IBOutlet var batiLabe: UILabel!
    
    @IBOutlet  var instalLabe: UILabel!
    
    @IBOutlet var contratLabe: UILabel!
    
    

    
    
    var delegate: EditNoteViewControllerDelegate!
    
    var imageURL: URL!
    
    let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    
    let tempImageName = "temp_image.jpg"
    
    var editedNoteRecord: CKRecord!
    
    
      // MARK: - LIFE VIEW
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageURL = nil
        
        batiLabe.text! = nomBatiseg
        instalLabe.text = instalseg
        contratLabe.text = contratseg
        
        
        // Do any additional setup after loading the view.
        
        imageView.isHidden = true
        btnRemoveImage.isHidden = true
        viewWait.isHidden = true
        
        let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(EditNoteViewController.handleSwipeDownGestureRecognizer(_:)))
        swipeDownGestureRecognizer.direction = UISwipeGestureRecognizerDirection.down
        view.addGestureRecognizer(swipeDownGestureRecognizer)
        
        
        if let editedNote = editedNoteRecord {
            txtNoteTitle.text = editedNote.value(forKey: "noteTitle") as? String
            textView.text = editedNote.value(forKey: "noteText") as! String
            textfieldMarque.text = editedNote.value(forKey: "marque") as? String
            textfieldReference.text = editedNote.value(forKey: "reference") as? String
            texfiledPuissance.text = editedNote.value(forKey: "puissance") as? String
            
            
            let imageAsset: CKAsset = editedNote.value(forKey: "noteImage") as! CKAsset
            imageView.image = UIImage(contentsOfFile: imageAsset.fileURL.path)
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            
            imageURL = imageAsset.fileURL
            
            imageView.isHidden = false
            btnRemoveImage.isHidden = false
            btnSelectPhoto.isHidden = true
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.layer.cornerRadius = 10.0
        btnSelectPhoto.layer.cornerRadius = 5.0
        btnRemoveImage.layer.cornerRadius = btnRemoveImage.frame.size.width/2
        
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    // MARK: IBAction method implementation
    
    @IBAction func pickPhoto(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func unsetImage(_ sender: AnyObject) {
        imageView.image = nil
        
        imageView.isHidden = true
        btnRemoveImage.isHidden = true
        btnSelectPhoto.isHidden = false
        
        imageURL = nil
    }
    
      // MARK: - CLOUDKIT FETCH
    
    @IBAction func saveNote(_ sender: AnyObject)
    {
        if txtNoteTitle.text == " " || textView.text == " " {
            return
        }
        
        viewWait.isHidden = false
        view.bringSubview(toFront: viewWait)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        var noteRecord: CKRecord!
        var isEditingNote: Bool!
        let etat = "en Stock"
        if let editedNote = editedNoteRecord {
            noteRecord = editedNote
            isEditingNote = true
        }
        else {
            let timestampAsString = String(format: "%f", Date.timeIntervalSinceReferenceDate)
            let timestampParts = timestampAsString.components(separatedBy: ".")
            let noteID = CKRecordID(recordName: timestampParts[0])
            
            noteRecord = CKRecord(recordType: "Notes", recordID: noteID)
            
            isEditingNote = false
        }
        
        
        
        noteRecord.setObject(txtNoteTitle.text as CKRecordValue?, forKey: "noteTitle")
        noteRecord.setObject(textView.text as CKRecordValue?, forKey: "noteText")
        noteRecord.setObject(Date() as CKRecordValue?, forKey: "noteEditedDate")
        noteRecord.setObject(nomBatiseg as CKRecordValue?, forKey: "nomBati")
        noteRecord.setObject(contratseg as CKRecordValue?, forKey: "nomContrat")
        noteRecord.setObject(instalseg as CKRecordValue?, forKey: "nomInstal")
        noteRecord.setObject(0 as CKRecordValue?, forKey: "EtatComande")
        noteRecord.setObject(etat as CKRecordValue?, forKey: "Etat")
        
        noteRecord.setObject(textfieldReference.text as CKRecordValue?, forKey: "reference")
        noteRecord.setObject(textfieldMarque.text as CKRecordValue?, forKey: "marque")
        noteRecord.setObject(texfiledPuissance.text as CKRecordValue?, forKey: "puissance")
        
        
        if let url = imageURL {
            let imageAsset = CKAsset(fileURL: url)
            noteRecord.setObject(imageAsset, forKey: "noteImage")
        }
        else {
            let fileURL = Bundle.main.url(forResource: "no_image", withExtension: "png")
            let imageAsset = CKAsset(fileURL: fileURL!)
            noteRecord.setObject(imageAsset, forKey: "noteImage")
        }
        
     
        
        let container = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
        let publicDatabase = container.publicCloudDatabase
        
        
        publicDatabase.save(noteRecord, completionHandler: { (record, error) -> Void in
            if (error != nil) {
                print("error")
            }
            else {
                self.delegate.didSaveNote(noteRecord, wasEditingNote: isEditingNote)
            }
            
            OperationQueue.main.addOperation({ () -> Void in
              
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                  self.viewWait.isHidden = true
                            })
        })
        
     
       

    }
    
    
    @IBAction func dismiss(_ sender: EditNoteViewController) {
        
        if let url = imageURL {
            let fileManager = FileManager()
            if fileManager.fileExists(atPath: url.absoluteString) {
                do {
                    try fileManager.removeItem(at: url)
                } catch _ {
                }
            }
        }
        
      // _ = navigationController?.popViewController(animated: true)
       _ = navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Custom method implementation
    
    @objc func handleSwipeDownGestureRecognizer(_ swipeGestureRecognizer: UISwipeGestureRecognizer) {
        txtNoteTitle.resignFirstResponder()
        textView.resignFirstResponder()
    }
    
    
    func saveImageLocally() {
        let imageData: Data = UIImageJPEGRepresentation(imageView.image!, 0.3)!
        let path = documentsDirectoryPath.appendingPathComponent(tempImageName)
        imageURL = URL(fileURLWithPath: path)
        try? imageData.write(to: imageURL, options: [.atomic])
    }
    
    
    // MARK: UIImagePickerControllerDelegate method implementation
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        saveImageLocally()
        
        imageView.isHidden = false
        btnRemoveImage.isHidden = false
        btnSelectPhoto.isHidden = true
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    deinit {
        print( "la page addPièces détaché  est des-initialiez ")
    }
}


 

