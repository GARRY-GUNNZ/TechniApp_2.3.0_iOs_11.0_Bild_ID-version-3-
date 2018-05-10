//
//  AddBatiments.swift
//  TechniApp
//
//  Created by Gаггу-Guииz  on 10/05/2018.
//  Copyright © 2018 COFELY_Technibook. All rights reserved.
//

import UIKit




class AddBatiments: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var contratlabel: UILabel!
    @IBOutlet weak var nomBatimentTexfield: YoshikoTextField!
    @IBOutlet weak var numerotexfiled: YoshikoTextField!
    @IBOutlet weak var imageBatiment: UIImageView!
    var ViaSegue = String()
   // var delegate: EditNoteViewControllerDelegate!
    var imageURL: URL!
    let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    let tempImageName = "temp_image.jpg"
    var editedNoteRecord: CKRecord!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contratlabel.text = ViaSegue

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func choixPhoto(_ sender: DesignableButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func addBatiment(_ sender: AnyObject) {
       // if txtNoteTitle.text == " " || textView.text == " " {
           // return
       // }
        
     //   viewWait.isHidden = false
      //  view.bringSubview(toFront: viewWait)
      //  navigationController?.setNavigationBarHidden(true, animated: true)
        
        //var noteRecord: CKRecord!
      //  var isEditingNote: Bool!
     //   let etat = "en Stock"
       
          //  let timestampAsString = String(format: "%f", Date.timeIntervalSinceReferenceDate)
          //  let timestampParts = timestampAsString.components(separatedBy: ".")
      //  _ = CKRecordID(recordName: timestampParts[0])
            
        
            
           // isEditingNote = false
        
        
         let noteRecord = CKRecord(recordType: "Batiment")
        
       
       
        noteRecord.setObject(numerotexfiled.text as CKRecordValue?, forKey: "numberContrat")
        noteRecord.setObject(nomBatimentTexfield.text as CKRecordValue?, forKey: "nomBatiment")
        noteRecord.setObject(contratlabel.text as CKRecordValue?, forKey: "nomContrats")
        
        
        
        
        if let url = imageURL {
            let imageAsset = CKAsset(fileURL: url)
            noteRecord.setObject(imageAsset, forKey: "xavatarBati")
        }
        else {
            let fileURL = Bundle.main.url(forResource: "no_image", withExtension: "png")
            let imageAsset = CKAsset(fileURL: fileURL!)
            noteRecord.setObject(imageAsset, forKey: "xavatarBati")
        }
        
        
        
        let container = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
        let publicDatabase = container.publicCloudDatabase
        
        
        publicDatabase.save(noteRecord, completionHandler: { (record, error) -> Void in
            if (error != nil) {
                print("error")
            }
            
            
            OperationQueue.main.addOperation({ () -> Void in
                
             self.dismiss(animated: true, completion: nil)
               // self.viewWait.isHidden = true
            })
        })
        
        
        
        
        
        
    }
    
    
    
    @IBAction func dissmiss(_ sender: AddBatiments) {
        
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
    
    func saveImageLocally() {
        let imageData: Data = UIImageJPEGRepresentation(imageBatiment.image!, 0.3)!
        let path = documentsDirectoryPath.appendingPathComponent(tempImageName)
        imageURL = URL(fileURLWithPath: path)
        try? imageData.write(to: imageURL, options: [.atomic])
    }
    
    
    // MARK: UIImagePickerControllerDelegate method implementation
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageBatiment.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageBatiment.contentMode = UIViewContentMode.scaleAspectFit
        
        saveImageLocally()
        
        imageBatiment.isHidden = false
       // btnRemoveImage.isHidden = false
       // btnSelectPhoto.isHidden = true
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    deinit {
        print( "la page addBati  est des-initialiez ")
    }
  

}
