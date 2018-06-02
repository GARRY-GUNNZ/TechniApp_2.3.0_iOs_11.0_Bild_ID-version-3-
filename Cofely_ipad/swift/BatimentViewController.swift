//
//  BatimentViewController.swift
//  TechniApp
//
//  Created by Gаггу-Guииz  on 02/06/2018.
//  Copyright © 2018 COFELY_Technibook. All rights reserved.
//


    import UIKit
    import CloudKit
    import QuartzCore
    
    
    
    class BatimentViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
        
        
        //@IBOutlet weak var nomContrat: UILabel!
        @IBOutlet weak var tableBatiments: UITableView!
        
        var listeBatiments = [CKRecord]()
        var refresh:UIRefreshControl!
        var numeroContat = String ()
        var envoiLenomDuContrat = String ()
        
        
        
        @IBOutlet weak var ajouterBatiment: UIBarButtonItem!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            //  print("liste des batiment",self.listeBatiments)
            
            tableBatiments.dataSource = self
            tableBatiments.delegate = self
            
            refresh = UIRefreshControl()
            refresh.attributedTitle = NSAttributedString(string: "Chargement Contrats")
            refresh.addTarget(self, action:#selector(BatimentViewController.loadData), for: .valueChanged)
            self.tableBatiments.addSubview(refresh)
            
            
            loadData()
            
            // Do any additional setup after loading the view.
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            print("problème memoire dans le menu batiment")
            print(self.description)
        }
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listeBatiments.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            if listeBatiments.count == 0 {
                return cell
            }
            
            
            
            let listeBati = listeBatiments[(indexPath as NSIndexPath).row]
            
            
            
            cell.textLabel?.text = listeBati.value(forKey: "nomBatiment") as? String
            
            cell.detailTextLabel?.text =  listeBati.value(forKey: "numberContrat") as? String
            
           
            
         //   cell.detailTextLabel?.text = listeBati.value(forKey: "numberContrat") as? String
            
           // numeroContat = (listeBati.value(forKey: "numberContrat") as? String)!
           // envoiLenomDuContrat = (listeBati.value(forKey: "nomBatiment") as? String)!
            
            return cell
            
        }
        
        func tableView (_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
            
        {
            
            print("la fonction est lancer ")
            
            
            if editingStyle == UITableViewCellEditingStyle.delete
            {
                let selectedRecordID = listeBatiments[(indexPath as NSIndexPath).row].recordID
                
                // print(selectedRecordID)
                
                let container = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
                
                let privateDatabase = container.publicCloudDatabase
                
                privateDatabase.delete(withRecordID: selectedRecordID, completionHandler:
                    { (recordID, error) -> Void in
                        if error != nil
                        {
                            print("error de suppression")
                        }
                        else
                        {
                            OperationQueue.main.addOperation(
                                { () -> Void in
                                    self.listeBatiments.remove(at: (indexPath as NSIndexPath).row)
                                    tableView.deleteRows(at: [indexPath], with: .automatic)
                            })
                        }
                })
            }
            
           // print("la fonction est fini")
            
        }
        //   MARK: - TABLEVIEW Animations
        
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.alpha = 0
            let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 30, 0)
            cell.layer.transform = transform
            
            UIView.animate(withDuration: 0.5) {
                cell.alpha = 1
                cell.layer.transform = CATransform3DIdentity
            }
        }
        
        // MARK: - Custum TableView Batiment
        
        func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
            
        {
            view.tintColor = UIColor(patternImage: UIImage(named: "IMG_0028.jpg")!)
            view.contentMode = UIViewContentMode.scaleAspectFit
            
            // view.tintColor = UIColor(red:242/255, green: 248/255, blue: 252/255, alpha: 1.5)
            // this example is a light blue, but of course it also works with
            //UIColor.lightGrayColor
            let header : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            
            header.textLabel?.textColor = UIColor.black
            header.textLabel?.font = UIFont .systemFont(ofSize: 45)
            //[header.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:35]];
        }
        
        
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
        {
            
            // NSString * titreHeader = [[NSString alloc]initWithFormat: @"🏢  Bâtiment  %@  ",_nomContrat.text];
            
            
            // "   %@  ", envoiLenomDuContrat]
            
            let label = "🏢  Bâtiments \(envoiLenomDuContrat)"
            //label.size = 20.0
            return label
            
        }
        
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
        {
            return 160.0;
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        @objc func loadData ()
        {
            // self.viewWait.isHidden = false
            //view.bringSubview(toFront: viewWait)
            
            listeBatiments = [CKRecord]()
            
            
            
            let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
            
            let privateData = monContainaire.publicCloudDatabase
            
            let number = envoiLenomDuContrat
            
            let predicate = NSPredicate(format: " nomContrats == %@",number)
            
            let query = CKQuery(recordType: "Batiment", predicate: predicate)
            
            //  let customZone = CKRecordZone(zoneName: "Contrats")
            
            //  let query = CKQuery(recordType: "Batiment",
            // predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
            
            query.sortDescriptors = [NSSortDescriptor(key: "nomBatiment", ascending: true)]
            
            
            
            privateData.perform(query, inZoneWith:nil) {
                (results, error) -> Void in
                
                if let contratRecup = results {
                    self.listeBatiments = contratRecup
                    
                    // contratPass = mesContrats(value(forKey: "nomDuContrat")as? String)
                    
                    
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        
                        self.tableBatiments.reloadData()
                        
                        self.refresh.endRefreshing()
                        
                        
                        // self.viewWait.isHidden = true
                    })
                }
            }     }
        
        
        
        
        
        
        
        
        
        // MARK: - Navigation
 
 override func prepare(for segue: UIStoryboardSegue, sender: Any?)
 {
 
 
 if segue.identifier == "ShowInstal"
 {
 
 if
 let destination = segue.destination as? InstallationViewController
 
 {
 
    let path = tableBatiments.indexPathForSelectedRow
    _ = tableBatiments.cellForRow(at: path!)
    let bati = listeBatiments[(path! as NSIndexPath).row]
 
 destination.envoiLenomDuContra = envoiLenomDuContrat
 destination.envoieLenomDuBatiment = (bati.value(forKey: "nomBatiment") as? String)!
 

    let imageAsset: CKAsset = ((bati.value(forKey: "xavatarBati") as? CKAsset))!
 
 
 
 destination.envoiImage = (UIImage(contentsOfFile: imageAsset.fileURL.path))!
 
 }
 
 }
 
 //// add info contrat a codé

 /*
 if segue.identifier == "addInfo"
 {
 
 if
 let addInfo = segue.destination as? AddInfoViewController
 
 {
 
 addInfo.envoiLenomDuContra = envoiLenomDuContrat
 addInfo.envoieLenumeroContrat = numeroContat
 
 }
 
 }
 */
 /*        ///// Créé un addBatiment View controlleur en Swift ////////////// */
 
 
 if segue.identifier == "addBati"
 {
 
 if
 let addInfo = segue.destination as? AddBatiments
 
 {
    
 
 
    addInfo.ViaSegue = envoiLenomDuContrat
    
// addInfo.envoiLenomDuContra = envoiLenomDuContrat
// addInfo.envoieLenumeroContrat = numeroContat
 
 
 
 }
 
 
 
 }
 
        }
 
        
}

