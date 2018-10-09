//
//  QuantiteGazViewController.swift
//  TechniApp
//
//  Created by COFELY_Technibook on 03/10/2018.
//  Copyright © 2018 COFELY_Technibook. All rights reserved.
//

import UIKit

class QuantiteGazViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
  
    
    @IBOutlet var contratPicker: UIPickerView!
    @IBOutlet var batimentPicker: UIPickerView!
    @IBOutlet var typeGazPicker: UIPickerView!
    @IBOutlet var contratTextField: UITextField!
    @IBOutlet var batimentTextfield: UITextField!
    @IBOutlet var typeGazTextfield: UITextField!
    @IBOutlet var bnContrat: UIButton!
    var choixContrats : Array<CKRecord> = []
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return choixContrats.count
    
    
    
    
 //   @IBAction func contratBn(_ sender: Any) {
  //  }
    
    
  //  @IBAction func batimentBn(_ sender: Any) {
  //  }
    
    
  //  @IBAction func typeGazBn(_ sender: Any) {
   // }
    
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contratPicker.dataSource = self
        contratPicker.delegate = self
        contratPicker.isHidden = true
        

        // Do any additional setup after loading the view.
        
        
     
            
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            
            
            
            
            let listePieces = choixContrats[row]
            return (listePieces["content"] as? String)
            
            
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
            let listePieces = choixContrats[row]
            bnContrat.setTitle((listePieces["content"] as? String), for: .normal)
            contratTextField.text = (listePieces["content"] as? String)
            pickerView.isHidden = false
            
            ContratData ()
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
func ContratData ()
    {
        /*
        self.viewWaitCourroies.isHidden = false
        view.bringSubview(toFront: viewWaitCourroies)
 */
       var choixContrats = [CKRecord]()
        
        
        let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
        let privateData = monContainaire.privateCloudDatabase
        //  let customZone = CKRecordZone(zoneName: "Contrats")
        let query = CKQuery(recordType: "Contrats",
                            predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        
        query.sortDescriptors = [NSSortDescriptor(key: "content", ascending: false)]
        
        privateData.perform(query, inZoneWith:nil) {
            (results, error) -> Void in
            
            if let contratRecup = results {
                choixContrats = contratRecup
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    // self.pickerView.reloadData()
                  //   self.contratPicker.reloadAllComponents()
                
                
                    //self.refresh.endRefreshing()
                    //self.viewWaitCourroies.isHidden = true
                })
            }
        }     }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


