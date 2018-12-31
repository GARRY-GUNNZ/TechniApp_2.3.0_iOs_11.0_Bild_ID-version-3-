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
    var arrFiltre: Array<CKRecord> = []
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
       // fetchNotes()
    }
    
    
    //   MARK: Fetch Contrats
    
    
    @objc func ContratData ()
    {
       // self.viewWaitFitre.isHidden = false
       // view.bringSubview(toFront: viewWaitFitre)
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
                    self.pickerGaz.reloadAllComponents()
                    //self.refresh.endRefreshing()
                   // self.viewWaitFitre.isHidden = true
                })
            }
        }     }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

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
        
        
        
        ContratData()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
