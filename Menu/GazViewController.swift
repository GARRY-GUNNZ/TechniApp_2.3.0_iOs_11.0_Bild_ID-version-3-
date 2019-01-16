//
//  GazViewController.swift
//  TechniApp
//
//  Created by TechniApp on 31/12/2018.
//  Copyright © 2018 COFELY_Technibook. All rights reserved.
//

import UIKit

class GazViewController: UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    
    
    @IBOutlet var pickerGaz: UIPickerView!
    @IBOutlet var boutongaz: DesignableButton!
    @IBOutlet var textfiledGaz: UITextField!
    @IBOutlet var segmendGaz: UISegmentedControl!
    @IBOutlet weak var tblPieces: UITableView!
    @IBOutlet weak var viewWait: UIView!
    var arrayGaz: Array<CKRecord> = []
    var choixContrats : Array<CKRecord> = []
    var refresh:UIRefreshControl!
    var  etatCommade : Int!
    
    //   MARK: Action Picker
    @IBAction func selectPressed(_ sender: UIButton) {
        pickerGaz.isHidden = false
        
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
        boutongaz.setTitle((listePieces["content"] as? String), for: .normal)
        textfiledGaz.text = (listePieces["content"] as? String)
        pickerView.isHidden = false
        listeGaz()
        print( arrayGaz)
        
    }
    
    
    //   MARK: Fetch Contrats
    
    
    @objc func listeGaz ()
    {
       self.viewWait.isHidden = false
       // view.bringSubview(toFront: viewWaitFitre)
        arrayGaz = [CKRecord]()
        let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
        let privateData = monContainaire.publicCloudDatabase
        //  let customZone = CKRecordZone(zoneName: "Contrats")
        
        let etat = "En stock"
        let cont = textfiledGaz.text
        
        let predicate = NSPredicate (format: "(Etat == %@) AND (nomContrat == %@)",etat,cont!)
        /*(arrNotes as NSArray).filteredArrayUsingPredicate()*/
        // let predicate = NSPredicate (format: "nomBati == %@ ",nomBatisegu )
        // NSPredicate predicate = nil;
        // let predicate = NSPredicate (format: "Etat == %@ ",number)
        
        let query = CKQuery(recordType: "Gaz", predicate: predicate)
       // query.sortDescriptors = [NSSortDescriptor(key: "nomBati", ascending: true)]
        
        
        
        
        privateData.perform(query, inZoneWith:nil) {
            (results, error) -> Void in
            
            if let contratRecup = results {
                self.arrayGaz = contratRecup
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    // self.pickerView.reloadData()
                   self.tblPieces.reloadData()
                    self.tblPieces.isHidden = false
                    //self.refresh.endRefreshing()
                   self.viewWait.isHidden = true
                })
            } else {
                print(self.description)
            }            }     }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerGaz.dataSource = self
        pickerGaz.delegate = self
        pickerGaz.isHidden = true
        
        /////  refresh button
        //   refresh = UIRefreshControl()
        //  refresh.attributedTitle = NSAttributedString(string: "Chargement les filtres à commander")
        //   refresh.addTarget(self, action:#selector(CommandeFiltreTableViewController.fetchNotes), for: .valueChanged)
        //  self.tblPieces.addSubview(refresh)
        
        
        
        contratData()
        // Do any additional setup after loading the view.
    }
    

     func contratData ()
    {
      self.viewWait.isHidden = false
        //view.bringSubview(toFront: viewWait)
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
                    
                    // self.pickerGaz.reloadData()
                    self.pickerGaz.reloadAllComponents()
                    //self.refresh.endRefreshing()
                   self.viewWait.isHidden = true
                    
                   // self.listeGaz ()
                })
            }
        }     }
    
    
    // MARK: - TABLEVIEW
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Liste des gaz frigorifique"
    }
    /*
     override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
     cell.alpha = 0
     let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
     cell.layer.transform = transform
     
     UIView.animate(withDuration: 0.4) {
     cell.alpha = 1
     // cell.layer.transform = CATransform3DIdentity
     }
     }
     */
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayGaz.count
        print(arrayGaz.count)
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if arrayGaz.count == 0 {
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
        
        //let theLabelTitre : UILabel  = self.view.viewWithTag(6) as! UILabel
        let theLabelInstal : UILabel  = self.view.viewWithTag(2) as! UILabel
        //let theLabelContrat : UILabel  = self.view.viewWithTag(3) as! UILabel
       // let imageView : UIImageView  = self.view.viewWithTag(1) as! UIImageView
        let theLabelBati : UILabel  = self.view.viewWithTag(3) as! UILabel
       // let textview : UITextView  = self.view.viewWithTag(8) as! UITextView
        let theLabelDate : UILabel  = self.view.viewWithTag(10) as! UILabel
      //  let thetextfieldMarque : UITextField = self.view.viewWithTag(11) as! UITextField
        let thetextfieldtypedegaz : UILabel = self.view.viewWithTag(12) as! UILabel
        let quantité : UILabel = self.view.viewWithTag(13) as! UILabel
        
        
        
        let listePieces = arrayGaz[(indexPath as NSIndexPath).row]
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy, hh:mm"
       theLabelDate.text = dateFormatter.string(from: listePieces.value(forKey: "date") as! Date)
        
         quantité.text = listePieces["quantite"]as? String
        theLabelInstal.text = listePieces["nomInstal"] as? String
        theLabelBati.text = listePieces["nomBati"] as? String
      
       // thetextfieldMarque.text = listePieces["marque"]as? String
        thetextfieldtypedegaz.text = listePieces["typeGaz"] as? String
        
        
       /* format date et type de gaz
        
        typeGaz.text = [NSString stringWithFormat:@"%@ | %@ Kg",
            instalations[@"typeGaz"], instalations[@"quantite"]];
        
        dateControl.text=[[self sessionDateFormatter] stringFromDate:instalations[@"date"]];
        
        */
        
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
            let switchAction: CKRecord = self.arrayGaz[switchh.tag]
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
            let switchAction: CKRecord = self.arrayGaz[switchh.tag]
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
                   // self.listeGaz()
                    // self.tblPieces.reloadData()
                  //  self.alertReception()
                })})}}
    
    
    
    
    
    

}
