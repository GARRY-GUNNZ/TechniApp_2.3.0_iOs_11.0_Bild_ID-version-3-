//
//  CommandeFiltreTableViewController.swift
//  TechniApp
//
//  Created by Gаггу-Guииz  on 11/08/2017.
//  Copyright © 2017 COFELY_Technibook. All rights reserved.
//
import CloudKit
import UIKit

class CommandeFiltreTableViewController: UITableViewController {
    
    //@IBOutlet weak var viewWait: UIView!
    @IBOutlet weak var tblPieces: UITableView!
    
    var arrFiltre: Array<CKRecord> = []
    
    var refresh:UIRefreshControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         /////  refresh button
         refresh = UIRefreshControl()
         refresh.attributedTitle = NSAttributedString(string: "Chargement les filtres à commander")
         refresh.addTarget(self, action:#selector(CommandeFiltreTableViewController.fetchNotes), for: .valueChanged)
         self.tblPieces.addSubview(refresh)
 
        
        
        fetchNotes()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
      //   MARK: - TABLEVIEW
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Commande des Filtres"
    }
    
    ///////////////////////////////////////////////////////////////
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    ////////////////////////////////////////////////////////////////
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrFiltre.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform
        
        UIView.animate(withDuration: 1) {
            cell.alpha = 1
           // cell.layer.transform = CATransform3DIdentity
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if arrFiltre.count == 0 {
            return cell
        }
        
        /// bouton a commander //////////////////////
        let switchDemo = UISwitch ()
        
        switchDemo.center = CGPoint(x: 930, y: 50)
       // switchDemo.isOn = false
        switchDemo.onTintColor = UIColor .brown
        //  switchDemo.setOn(true, animated: false)
        switchDemo.tag = indexPath.row;
        // action button
        switchDemo.addTarget(self, action: #selector(CommandeFiltreTableViewController.switchCommande(_:)), for:.valueChanged )
        
        //cell.addSubview(switchDemo)
        cell.accessoryView = (switchDemo)
        
       
        
        
        
        /////////////////////////////////////////////////////////
        
        
        
        let theLabelInstal : UILabel  = self.view.viewWithTag(2) as! UILabel
        let theLabelContrat : UILabel  = self.view.viewWithTag(3) as! UILabel
        let imageView : UIImageView  = self.view.viewWithTag(1) as! UIImageView
        let theLabelBati : UILabel  = self.view.viewWithTag(5) as! UILabel
        let theLabelLongeur : UILabel  = self.view.viewWithTag(6) as! UILabel
        let theLabelLargeur : UILabel  = self.view.viewWithTag(7) as! UILabel
        let theLabelEpaisseur : UILabel  = self.view.viewWithTag(8) as! UILabel
        let theLabelQuantite : UILabel  = self.view.viewWithTag(9) as! UILabel
       // let textview : UITextView  = self.view.viewWithTag(8) as! UITextView
        
        
        
        
        
        
        
        let listePieces = arrFiltre[(indexPath as NSIndexPath).row]
        
       
        theLabelContrat.text = listePieces["nomContrat"] as? String
        theLabelInstal.text = listePieces["nomInstal"] as? String
        theLabelBati.text = listePieces["nomBati"] as? String
        theLabelLongeur.text = listePieces["dimention"] as? String
        theLabelLargeur.text = listePieces["type"] as? String
        theLabelEpaisseur.text = listePieces["Profondeur"] as? String
        theLabelQuantite.text = listePieces["quantite"] as? String
        
        let imageAsset: CKAsset = listePieces.value(forKey: "avatarFiltre") as! CKAsset
        imageView.image = UIImage(contentsOfFile: imageAsset.fileURL.path)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        
        
        //  ====================AVATAR PIECES BUG ===========================================
        //cell.detailTextLabel?.text = listecourroies["type"] as? String
        // let imageAsset: CKAsset = listePieces.value(forKey: "noteImage") as! CKAsset
        // image.image = UIImage(contentsOfFile: imageAsset.fileURL.path)
        //image.contentMode = UIViewContentMode.scaleAspectFit
        
        //  ==============================================================
        
        
        
        
        /*
        
        if (listePieces.value(forKey: "EtatComande") as! Bool) {
            
            
            switchDemo.isOn = true
            print(switchDemo.isOn)
            print("on")
            
        }
        
        */
        
        
        
        
        
        /*
         else
         {
         // switchDemo.isOn = false
         print(switchDemo.isOn)
         print("off")
         
         }
         */
        
        
        
        
        
        
        
        
        return cell
    }
    
    
    /////////  ///// Action Boutton/////////////////////////////////////
    /*
     func switchCommande(_ sender: UISwitch)
     {
     
     
     if (sender.isOn == true)
     {
     print("on")
     }
     else
     {
     print("off")
     
     }
     
     
     }
     */
    
    //////////////////////////////////////////////////////////////
    
    @objc func switchCommande(_ sender: UISwitch)
    {
        
        let switchh = sender
        
        
        
        if (sender.isOn == false){
            
            print(sender.tag)
            
            
            let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
            let publicDB = monContainaire.publicCloudDatabase
            
            let switchAction: CKRecord = self.arrFiltre[switchh.tag]
            let etat = "A commander"
            
            switchAction.setValue(etat, forKey: "Etat")
            switchAction.setValue(1, forKey: "EtatComande")
            // switchAction["EtatComande"] = "YES" as CKRecordValue?
            // [tempObject setObject:@YES           forKey:@"EtatComande"];
            publicDB.save(switchAction, completionHandler: { (record, error) -> Void in
                
                
                
                if (error != nil) {
                    print("error switch en commande ")
                }
                OperationQueue.main.addOperation({ () -> Void in
                    //self.viewWait.isHidden = true
                    
                    
                    // self.navigationController?.setNavigationBarHidden(false, animated: true)
                    //print("ok")
                    //print(self.arrNotes)
                    // self.fetchNotes()
                    //self.tblPieces.reloadData()
                    
                })
            })
        }
        else {
            
            print(sender.tag)
            
            let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
            let publicDB = monContainaire.publicCloudDatabase
            let switchAction: CKRecord = self.arrFiltre[switchh.tag]
            let etats = "En Stock"
            switchAction.setValue(etats, forKey: "Etat")
            switchAction.setValue(0, forKey: "EtatComande")
            //switchAction["Etat"] = "en commande"as CKRecordValue?
            
            publicDB.save(switchAction, completionHandler: { (record, error) -> Void in
                
                
                
                if (error != nil) {
                    print("error switch en stock")
                }
                OperationQueue.main.addOperation({ () -> Void in
                    //self.viewWait.isHidden = true
                    // self.navigationController?.setNavigationBarHidden(false, animated: true)
                    // print("ok")
                    // print(self.arrNotes)
                    // self.fetchNotes()
                    // self.tblPieces.reloadData()
                    
                    self.alertReceptionFiltres()
                })
            })
            
            
        }
        
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        

        {
        
        if  tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark
      {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        }
        else
        {
    tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
    }
    
          
    }
    
    
      //   MARK: - CLOUDKIT FETCH
    
    @objc func fetchNotes() {
        
        /*
        viewWait.isHidden = false
        view.bringSubview(toFront: viewWait)
        
        */
        
        
        
        let container = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
        let publicDatabase = container.publicCloudDatabase
        //let predicate = NSPredicate(value: true)
        
        let number = "A commander"
        // print(number)
        // let predicate = NSPredicate (format: "(nomBati == %@) AND (nomInstal == %@)",batiLabel.text!,instalLabel.text!)
        
        // (arrNotes as NSArray).filteredArrayUsingPredicate(<#T##predicate: NSPredicate##NSPredicate#>)
        
        // let predicate = NSPredicate (format: "nomBati == %@ ",nomBatisegu )
        
        // NSPredicate predicate = nil;
        let predicate = NSPredicate (format: "Etat == %@ ",number)
        
        
        let query = CKQuery(recordType: "Filtres", predicate: predicate)
        
       
        query.sortDescriptors = [NSSortDescriptor(key: "nomBati", ascending: true)]
  
        
        
        
        publicDatabase.perform(query, inZoneWith: nil) { (results, error) -> Void in
            
            if let contratRecup = results {
                self.arrFiltre = contratRecup
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.tblPieces.reloadData()
                     self.refresh.endRefreshing()
                    
                    self.tblPieces.isHidden = false
                   // self.viewWait.isHidden = true
                })
            }
            else {
                print("erreur de chargement des filtres")
            }
        }
    }
    
    
    func alertReceptionFiltres ()
    {
        let alertView = UIAlertView();
        alertView.addButton(withTitle: "ok")
        // alertView.addButtonWithTitle("Ok");
        alertView.title = "Filtres Réceptionnés";
        alertView.message = "Vous venez de réceptionner une référence de filtre ";
        alertView.show();
    }
    
    
    
    

    
}

