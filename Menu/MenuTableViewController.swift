//
//  MenuTableViewController.swift
//  TechniApp
//
//  Created by Gаггу-Guииz  on 18/04/2018.
//  Copyright © 2018 COFELY_Technibook. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
  
    
    @IBOutlet weak var avatarProfil: UIImageView!
    
    @IBOutlet weak var labelNom: UILabel!
    
    @IBOutlet weak var labelPrenom: UILabel!
    
    @IBOutlet weak var nomEquipe: UILabel!
    //let menuArray = ["💼 Mes contrats","🌍 GoogleDrive","⭐️ Star","Yammer"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.object(forKey: "avatar") as? NSData == nil {
            //self.imageDefaut()
            let imageAvatar = UIImage(named:"add-photo-placeholder.png")
            let imagedata : NSData = UIImagePNGRepresentation(imageAvatar!)! as NSData
            UserDefaults.standard.set(imagedata, forKey: "avatar")
            UserDefaults.standard.synchronize()
        }
        else {
           // self.getProfil()
            ///// USER DEFAUT
            let avatarImage = UserDefaults.standard.object(forKey: "avatar") as? NSData
            let name = UserDefaults.standard.value(forKey: "nom") as? String
            let firstname = UserDefaults.standard.value(forKey: "prenom") as? String
            let equipeName = UserDefaults.standard.value(forKey: "nomEquipe") as? String
            
            avatarProfil.image = UIImage(data: (avatarImage! as Data))
            avatarProfil.layer.cornerRadius = 50
            avatarProfil.layer.masksToBounds = true
           
            labelPrenom.text = name
            labelNom.text = firstname
            nomEquipe.text = equipeName
            
        }
        
        
        
        
        
        
    }
   /*
    func imageDefaut()  {
        
         let imageAvatar = UIImage(named:"add-photo-placeholder.png")
         let imagedata : NSData = UIImagePNGRepresentation(imageAvatar!)! as NSData
          UserDefaults.standard.set(imagedata, forKey: "avatar")
        UserDefaults.standard.synchronize()
    }
    */
    /*
    func getProfil()  {
        
        ///// USER DEFAUT
        let avatarImage = UserDefaults.standard.object(forKey: "avatar") as? NSData
        let name = UserDefaults.standard.value(forKey: "nom") as? String
        let firstname = UserDefaults.standard.value(forKey: "prenom") as? String
        let equipeName = UserDefaults.standard.value(forKey: "nomEquipe") as? String
        
        avatarProfil.image = UIImage(data: (avatarImage! as Data))
        labelPrenom.text = name
        labelNom.text = firstname
        nomEquipe.text = equipeName
        
        
    }
*/
    /*
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MenuCell

     
        cell.lblMenuname?.text! = menuArray [indexPath.row]
        

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
     /*
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var _: SWRevealViewController = self.revealViewController()
        let cell:UITableViewCell = (tableView.cellForRow(at: indexPath))!
     
        if cell.textLabel?.text! == "Contrats"
        {
            print("Contrats Tapped")
            
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ContratViewController") as! ContratViewController
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
    
            revealViewController().pushFrontViewController(newFrontController, animated: true)
            
     }/*
     if cell.lblMenuname.text! == "Message"
     {
     print("message Tapped")
     
     let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
     let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "StarViewController") as! StarViewController
     let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
     
     revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
     }
     if cell.lblMenuname.text! == "Map"
     {
     print("Map Tapped")
     }
     if cell.lblMenuname.text! == "Setting"
     {
     print("setting Tapped")
     }
        
   */
     }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    
        
    }
 */

}
