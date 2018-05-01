//
//  PiecesDetacheeTableViewController.swift
//  TechniApp
//
//  Created by Gаггу-Guииz  on 27/11/2016.
//  Copyright © 2016 COFELY_Technibook. All rights reserved.
//

import UIKit
import CloudKit


class PiecesDetacheeTableViewController: UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource {
   //   MARK: - OUTLET
    @IBOutlet weak var texFieldContrat: UITextField!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var viewWait: UIView!
    @IBOutlet weak var tblPieces: UITableView!
    
    //   MARK: - VARRIABLE
    
    var arrPieces: Array<CKRecord> = []
    var refresh:UIRefreshControl!
    var choixContrats : Array<CKRecord> = []
    
       //   MARK: PICKERVIEW Methode
    
    
    //   MARK: Action Picker
    @IBAction func selectPressed(_ sender: UIButton) {
        pickerView.isHidden = false
        
    }
     //   MARK: DataSource - Picker
    
   
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
   
 
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return choixContrats.count
        
}
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      
        
        
        
        let listePieces = choixContrats[row]
       return (listePieces["content"] as? String)
       
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let listePieces = choixContrats[row]
       selectButton.setTitle((listePieces["content"] as? String), for: .normal)
        texFieldContrat.text = (listePieces["content"] as? String)
           pickerView.isHidden = true
        fetchNotes()
 }
    
    
    
    
    
    
    
        
     //   MARK: - LIFE VIEW
override func viewDidLoad() {
            super.viewDidLoad()
    
        pickerView.dataSource = self
        pickerView.delegate = self
    
         pickerView.isHidden = true
         // texFieldContrat.inputView = pickerView
        //  texFieldContrat.placeholder = "Selecte Contrat"
            /*
            /////  refresh button
            refresh = UIRefreshControl()
            refresh.attributedTitle = NSAttributedString(string: "Chargement Pièces détachées")
            refresh.addTarget(self, action:#selector(PiecesDetacheeTableViewController.fetchNotes), for: .valueChanged)
            self.tblPieces.addSubview(refresh)
            */
           ContratData ()
    
            
            
            // Do any additional setup after loading the view.
        }
        
override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    //   MARK: Fetch Contrats
    
    
    @objc func ContratData ()
    {
        self.viewWait.isHidden = false
        view.bringSubview(toFront: viewWait)
        
        choixContrats = [CKRecord]()
       
        let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
        let privateData = monContainaire.privateCloudDatabase
  
        //  let customZone = CKRecordZone(zoneName: "Contrats")
        
        let query = CKQuery(recordType: "Contrats",
                            predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        
        query.sortDescriptors = [NSSortDescriptor(key: "content", ascending: false)]
      
        privateData.perform(query, inZoneWith:nil) {
            (results, error) -> Void in
            
            if let contratRecup = results {
                self.choixContrats = contratRecup
           
                DispatchQueue.main.async(execute: { () -> Void in
                
                   // self.pickerView.reloadData()
                    self.pickerView.reloadAllComponents()
                    //self.refresh.endRefreshing()
                    self.viewWait.isHidden = true
                })
            }
        }     }

    
   // MARK: - TABLEVIEW
    
override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Commande des Pièces détachées"
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform
        
        UIView.animate(withDuration: 0.4) {
            cell.alpha = 1
           // cell.layer.transform = CATransform3DIdentity
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
            
            return 1
        }
    
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return arrPieces.count
        }
 
    
    
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            if arrPieces.count == 0 {
                return cell
            }
            /// bouton a commander //////////////////////
            let switchDemo = UISwitch ()
         
            switchDemo.center = CGPoint(x: 930, y: 104)
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
            let theLabelInstal : UILabel  = self.view.viewWithTag(2) as! UILabel
            let theLabelContrat : UILabel  = self.view.viewWithTag(3) as! UILabel
            let imageView : UIImageView  = self.view.viewWithTag(1) as! UIImageView
            let theLabelBati : UILabel  = self.view.viewWithTag(5) as! UILabel
            let textview : UITextView  = self.view.viewWithTag(8) as! UITextView
            let theLabelDate : UILabel  = self.view.viewWithTag(10) as! UILabel
            let listePieces = arrPieces[(indexPath as NSIndexPath).row]
            let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMMM dd, yyyy, hh:mm"
                theLabelDate.text = dateFormatter.string(from: listePieces.value(forKey: "noteEditedDate") as! Date)
            let imageAsset: CKAsset = listePieces.value(forKey: "noteImage") as! CKAsset
                imageView.image = UIImage(contentsOfFile: imageAsset.fileURL.path)
                imageView.contentMode = UIViewContentMode.scaleAspectFit
                theLabelTitre.text = listePieces["noteTitle"] as? String
                theLabelContrat.text = listePieces["nomContrat"] as? String
                theLabelInstal.text = listePieces["nomInstal"] as? String
                theLabelBati.text = listePieces["nomBati"] as? String
                textview.text = listePieces["noteText"] as? String
 
             ////////////////////////////////
            
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
        
   
    
@objc func switchCommande(_ sender: UISwitch){
        
        let switchh = sender
        if (sender.isOn == true){
            
            //print(sender.tag)
            
            let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
            let publicDB = monContainaire.publicCloudDatabase
            let switchAction: CKRecord = self.arrPieces[switchh.tag]
            let etat = "en commande"
            switchAction.setValue(etat, forKey: "Etat")
            switchAction.setValue(1, forKey: "EtatComande")
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
            
          //  print(sender.tag)
            let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
            let publicDB = monContainaire.publicCloudDatabase
            let switchAction: CKRecord = self.arrPieces[switchh.tag]
            let etats = "en Stock"
            switchAction.setValue(etats, forKey: "Etat")
            switchAction.setValue(0, forKey: "EtatComande")
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
                     alertCommande()
                })})}}
    
    
    
   // MARK: - CLOUDKIT FETCH
    
    
    
    @objc func fetchNotes() {
            
            
            viewWait.isHidden = false
            view.bringSubview(toFront: viewWait)
            
        let container = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
        let publicDatabase = container.publicCloudDatabase
        //let predicate = NSPredicate(value: true)
        let number = "en commande"
        let cont = texFieldContrat!.text
        let predicate = NSPredicate (format: "(Etat == %@) AND (nomContrat == %@)",number,cont!)
            /*(arrNotes as NSArray).filteredArrayUsingPredicate()*/
            // let predicate = NSPredicate (format: "nomBati == %@ ",nomBatisegu )
            // NSPredicate predicate = nil;
           // let predicate = NSPredicate (format: "Etat == %@ ",number)
        
            let query = CKQuery(recordType: "Notes", predicate: predicate)
             query.sortDescriptors = [NSSortDescriptor(key: "nomBati", ascending: true)]
    
            publicDatabase.perform(query, inZoneWith: nil) { (results, error) -> Void in
                
                if let contratRecup = results {
                    self.arrPieces = contratRecup
                    DispatchQueue.main.async(execute: { () -> Void in

                         self.tblPieces.reloadData()
                       // self.refresh.endRefreshing()
                       
                        self.tblPieces.isHidden = false
                        self.viewWait.isHidden = true
                    })
                }
                else {
                    print("erreur de chargement des notes")
                }}}
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
}

