//
//  ListNotesViewController.swift
//  TechniApp
//
//  Created by Gаггу-Guииz  on 23/07/2016.
//  Copyright © 2016 COFELY_Technibook. All rights reserved.
//

import UIKit
import CloudKit
import QuartzCore



class ListNotesViewController: UITableViewController, EditNoteViewControllerDelegate
{
    //   MARK: - OUTLET
    @IBOutlet weak var tblNotes: UITableView!
    @IBOutlet var batiLabel: UILabel!
    @IBOutlet  var instalLabel: UILabel!
    @IBOutlet var contratLabel: UILabel!
    @IBOutlet weak var viewWait: UIView!
    
    //   MARK: - VARRIABLE
    var arrNotes: Array<CKRecord> = []
    var selectedNoteIndex: Int!
    var Batiment: CKRecord!
   @objc var nomBatisegu = String ()
    @objc var instalsegu = String ()
    @objc var contratsegu = String()
    
 
  
      //   MARK: - LIFE VIEW

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        tblNotes.delegate = self
        tblNotes.dataSource = self

        batiLabel.text = nomBatisegu
        instalLabel.text = instalsegu
        contratLabel.text = contratsegu
        
       // print(arrNotes)
        
          fetchNotes()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
      //   MARK: - TABLEVIEW
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Listes des Pièces détachées"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNotes.count
    }
    

    //   MARK: - BOUTON SWITCH
    
    @objc func switchCommande(_ sender: UISwitch)
    {
        
        let switchh = sender
        
        if (sender.isOn == true)
        {

          
            
            let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
            
            let publicDB = monContainaire.publicCloudDatabase
            
            let switchAction: CKRecord = self.arrNotes[switchh.tag]
            
            
            let etat = "en commande"
            switchAction.setValue(etat, forKey: "Etat")
            switchAction.setValue(1, forKey: "EtatComande")
           
            publicDB.save(switchAction, completionHandler: { (record, error) -> Void in
            
                       
                
                if (error != nil) {
                    print("error")
                }
                OperationQueue.main.addOperation({ () -> Void in
                    //self.viewWait.isHidden = true
                   // self.navigationController?.setNavigationBarHidden(false, animated: true)
                    //print("ok")
                    //print(self.arrNotes)
                })
            })
        }
     else {
            let etats = "en Stock"
            
            let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
            let publicDB = monContainaire.publicCloudDatabase
            let switchAction: CKRecord = self.arrNotes[switchh.tag]
            
            
            switchAction.setValue(etats, forKey: "Etat")
            switchAction.setValue(0, forKey: "EtatComande")
            //switchAction["Etat"] = "en commande"as CKRecordValue?
            
            publicDB.save(switchAction, completionHandler: { (record, error) -> Void in
                
                
                
                if (error != nil) {
                    print("error")
                }
                OperationQueue.main.addOperation({ () -> Void in
                    //self.viewWait.isHidden = true
                    // self.navigationController?.setNavigationBarHidden(false, animated: true)
                   // print("ok")
                   // print(self.arrNotes)
                })
            })
    
            
    }
   
}











    //   MARK: - TABLEVIEW CUSTOMISATION
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0.5
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 30, 0)
        cell.layer.transform = transform
        
        UIView.animate(withDuration: 1) {
            cell.alpha = 1
           // cell.layer.transform = CATransform3DIdentity
        }
    }







    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCellNote", for: indexPath)
        
        
        if arrNotes.count == 0 {
            return cell
        }

        
        
        /// bouton a commander //////////////////////
        let switchDemo = UISwitch ()
        
        switchDemo.center = CGPoint(x: 305, y:90)
       // switchDemo.isOn = false
        switchDemo.onTintColor = UIColor.brown
      
        switchDemo.tag = indexPath.row;
        
        
        // action button
        switchDemo.addTarget(self, action: #selector(ListNotesViewController.switchCommande(_:)), for:.valueChanged )
        
        //cell.addSubview(switchDemo)
         cell.accessoryView = (switchDemo)

        
         //custum cell a programmer
 
         let theLabelTitre : UILabel  = self.view.viewWithTag(6) as! UILabel
         let theLabelInstal : UILabel  = self.view.viewWithTag(8) as! UILabel
         let theLabelDate : UILabel  = self.view.viewWithTag(3) as! UILabel
         let imageView : UIImageView  = self.view.viewWithTag(1) as! UIImageView
        // let theLabelBati : UILabel  = self.view.viewWithTag(5) as! UILabel
         let textviewD : UITextView  = self.view.viewWithTag(9) as! UITextView
 
 
       // let switchLabel : UILabel  = self.view.viewWithTag(7) as! UILabel
        
        
        
          let noteRecord = arrNotes[(indexPath as NSIndexPath).row]
       
        
      //  let noteRecord: CKRecord = arrNotes[(indexPath as NSIndexPath).row]
        
        textviewD.text = noteRecord ["noteText"] as? String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy, hh:mm"
        theLabelDate.text = dateFormatter.string(from: noteRecord.value(forKey: "noteEditedDate") as! Date)
 
        let imageAsset: CKAsset = noteRecord.value(forKey: "noteImage") as! CKAsset
        imageView.image = UIImage(contentsOfFile: imageAsset.fileURL.path)
        //imageView.contentMode = UIViewContentMode.scaleAspectFit
 
        theLabelInstal.text = noteRecord.value(forKey: "nomInstal") as? String
        theLabelTitre.text = noteRecord.value(forKey: "noteTitle") as? String
        
       // switchLabel.text = noteRecord.value(forKey: "Etat") as? String
        
        
        
        
        if ((noteRecord.value(forKeyPath: "EtatComande") as? integer_t) != 1)
            
        {
            switchDemo.setOn(false, animated: true)
            
        }
            
        else
        {
           switchDemo .setOn(true, animated: true)
        }


        return cell
    }

   
    
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165.0
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNoteIndex = (indexPath as NSIndexPath).row
        performSegue(withIdentifier: "idSegueEditNote", sender: self)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
{
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            let selectedRecordID = arrNotes[(indexPath as NSIndexPath).row].recordID
            
            print(selectedRecordID)

            viewWait.isHidden = false
            view.bringSubview(toFront: viewWait)
            
            
            let container = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
            let publicDatabase = container.publicCloudDatabase

           // let container = CKContainer.default()
           // let publicDatabase = container.publicCloudDatabase
            
            publicDatabase.delete(withRecordID: selectedRecordID, completionHandler:
            { (recordID, error) -> Void in
                if error != nil
                {
                    //print(error)
            }
                else
                {
                    OperationQueue.main.addOperation(
                    { () -> Void in
                        self.arrNotes.remove(at: (indexPath as NSIndexPath).row)
                        self.tblNotes.reloadData()
                         self.viewWait.isHidden = true
                    })
                      }
                 })
        }
}
    
    
    // MARK: FETCH CLOUDKIT
    
    func fetchNotes() {
        
        viewWait.isHidden = false
       view.bringSubview(toFront: viewWait)
        
    
        
        let container = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
        let publicDatabase = container.publicCloudDatabase
        

    
        //let predicate = NSPredicate(value: true)
    
        
    // let predicate = NSPredicate (format: "(nomBati == %@) AND (nomInstal == %@)",batiLabel.text!,instalLabel.text!)
        
       // (arrNotes as NSArray).filteredArrayUsingPredicate(<#T##predicate: NSPredicate##NSPredicate#>)
        
   // let predicate = NSPredicate (format: "nomBati == %@ ",nomBatisegu )
        
        
       let predicate = NSPredicate(format: "nomBati = %@ AND nomInstal = %@ AND nomContrat == %@", argumentArray: [nomBatisegu, instalsegu,contratsegu])
        
        let query = CKQuery(recordType: "Notes", predicate: predicate)
        
        
        
        publicDatabase.perform(query, inZoneWith: nil) { (results, error) -> Void in
            if error != nil {
               // print(error)
            }
            else {
               // print(results)
                
                for result in results! {
                    self.arrNotes.append(result )
                }
                
                OperationQueue.main.addOperation({ () -> Void in
                    self.tblNotes.reloadData()
                    self.tblNotes.isHidden = false
                   self.viewWait.isHidden = true
                    
                    
                })
            }
        }
    }
    
    
    // MARK: EditNoteViewControllerDelegate method implementation
    
    func didSaveNote(_ noteRecord: CKRecord, wasEditingNote: Bool) {
        if !wasEditingNote {
            arrNotes.append(noteRecord)
        }
        else {
            arrNotes.insert(noteRecord, at: selectedNoteIndex)
            arrNotes.remove(at: selectedNoteIndex + 1)
            selectedNoteIndex = nil
        }
        
        
        if tblNotes.isHidden {
            tblNotes.isHidden = false
        }
        
        tblNotes.reloadData()
    }
    
    
    /*
    @IBAction func dismiss(_ sender: AnyObject)
    {
      self.dismiss(animated: true, completion: nil)
    
    }
    */
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "idSegueEditNote" {
            
            let editNoteViewController = segue.destination as! EditNoteViewController
            editNoteViewController.delegate = self
            
            let newVC:EditNoteViewController = segue.destination as! EditNoteViewController
            
            
            newVC.nomBatiseg = nomBatisegu
            newVC.instalseg = instalsegu
            newVC.contratseg = contratsegu
            
            if let index = selectedNoteIndex {
                editNoteViewController.editedNoteRecord = arrNotes[index]
                
                
            }
        }
    }
    
}

