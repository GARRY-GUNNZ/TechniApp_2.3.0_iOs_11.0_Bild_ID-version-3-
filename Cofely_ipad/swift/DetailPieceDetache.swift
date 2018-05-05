//
//  DetailPieceDetache.swift
//  TechniApp
//
//  Created by Gаггу-Guииz  on 06/02/2017.
//  Copyright © 2017 COFELY_Technibook. All rights reserved.
//

import UIKit

class DetailPieceDetache: UITableViewController {
    
      // MARK: - OUTLET
    
   // @IBOutlet weak var viewWait: UIView!
    @IBOutlet weak var tblPieces: UITableView!
    @IBOutlet weak var nomBatiment: UILabel!
    
      // MARK: - VARRIABLE
    
    var arrPieces: Array<CKRecord> = []
    var refresh:UIRefreshControl!
    var nomBatisegu = String ()
    var instalsegu = String ()
    var contratsegu = String()
    
   
    
      // MARK: - LIFE VIEW
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         /////  refresh button
         refresh = UIRefreshControl()
         refresh.attributedTitle = NSAttributedString(string: "Chargement Pièces détachées")
         refresh.addTarget(self, action:#selector(PiecesDetacheeTableViewController.fetchNotes), for: .valueChanged)
         self.tblPieces.addSubview(refresh)
         
      nomBatiment.text = nomBatisegu
        
        fetchNotes()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
      // MARK: - TABLE VIEW
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Commande des Pièces détachées "
    }
    
    ///////////////////////////////////////////////////////////////
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    ////////////////////////////////////////////////////////////////
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrPieces.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform
        
        UIView.animate(withDuration: 0.4) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if arrPieces.count == 0 {
            return cell
        }
        
        /// bouton a commander //////////////////////
        let switchDemo = UISwitch ()
        
        switchDemo.center = CGPoint(x: 330, y: 50)
        switchDemo.isOn = true
        switchDemo.onTintColor = UIColor .brown
        //  switchDemo.setOn(true, animated: false)
        switchDemo.tag = indexPath.row;
        // action button
        switchDemo.addTarget(self, action: #selector(PiecesDetacheeTableViewController.switchCommande(_:)), for:.valueChanged )
        
       // cell.addSubview(switchDemo)
        cell.accessoryView = (switchDemo)
        
        /////////////////////////////////////////////////////////
        
        
        let theLabelTitre : UILabel  = self.view.viewWithTag(6) as! UILabel
       // let theLabelInstal : UILabel  = self.view.viewWithTag(2) as! UILabel
        let theLabelContrat : UILabel  = self.view.viewWithTag(3) as! UILabel
        let imageView : UIImageView  = self.view.viewWithTag(1) as! UIImageView
        let theLabelBati : UILabel  = self.view.viewWithTag(5) as! UILabel
        let nomInstal : UILabel  = self.view.viewWithTag(8) as! UILabel
        
        
        let listePieces = arrPieces[(indexPath as NSIndexPath).row]
        
        
        // if let typecourroies = listePieces["dimention"] as? String{
        //let taillecoirroies = listecourroies["type"] as? String
        
        
        //cell.textLabel?.text = typecourroies
        theLabelTitre.text = listePieces["noteTitle"] as? String
        theLabelContrat.text = listePieces["nomContrat"] as? String
        nomInstal.text = listePieces["nomInstal"] as? String
        theLabelBati.text = listePieces["nomBati"] as? String
       // textview.text = listePieces["noteText"] as? String
        
        let imageAsset: CKAsset = listePieces.value(forKey: "noteImage") as! CKAsset
        imageView.image = UIImage(contentsOfFile: imageAsset.fileURL.path)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        
        
        if ((listePieces.value(forKeyPath: "EtatComande") as? integer_t) != 1)
            
        {
            switchDemo.setOn(false, animated: true)
            
        }
            
        else
        {
            switchDemo .setOn(true, animated: true)
        }
        
       
        
        return cell
    }
    
    
   // MARK: - SWITCH BOUTON
    
    func switchCommande(_ sender: UISwitch)
    {
        
        let switchh = sender
    
        if (sender.isOn == true){
            
            print(sender.tag)
            
            
            let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
            let publicDB = monContainaire.publicCloudDatabase
            let switchAction: CKRecord = self.arrPieces[switchh.tag]
            let etat = "en commande"
            
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
            
            
            let switchAction: CKRecord = self.arrPieces[switchh.tag]
            let etats = "en Stock"
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
                    
                    //alertCommande()
                })
            })
            
            
        }
        
        
    }
    
    
    
    
      // MARK: - FETCH PIECES DETACHÉES
    
    func fetchNotes()
    {
        
        
       // viewWait.isHidden = false
       // view.bringSubview(toFront: viewWait)
        
        
        
        let container = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
        let publicDatabase = container.publicCloudDatabase
        
        
        let number = nomBatiment.text;
        
        
        /*  ////////   PREDICATE PAR NOM CONTRAT @objc BATI ET INSTAL !!!!!!!!!!!!  /////////
         
         let predicate = NSPredicate(format: "nomBati = %@ AND nomInstal = %@ AND nomContrat == %@ AND Etat == %@ ", argumentArray: [nomBatisegu, instalsegu,contratsegu,number])
        */
        
        let predicate = NSPredicate (format: "nomBati == %@ ",number!)
        
        
        let query = CKQuery(recordType: "Notes", predicate: predicate)
        
          query.sortDescriptors = [NSSortDescriptor(key: "nomInstal", ascending: false)]
        
        publicDatabase.perform(query, inZoneWith: nil) { (results, error) -> Void in
            
            if let contratRecup = results {
                self.arrPieces = contratRecup
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.tblPieces.reloadData()
                 self.refresh.endRefreshing()
                    
                    self.tblPieces.isHidden = false
                    //self.viewWait.isHidden = true
                    
                    print(self.arrPieces)
                })
            }
            else {
                print("erreur de chargement des notes")
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

  // MARK: - ALERT VIEW COMMANDE PIECES
/*
func alertCommande ()
{
    let alertCommandePieces = UIAlertController(title: "Pièces commandé", message: "Vous venez de réceptionner une pièces détachée ", preferredStyle: .alert)
    let okaction = UIAlertAction(title: "ok", style: .default, handler: nil)
    alertCommandePieces.addAction(okaction)
   
     present(alertCommandePieces, animated: true, completion: nil)
    
    
    
    
    
}
*/
