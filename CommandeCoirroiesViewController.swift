//
//  CommandeCoirroiesViewController.swift
//  TechniApp
//
//  Created by Gаггу-Guииz  on 23/11/2016.
//  Copyright © 2016 COFELY_Technibook. All rights reserved.
//

import UIKit
import CloudKit


class CommandeCoirroiesViewController: UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    //   MARK: - OUTLET
   
    @IBOutlet weak var texFieldContrat: UITextField!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var viewWaitCourroies: UIView!
    
    @IBOutlet weak var tblCourroies: UITableView!
    
       // MARK: - VARRIABLE
     var choixContrats : Array<CKRecord> = []
     var arrCourroies: Array<CKRecord> = []
     var refresh:UIRefreshControl!
     var  etatCommade : Int!
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
        pickerView.isHidden = false
       
        fetchNotes()
    }
    
    
    //   MARK: Fetch Contrats
    
    
    @objc func ContratData ()
    {
        self.viewWaitCourroies.isHidden = false
        view.bringSubview(toFront: viewWaitCourroies)
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
                    self.viewWaitCourroies.isHidden = true
                })
            }
        }     }

    
    
    
    
  //   MARK: - LIFE VIEW
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.isHidden = true
        
        /////  refresh button
        //   refresh = UIRefreshControl()
        //  refresh.attributedTitle = NSAttributedString(string: "Chargement les filtres à commander")
        //   refresh.addTarget(self, action:#selector(CommandeFiltreTableViewController.fetchNotes), for: .valueChanged)
        //  self.tblPieces.addSubview(refresh)
        
        
        
        ContratData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //   MARK: - TABLEVIEW CUSTOMISATION animation
    /*
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform
        
        UIView.animate(withDuration: 1) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
    }
 */
    
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
        
        if arrCourroies.count == 0 {
            return cell
        }
        
        let switchDemo = UISwitch ()
        
        switchDemo.center = CGPoint(x: 800, y: 50)
        switchDemo.isOn = true
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
         let quantiteCourroies : UILabel  = self.view.viewWithTag(6) as! UILabel
        
        
       
        
        let listecourroies = arrCourroies[(indexPath as NSIndexPath).row]
        
        
         //let typecourroies = listecourroies["dimention"] as? String{
       
            theLabeldim.text = listecourroies["dimention"] as? String
            theLabeltype.text = listecourroies["type"] as? String
            theLabelContrat.text = listecourroies["nomContrat"] as? String
            theLabelInstal.text = listecourroies["nomInstal"] as? String
            theLabelBati.text = listecourroies["nomBati"] as? String
            quantiteCourroies.text = listecourroies["quantite"] as? String
           
            
            if ((listecourroies.value(forKeyPath: "EtatComande") as? integer_t) != 1)
                
            {
                switchDemo.setOn(false, animated: true)
                
            }
                
            else
            {
                switchDemo .setOn(true, animated: true)
            }
            
            
            return cell
        }
    
 
    
    @objc func switchCommande(_ sender: UISwitch)
    {
        let switchh = sender
        if (sender.isOn == true){
            
            print(sender.tag)

            let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
            let publicDB = monContainaire.publicCloudDatabase
            let switchAction: CKRecord = self.arrCourroies[switchh.tag]
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
            
            print(sender.tag)
            let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
            let publicDB = monContainaire.publicCloudDatabase
            let switchAction: CKRecord = self.arrCourroies[switchh.tag]
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
                     self.alertReception()
                })
            })
            
            
        }
        
        
    }

    func alertReception ()
    {
        
        let alert = UIAlertController(title: "Courroies Réceptionnées", message: "Vous venez de réceptionner une référence de courroie ", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(okaction)
        self.present(alert, animated: true, completion: nil)
        
        
        
        
    }


      //   MARK: - CLOUDKITFETCH
    
    @objc func fetchNotes() {
        
        
        viewWaitCourroies.isHidden = false
        
        view.bringSubview(toFront: viewWaitCourroies)
        
        let container = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
        let publicDatabase = container.publicCloudDatabase
       
        //etatCommade = 1
        let etatCommande = 1
        let filtreContrat = texFieldContrat!.text
        let fitreFetch = NSPredicate (format: "(EtatComande == %d) AND (nomContrat == %@)",etatCommande,filtreContrat!)
     
        
        
       // let predicat = NSPredicate (format: "Etat == %@ ", etatCommande)
      
        let query = CKQuery(recordType: "Courroies", predicate: fitreFetch)
        
         query.sortDescriptors = [NSSortDescriptor(key: "nomBati", ascending: true)]
        
        
        
        publicDatabase.perform(query, inZoneWith: nil) { (results, error) -> Void in
            
            if let contratRecup = results {
                self.arrCourroies = contratRecup
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.tblCourroies.reloadData()
                   // self.refresh.endRefreshing()
                    
                    self.tblCourroies.isHidden = false
                    self.viewWaitCourroies.isHidden = true
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
