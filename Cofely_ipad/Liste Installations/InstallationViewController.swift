//
//  InstallationViewController.swift
//  TechniApp
//
//  Created by COFELY_Technibook on 02/03/2018.
//  Copyright © 2018 COFELY_Technibook. All rights reserved.
//

import UIKit
import CloudKit
import QuartzCore


class InstallationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var listeInstallations: Array<CKRecord> = []
    var envoiLenomDuContra = String()
    var envoieLenomDuBatiment = String ()
    var recupInstal = String ()
    var recuMarque = String ()
    var recuReference = String ()
    var refresh : UIRefreshControl!
    var imageURL: URL!
    var record: CKRecord!
    var envoiImage = UIImage ()
    
    
    @IBOutlet var avatarBatiment: UIImageView!
    @IBOutlet var nomContrat: UILabel!
    @IBOutlet var tableInstallations: UITableView!
    @IBOutlet var nomBatiment: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableInstallations.delegate = self
        tableInstallations.dataSource = self
        nomBatiment.text! = envoieLenomDuBatiment
        nomContrat.text! = envoiLenomDuContra
        
// MARK: Integration image Batiment
        avatarBatiment.image? = envoiImage
        
             // print("liste des batiment",self.listeInstallations)
        
        
        // MARK:refresch Control TABLEVIEW
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Chargement Installations")
        refresh.addTarget(self, action:#selector(InstallationViewController.loadData), for: .valueChanged)
        self.tableInstallations.addSubview(refresh)
        loadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("problème memoire dans le menu installation")
        print(self.description)
    }
    
    // MARK: - TableView Protocol
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listeInstallations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellInstal") as! CellInstalTableViewCell
        if listeInstallations.count == 0 {
            return cell
        }
        
        let Instal = listeInstallations[(indexPath as NSIndexPath).row]
        
        cell.nomInsalLabel.text = Instal.value(forKey: "nomInstal") as? String
       
        cell.marqueLabel?.text = Instal.value(forKey: "marque") as? String
       
        
        let imageAsset: CKAsset = Instal.value(forKey: "avatarInstal") as! CKAsset
        cell.imageCellBatiment.image = UIImage(contentsOfFile: imageAsset.fileURL.path)
        //cell.imageCellBatiment.contentMode = UIViewContentMode.redraw
        
        cell.imageCellBatiment.layer.cornerRadius = 8
        cell.imageCellBatiment.layer.shadowRadius = 4.0
        cell.imageCellBatiment.layer.masksToBounds = true
        
        //cell.imageCellBatiment .layer.borderColor = .black as? CGColor
        cell.imageCellBatiment.layer.borderWidth = 0.5
       
        return cell
    }
    
    
    func tableView (_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
        
    {
        
        print("la fonction est lancer ")
        
        
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            let selectedRecordID = listeInstallations[(indexPath as NSIndexPath).row].recordID
            
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
                                self.listeInstallations.remove(at: (indexPath as NSIndexPath).row)
                                tableView.deleteRows(at: [indexPath], with: .automatic)
                        })
                    }
            })
        }
        
        print("la fonction est fini")
        
    }
    
    
    
    // MARK: - Custum TableView Installation
    
    /*
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
    */
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        let label = "🏢 Bâtiments : \(nomBatiment.text!)"
        
        //label.size = 20.0
        return label
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 50.0;
    }
    
    
     // MARK: - Fetch Installations
    
    @objc func loadData ()
    {
        // self.viewWait.isHidden = false
        //view.bringSubview(toFront: viewWait)
        
        listeInstallations = [CKRecord]()
        
        
        
        let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
        
        let privateData = monContainaire.publicCloudDatabase
        /*
        let number = envoiLenomDuContra
        
        let predicate = NSPredicate(format: " Contrat == %@",number)
        
        let query = CKQuery(recordType: "Installation", predicate: predicate)
        
        //  let customZone = CKRecordZone(zoneName: "Contrats")
        
        //  let query = CKQuery(recordType: "Installation",
        // predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        
        query.sortDescriptors = [NSSortDescriptor(key: "nomBatiment", ascending: true)]
        */
        let nomBatiment = envoieLenomDuBatiment
        let cont =  nomContrat.text!
        
         ////////   PREDICATE PAR NOM CONTRAT @objc BATI ET INSTAL !!!!!!!!!!!!  /////////
         
         let predicate = NSPredicate(format: "nomBatiment == %@ AND Contrat == %@ ", argumentArray: [nomBatiment,cont])
 
      
        
        
        let query = CKQuery(recordType: "Installation", predicate: predicate)
        
        query.sortDescriptors = [NSSortDescriptor(key: "nomInstal", ascending: true)]
        
        
        privateData.perform(query, inZoneWith:nil) {
            (results, error) -> Void in
            
            if let contratRecup = results {
                self.listeInstallations = contratRecup
                
                // contratPass = mesContrats(value(forKey: "nomDuContrat")as? String)
                
                
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.tableInstallations.reloadData()
                    
                    self.refresh.endRefreshing()
                    
                    
                    // self.viewWait.isHidden = true
                })
            }
        }     }
    
    
    
    
    
    // MARK: - Navigation
    
 override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        ////////////////////////////////////////////////////////////
        
        let  indexPa = tableInstallations.indexPath(for: sender as! UITableViewCell)
        let Instal = listeInstallations[(indexPa! as NSIndexPath).row]
        
            if segue.identifier == "ShowDetail"
               
            {
                    let vudetailsPiecesDetache = segue.destination as? DetailViewController
           
            vudetailsPiecesDetache?.envoiLenomDuContra = envoiLenomDuContra;
         // vudetailsPiecesDetache?.envoieLenomDuBatiment = envoieLenomDuBatiment
            vudetailsPiecesDetache?.envoiMarque = Instal.value(forKey: "marque") as? String
            vudetailsPiecesDetache?.envoiReference = Instal.value(forKey: "reference") as? String
            vudetailsPiecesDetache?.envoiLeInstal = Instal.value(forKey: "nomInstal") as? String
            vudetailsPiecesDetache?.envoieLenomDuBatiment = Instal.value(forKey: "nomBatiment") as? String
                
            //    let path = tableInstallations.indexPathForSelectedRow
               // let cell = tableInstallations.cellForRow(at: path!)
               // let Instal = listeInstallations[(indexPath as NSIndexPath).row]
            
                
                // vudetailsPiecesDetache?.envoiMarque = recuMarque
                // vudetailsPiecesDetache?.envoiReference = recuReference
              
              //  vudetailsPiecesDetache?.envoiReference =
              //  vudetailsPiecesDetache?.envoiLenomDuContra =
               
                
                
                let imageAsset: CKAsset = Instal.value(forKey: "avatarInstal") as! CKAsset
                
                vudetailsPiecesDetache?.envoieImage = UIImage(contentsOfFile: imageAsset.fileURL.path)!
               
                
                
            }
 
        /////////////////////////////////////////////////////////////////////////////////
        
        
        /// vu detail a coder
        
        
        if segue.identifier == "addInstal"
        {
            
            if
                let ajouterInstal = segue.destination as? AddInstallationViewController
                
            {
                
                  ajouterInstal.viaSegue = envoiLenomDuContra
                  ajouterInstal.segueBati = envoieLenomDuBatiment
            }
            
        }
        
        if segue.identifier == "Showpiecedetache"
        {
            
            if
                let vuListePiecesDetache = segue.destination as? DetailPieceDetache
                
            {
              
                 vuListePiecesDetache.contratsegu = envoiLenomDuContra
                 vuListePiecesDetache.nomBatisegu = envoieLenomDuBatiment
                
            }
            
        }
        
    }
    
    
        
        
}
