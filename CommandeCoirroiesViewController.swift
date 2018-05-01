//
//  CommandeCoirroiesViewController.swift
//  TechniApp
//
//  Created by Gаггу-Guииz  on 23/11/2016.
//  Copyright © 2016 COFELY_Technibook. All rights reserved.
//

import UIKit
import CloudKit


class CommandeCoirroiesViewController: UITableViewController {
    
       // MARK: - OUTLET
    
    @IBOutlet weak var tblCourroies: UITableView!
    
       // MARK: - VARRIABLE
    
    var arrCourroies: Array<CKRecord> = []
    var refresh:UIRefreshControl!
    
    
  //   MARK: - LIFE VIEW
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /////  refresh button
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Chargement Courroies")
        refresh.addTarget(self, action:#selector(CommandeCoirroiesViewController.fetchNotes), for: .valueChanged)
        self.tblCourroies.addSubview(refresh)
 
        fetchNotes()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //   MARK: - TABLEVIEW CUSTOMISATION
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform
        
        UIView.animate(withDuration: 1) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Commande des Courroies"
    }
   
    
      //   MARK: - TABLEVIEW
    ///////////////////////////////////////////////////////////////
     override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    ////////////////////////////////////////////////////////////////
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrCourroies.count
    }
    
    //////////////////////////////////////////////////
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let switchDemo = UISwitch ()
        
        switchDemo.center = CGPoint(x: 800, y: 50)
        //switchDemo.isOn = true
        switchDemo.onTintColor = UIColor .brown
        //  switchDemo.setOn(true, animated: false)
        switchDemo.tag = indexPath.row;
        
        
        //cell.addSubview(switchDemo)
         cell.accessoryView = (switchDemo)
        
        ////// action switch

        switchDemo.addTarget(self, action: #selector(CommandeCoirroiesViewController.switchCommande(_:)), for:.valueChanged )
 
        
       
         let theLabeltype : UILabel  = self.view.viewWithTag(1) as! UILabel
         let theLabeldim : UILabel  = self.view.viewWithTag(2) as! UILabel
         let theLabelContrat : UILabel  = self.view.viewWithTag(3) as! UILabel
         let theLabelInstal : UILabel  = self.view.viewWithTag(4) as! UILabel
         let theLabelBati : UILabel  = self.view.viewWithTag(5) as! UILabel
        
        
        
        if arrCourroies.count == 0 {
            return cell
        }
        
        let listecourroies = arrCourroies[(indexPath as NSIndexPath).row]
        
        
        if let typecourroies = listecourroies["dimention"] as? String{
        //let taillecoirroies = listecourroies["type"] as? String
            
            
            theLabeldim.text = typecourroies
             theLabeltype.text = listecourroies["type"] as? String
            theLabelContrat.text = listecourroies["nomContrat"] as? String
            theLabelInstal.text = listecourroies["nomInstal"] as? String
            theLabelBati.text = listecourroies["nomBati"] as? String

           // cell.detailTextLabel?.text = listecourroies["type"] as? String
            
            
        }
        
        return cell
    }
 
    
    @objc func switchCommande(_ sender: UISwitch)
    {
        
        let switchh = sender
        
        
        
        if (sender.isOn == false){
            
            print(sender.tag)
            
            
            
            
            let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
            
            let publicDB = monContainaire.publicCloudDatabase
            
            let switchAction: CKRecord = self.arrCourroies[switchh.tag]
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
            
            let publicDB = CKContainer.default().publicCloudDatabase
            let switchAction: CKRecord = self.arrCourroies[switchh.tag]
            let etats = "En stock"
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
                    
                    self.alertReception()
                })
            })
            
            
        }
        
        
    }

    func alertReception ()
    {
        let alertView = UIAlertView();
        alertView.addButton(withTitle: "ok")
        // alertView.addButtonWithTitle("Ok");
        alertView.title = "Courroies Réceptionnées";
        alertView.message = "Vous venez de réceptionner une référence de courroie ";
        alertView.show();
    }


      //   MARK: - CLOUDKITFETCH
    
    @objc func fetchNotes() {
        
        
     
        
        let container = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
        
    
        
        
        let publicDatabase = container.publicCloudDatabase
        //let predicate = NSPredicate(value: true)
        
        let etatCommande = "A commander"
       
      let predicat = NSPredicate (format: "Etat == %@ ", etatCommande)
        
        
       
        
        let query = CKQuery(recordType: "Courroies", predicate: predicat)
        
         query.sortDescriptors = [NSSortDescriptor(key: "nomBati", ascending: true)]
        
        
        
        publicDatabase.perform(query, inZoneWith: nil) { (results, error) -> Void in
            
            if let contratRecup = results {
                self.arrCourroies = contratRecup
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.tblCourroies.reloadData()
                    self.refresh.endRefreshing()
                    
                    self.tblCourroies.isHidden = false
                })
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