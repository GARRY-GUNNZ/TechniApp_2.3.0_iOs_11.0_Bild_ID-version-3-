
//
//  ContratViewController.swift
//  TechniApp
//
//  Created by kerckweb on 20/08/2016.
//  Copyright © 2016 COFELY_Technibook. All rights reserved.
//

import UIKit
import CloudKit
import QuartzCore


class ContratViewController: UITableViewController , UITextFieldDelegate
{
    
       // MARK: - varriable
    
    let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    let tempImageName = "temp_image.jpg"
    var numeroContratPass = String ()
    var contratPass = String()
    var selectedNoteIndex: Int!
    var imageURL: URL!
    var refresh:UIRefreshControl!
    var mesContrats = [CKRecord]()
    //let thisApp = UIApplication.shared.delegate as! UIApplicationDelegate
        
        
        // MARK: - OUTLET
        
    @IBOutlet weak var infoUtilisateurs: UILabel!
    @IBOutlet weak var viewWait: UIView!
    @IBOutlet weak var tableviewContrat: UITableView!
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var addContrat: UIBarButtonItem!
    
   
       // MARK: - ACTION BOUTON ADD CONTRAT CLOUDKIT
    
    
    @IBAction func addContartButton(_ sender: AnyObject)
    {
        let alert = UIAlertController(  title: "Nouveau Contrat",
                                      message: "Entrer un nom de Contrat client que vous avez dans votre portefeuille ",
                               preferredStyle: .alert)
alert.addTextField
            {
                (textField:UITextField) -> Void in
                textField.placeholder = "Nom du Contrat"
        }
        
        alert.addAction(UIAlertAction(title: "Ajouter",style: .default,
                                      handler: {(action:UIAlertAction) -> Void in
                                        
                                        let textField = alert.textFields!.first!
                                        
                                        if textField.text != " " {
                                            
                                           // let privateDB = CKContainer.default().privateCloudDatabase
                                           let contrat = CKRecord(recordType: "Contrats")
                                            
                                            let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
                                            
                                            let privateData = monContainaire.privateCloudDatabase
                                            
                                            
                                            if let url = self.imageURL {
                                                let imageAsset = CKAsset(fileURL: url)
                                                contrat.setObject(imageAsset, forKey: "ContratImage")
                                            }
                                            else {
                                                let fileURL = Bundle.main.url(forResource: "images-3", withExtension: "jpeg")
                                                let imageAsset = CKAsset(fileURL: fileURL!)
                                                contrat.setObject(imageAsset, forKey: "ContratImage")
                                            }
                                            
                                            contrat["content"] = textField.text as CKRecordValue?
                                            contrat["nomDuContrat"] = textField.text as CKRecordValue?
                                            privateData.save(contrat, completionHandler: { (record, error) -> Void in
                                                
                                                if (error != nil) {
                                                    //print(error)
                                                }
                                                OperationQueue.main.addOperation({ () -> Void in
                                                    //self.viewWait.isHidden = true
                                                    self.navigationController?.setNavigationBarHidden(false, animated: true)
                                                })
                                            })
                                        }
                                        
        }))
        
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
       // MARK: -LIFE VIEW
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(false)
        
       
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableviewContrat.dataSource = self
        tableviewContrat.delegate = self
        
        /////  refresh button Tableview
        
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Chargement Contrats")
        refresh.addTarget(self, action:#selector(ContratViewController.loadData), for: .valueChanged)
        self.tableviewContrat.addSubview(refresh)
        loadData()
        
        
        
        
        
        
        
        
        
        
        ////// Boutton REVEAL MENU
        
        if revealViewController() != nil
        {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()

        
        print("probleme memoire dans le menu contrat")
        print(self.description)
    }
    //   MARK: - TABLEVIEW CUSTOMISATION
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 30, 0)
        cell.layer.transform = transform
        
        UIView.animate(withDuration: 0.4) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
    }
       // MARK: - Costumisation Setion Table view
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
        
    {
        view.tintColor = UIColor(patternImage: UIImage(named: "IMG_0028.jpg")!)
        // view.tintColor = UIColor(red:242/255, green: 248/255, blue: 252/255, alpha: 1.5)
        // this example is a light blue, but of course it also works with
        //UIColor.lightGrayColor
        let header : UITableViewHeaderFooterView = view as!
        UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont .systemFont(ofSize: 45)
        //[header.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:35]];
    }
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        let label = "💼  Mes Contrats "
        //label.size = 20.0
        return label
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 160.0;
    }
    
    
    /* TITRE ET LARGEUR SECTION TABLE VIEW
     
     func tableView( tableView : UITableView,  titleForHeaderInSection section: Int)->String
     {
     return "Contrats"
     
     }
     func tableView (tableView:UITableView , heightForHeaderInSection section:Int)->Float
     {
     
     return 200.0;
     }
     
     */
    
    
    
       // MARK: -  N O T I F I C A T I O N S
    
    @IBAction func executeCodeButtonClicked() {
        // Put the CloudKit private database in a constants
       // let publicDatabase = CKContainer.default().publicCloudDatabase
        
        let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
        
        let publicDatabase = monContainaire.publicCloudDatabase
        
        // Create subscription and set three of its properties (an id, a predicate, and options)
       
        
        let friendsSubscription = CKQuerySubscription (recordType: "Notes",
                                               predicate: NSPredicate(format: "TRUEPREDICATE"),
                                                 //subscriptionID: "abc1234",
            options: .firesOnRecordCreation)
        
 
        
    // let friendsSubscription = CKQuerySubscription (recordType: <#T##String#>, predicate: <#T##NSPredicate#>, options:
        // <#T##CKQuerySubscriptionOptions#>)
        
        
        
        
        
        // Create a notification and set two of its properties (alertBody and shouldBadge)
        let notificationInfo = CKNotificationInfo()
        notificationInfo.alertBody = "Une nouvelle pièce détachée vient d'être rajouté dans l'application TECHNIAPP"
        notificationInfo.shouldBadge = true
        // notificationInfo.alertLaunchImage = "common_bg.png"
        // Attach the notification to the subscription
        friendsSubscription.notificationInfo = notificationInfo
        
        // Save the subscription in the private database
        publicDatabase.save(friendsSubscription, completionHandler: {recordReturned, error in
            // On the main thread, display an error/success message in the textView
            if error != nil {
                OperationQueue.main.addOperation {
                    // self.textView.text = "Cloud error\n\(error.localizedDescription)"
                }
            } else {
                OperationQueue.main.addOperation {
                    //self.textView.text = "The subscription record was inserted in the private database."
                }
            }
        })
    }
    
    
    func resetBadgeCounter() {
        let badgeResetOperation = CKModifyBadgeOperation(badgeValue: 0)
        badgeResetOperation.modifyBadgeCompletionBlock = { (error) -> Void in
            if error != nil {
                // println("Error resetting badge: \(error)")
            }
            else {
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
        }
        CKContainer.default().add(badgeResetOperation)
    }
    
    /////////////////////////// FIN Notification ////////////////////////////////////////
    
  
       // MARK: - CLOUDKIT FETCH
    
    
    @objc func loadData ()
    {
        self.viewWait.isHidden = false
        view.bringSubview(toFront: viewWait)
        
        mesContrats = [CKRecord]()
        

        
        let monContainaire = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
        
        let privateData = monContainaire.privateCloudDatabase
        
        
        //  let customZone = CKRecordZone(zoneName: "Contrats")
        
        let query = CKQuery(recordType: "Contrats",
                            predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        
        query.sortDescriptors = [NSSortDescriptor(key: "content", ascending: false)]
        
        
        
        privateData.perform(query, inZoneWith:nil) {
            (results, error) -> Void in
            
            if let contratRecup = results {
                self.mesContrats = contratRecup
                
                // contratPass = mesContrats(value(forKey: "nomDuContrat")as? String)
                
                
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.tableviewContrat.reloadData()
                    
                    self.refresh.endRefreshing()
                    
                    
                    self.viewWait.isHidden = true
                })
            }
        }     }
    
    
    
   
    
    
    // MARK: - Table view data source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return mesContrats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if mesContrats.count == 0 {
            return cell
        }
        // let numeroContrat : UILabel  = self.view.viewWithTag(2) as! UILabel
        //  let nomContrat : UILabel  = self.view.viewWithTag(1) as! UILabel
        //  let imageView : UIImageView  = self.view.viewWithTag(3) as! UIImageView
        
        let contrat = mesContrats[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = contrat.value(forKey: "nomDuContrat") as? String
        cell.detailTextLabel?.text = contrat.value(forKey: "numeroContrat") as? String
        
        let imageAsset: CKAsset = contrat.value(forKey: "ContratImage") as! CKAsset
        cell.imageView?.image = UIImage(contentsOfFile: imageAsset.fileURL.path)
        cell.imageView?.contentMode = UIViewContentMode.redraw
        
        contratPass = (contrat.value(forKey: "nomDuContrat") as? String)!
        //numeroContratPass = (contrat.value(forKey: "numeroContrat") as? String)!
        
        // nomContrat.text = contrat.value(forKey: "nomDuContrat") as? String
        // numeroContrat.text = contrat.value(forKey: "numeroContrat") as? String
        // if let sweetContent = contrat["content"] as? String {
        /*
         let dateFormat = NSDateFormatter()
         dateFormat.dateFormat = "MM/dd/yyyy"
         let dateString = dateFormat.stringFromDate(sweet.creationDate!)
         }*/
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        
    {
        selectedNoteIndex = (indexPath as NSIndexPath).row
        
          print("j'ai selectionné  ")
        
    }
 
    
    override func tableView (_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
        
    {
        
        print("la fonction est lancer ")
        
        
     if editingStyle == UITableViewCellEditingStyle.delete
         {
        let selectedRecordID = mesContrats[(indexPath as NSIndexPath).row].recordID
        
        // print(selectedRecordID)
        
        let container = CKContainer.init(identifier: "iCloud.kerck.TechniApp")
           
        let privateDatabase = container.privateCloudDatabase
        
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
                            self.mesContrats.remove(at: (indexPath as NSIndexPath).row)
                            tableView.deleteRows(at: [indexPath], with: .automatic)
                    })
                }
        })
    }
        
          print("la fonction est fini")
        
    }
    
    
       // MARK: - NAVIGATION
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "SendDataSegue" {
            
            if let destination = segue.destination as? MasterViewController {
                
                let path = tableView.indexPathForSelectedRow
                let cell = tableView.cellForRow(at: path!)
                destination.viaSegue = (cell?.textLabel?.text!)!
                
                
                
            }
        }
        /*
        if segue.identifier == "idSegueEditInfoContrat" {
            
            // let editNoteViewController = segue.destination as! AddInfoViewController
            
            // editNoteViewController.delegate = self as! AddInfoViewControllerDelegate
            
            if let newVC:AddInfoViewController = segue.destination as? AddInfoViewController {
                
                
                
                print("nom contra,@%",contratPass)
                print("nom c,@%",numeroContratPass)
                
                newVC.numeroContratseg = numeroContratPass
                newVC.contratseg = contratPass
                
                print(numeroContratPass)
                
                print( contratPass)
                
            }
            // if let index = selectedNoteIndex {
            //  newVC.editeInfoRecord = mesContrats[index]
            
            //}
        }
        */
        
    }
    
    
    deinit {
        //self.ContratViewController = nil
        print( "la page Contrat  est des-initialiez ")
    }
    
}
