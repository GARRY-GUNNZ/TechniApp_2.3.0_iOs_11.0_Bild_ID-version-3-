//
//  AddFiltreViewController.m
//  Cofely_ipad
//
//  Created by kerckweb on 27/08/2015.
//  Copyright (c) 2015 COFELY_Technibook. All rights reserved.
//
#import <UIKit/UIKit.h>
// #import "IngredientDetailViewController.h"
#import "ListeFiltre.h"
// #import "EditingTableViewCell.h"
#import "SVProgressHUD.h"
#import "MBProgressHUD.h"
//#import "CHViewController.h"
#import "AddFiltreViewController.h"
#import "DetailViewController.h"

#import "Instalation.h"


@class Instalation;
@interface AddFiltreViewController ()
<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@end


@implementation AddFiltreViewController;

@synthesize addPhotoFiltre,dimTexfiled,typeTexfiled,maVariableATransmet,nomDuBati,nomInst,liste;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
   /*
   
                           
    */
    
    liste = [[NSMutableArray alloc] init];
    [liste addObject:@"R11"];
    
     [liste addObject:@"R12"];
     [liste addObject:@"R14"];
     [liste addObject:@"R22"];
    [liste addObject:@"R33"];
     [liste addObject:@"R34"];
    [liste addObject:@"R134a"];
     [liste addObject:@"R401"];
     [liste addObject:@"R403"];
      [liste addObject:@"R404"];
    [liste addObject:@"R407C"];
    [liste addObject:@"R410a"];
     [liste addObject:@"R422D"];
    
    
   
   
  
   
   
   
   
    
   
     
    _nomContrat.text = self.maVariableATransmet;
    self.typeTexfiled.hidden =YES;
    self.nomDuBati.text = self.detailItem;
    self.nomInst.text = self.detailItembat;
  
    [self configureView];
    // Do any additional setup after loading the view.
}




#pragma mark - PickerView Gaz


-(NSInteger)numberOfComponentsInPickerView:  (UIPickerView *)pickerView

{
    return 1 ;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component

{
    return [liste count];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    return [liste objectAtIndex:row];
}


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    {
        
        _typeDeGaz.text=[liste objectAtIndex:row];
        
        
        
        
    }
    
    //NSLog(@"Selection de l 'elément:%@",
         // [liste objectAtIndex:row]);
}


#pragma mark - Nom Bati et Instal

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        //[self configureView];
    }
}
/////////////////ajouter photo filtre///////////


- (IBAction)ajouterPhotos:(id)sender {
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Ajoutez une photo"
                                                                   message:@"Choisissez de prendre une photos ou d'en choisir une dans votre photothèque Photo "
                                                            preferredStyle:UIAlertControllerStyleAlert];
    // 1
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Prendre une Photo"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action)
                                  
                                  
                                  {
                                      
                                      {
                                          // Quand l'utilisateur appuie sur le bouton "Choisir une photo"
                                          // on lance simplement un UIImagePickerController
                                          UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                          
                                          
                                          // prendre une photo
                                          if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                                              picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                          
                                          
                                          picker.delegate = self;
                                          
                                          [self presentViewController:picker animated:YES completion:nil];
                                      }
                                      
                                  }];
    // 2
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Choisir une photo"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action)
                                   
                                   {
                                       {
                                           
                                           
                                           {
                                               // Quand l'utilisateur appuie sur le bouton "Choisir une photo"
                                               // on lance simplement un UIImagePickerController
                                               UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                               
                                               picker.delegate = self;
                                               [self presentViewController:picker animated:YES completion:nil];
                                           }
                                           
                                           
                                           
                                       }
                                       
                                       
                                       
                                   }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Annuler"
                             style:UIAlertActionStyleDestructive
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 
                                 [alert dismissViewControllerAnimated:YES completion:nil];}];
    
    // 3
    
    [alert addAction:firstAction];
    // 4
    [alert addAction:secondAction];
    [alert addAction:cancel];
    // 5
    
    [self presentViewController:alert animated:YES completion:nil]; // 6
    
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    // Quand il a séléctionné une image, on la stocke
    [self handleImagePick:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)handleImagePick:(UIImage *)image
{
    // Il s'agit simplement de garder un pointeur vers l'image
    // et de l'afficher ...
    currentAvatar_       = image;
    self.avatarFiltre.image = image;
    //[self updateDoneButtonStatus];
}
























/////////////////////////////
- (void)setDetailItembat:(id)newDetailItembat {
    if (_detailItembat != newDetailItembat) {
        _detailItembat = newDetailItembat;
        
        // Update the view.
        
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    //if (self.detailItem) {
        self.nomDuBati.text = [self.detailItem description];
        self.nomInst.text = [self.detailItembat description];
        
       //  NSLog(@" nom = %@",nomDuBati);
        // NSLog(@" nomInst = %@",nomInst);
        
    }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segmented Control
- (IBAction)actionSegment:(id)sender {
   
    // Gaz
    if (_segnmentedSel.selectedSegmentIndex == 0) {
        self.addPhotoFiltre.hidden = YES;
        self.labelQ.text = @"0";
        self.labelA.text = @"Type de Gaz:";
        self.labelB.text = @" Poids en Kg:";
        self.labelC.text = @"Gaz";
        self.labelB.hidden = YES;
        self.labelP.hidden = YES;
        self.dimTexfiled.hidden = YES;
        self.pickerGaz.hidden = NO;
        self.typeDeGaz.hidden = NO;
        self.boutonTypeDeFiltre.hidden = YES;
        self.typeTexfiled.hidden =YES;
        self.dateControl.hidden = NO;
        self.profondeurTexfiled.hidden = YES;
        self.avatarFiltre.hidden = YES ;
        self.boutonTypeDeFiltre.hidden = YES;
    }
    // FILTRES
    else if (_segnmentedSel.selectedSegmentIndex == 1)
    {
        self.addPhotoFiltre.hidden = NO;
        self.labelQ.text = @"0";
        self.labelA.text = @"Largeur:";
        self.labelB.text = @"Longueur:";
        self.labelP.text = @"Profondeur:";
        self.labelC.text = @"Filtres";
        self.labelB.hidden = NO;
        self.dimTexfiled.hidden = NO;
         self.labelP.hidden = NO;
        self.pickerGaz.hidden = YES;
        self.typeDeGaz.hidden = YES;
        self.boutonTypeDeFiltre.hidden = YES;
        self.typeTexfiled.hidden =NO;
        self.dateControl.hidden = YES;
        self.profondeurTexfiled.hidden = NO;
        self.avatarFiltre.hidden=NO;
        self.boutonTypeDeFiltre.hidden = YES;
        
    }
    // COURROIE
    else if (_segnmentedSel.selectedSegmentIndex == 2)
    {
        self.addPhotoFiltre.hidden = YES;
        self.labelQ.text = @"0";
        self.labelA.text = @"Type de Courroie:";
        self.labelB.text = @"Taille de la Courroie: ";
         self.labelC.text = @"Courroies";
        self.labelB.hidden = NO;
        self.labelP.hidden = YES;
         self.dimTexfiled.hidden = NO;
        self.pickerGaz.hidden = YES;
        self.typeDeGaz.hidden = YES;
        self.boutonTypeDeFiltre.hidden = YES;
        self.typeTexfiled.hidden =NO;
        self.dateControl.hidden = YES;
        self.profondeurTexfiled.hidden = YES;
        self.avatarFiltre.hidden = YES ;
        self.boutonTypeDeFiltre.hidden = YES;
        
    }
    // Piéces
    /*
    else if (_segnmentedSel.selectedSegmentIndex == 3)
    {
        
        self.labelQ.text = @"0";
        self.labelA.text = @"Marque:";
        self.labelB.text = @"Référence: ";
         self.labelC.text = @"Consomable";
        self.labelB.hidden = NO;
        self.labelP.hidden = YES;
        self.pickerGaz.hidden = YES;
        self.typeDeGaz.hidden = YES;
         self.dimTexfiled.hidden = NO;
        self.boutonTypeDeFiltre.hidden = YES;
        self.typeTexfiled.hidden =NO;
        self.dateControl.hidden = YES;
        self.profondeurTexfiled.hidden = YES;
    }
  */
}

    
- (IBAction)actionStepperQ:(UIStepper *)sender {
    double value = [sender value];
    
    [_labelQ setText:[NSString stringWithFormat:@"%d", (int)value]];    
}


#pragma mark - Cloudkit

 - (IBAction)saveButton:(id)sender {
     
/// cloudkit
  
     //CKRecordID * recordID = [[CKRecordID alloc] initWithRecordName:self.nomInst.text];
     
     NSData *imageData = UIImageJPEGRepresentation(self.avatarFiltre.image, 0.3);
     
     CKRecord *addconsomable = [[CKRecord alloc]initWithRecordType:self.labelC.text];
                                //recordID:recordID];
     
     
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsDirectory = [paths objectAtIndex:0];
     NSString *file = [documentsDirectory stringByAppendingPathComponent:@"data.jpg"];
     [imageData writeToFile:file
                 atomically:YES];
     
     
     
     CKAsset *asset = [[CKAsset alloc] initWithFileURL:[NSURL fileURLWithPath:file]];
     [addconsomable setObject:asset forKey:@"avatarFiltre"];
     
     /// version swift ajouter une photo par defaut
     /*
     else {
         let fileURL = Bundle.main.url(forResource: "no_image", withExtension: "png")
         let imageAsset = CKAsset(fileURL: fileURL!)
         noteRecord.setObject(imageAsset, forKey: "noteImage")
     */
     
     

     
  //////////VERSION UPDATE///////////////
     [addconsomable setObject:_nomContrat.text forKey:@"nomContrat"];
     [addconsomable setObject:dimTexfiled.text forKey:@"dimention"];
     [addconsomable setObject:typeTexfiled.text forKey:@"type"];
     [addconsomable setObject:_profondeurTexfiled.text forKey:@"Profondeur"];
     [addconsomable setObject:nomDuBati.text forKey:@"nomInstal"];
     [addconsomable setObject:nomInst.text forKey:@"nomBati"];
     [addconsomable setObject:_typeDeGaz.text forKey:@"typeGaz"];
     [addconsomable setObject:_dateControl.date forKey:@"date"];
     [addconsomable setObject:_labelQ.text forKey:@"quantite"];
     [addconsomable setObject:@"en Stock" forKey:@"Etat"];
     [addconsomable setObject:@0 forKey:@"EtatComande"];
     
////////////////SAUVEGARDE //////////////////////
  /*
// Il suffit de setter tous les champs
addconsomable[@"dimention"]= self.dimTexfiled.text ;
addconsomable[@"type"] =self.typeTexfiled.text ;
addconsomable[@"nomInstal"]= self.nomDuBati.text;
addconsomable[@"nomBati"]= self.nomInst.text;
 addconsomable[@"typeGaz"]= self.typeDeGaz.text;
addconsomable[@"date"]     = self.dateControl.date;
*/
     ///////////////////////////////////////////////////
     




     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view
                                               animated:YES];
     hud.mode = MBProgressHUDModeDeterminate;
     hud.labelText = @"Téléchargement ";
     [hud show:YES];

     
     
     _container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
     _publicDB = _container.publicCloudDatabase;
// Et on va sauvegarder l'objet ...

     [ _publicDB saveRecord:addconsomable completionHandler:^(CKRecord *addBatiment,NSError *error){
         
         // Si tout s'est bien passé, on ferme le vc modal.
         [hud hide:YES];
         [self dismissViewControllerAnimated:YES completion:nil];
         
     }];
     
 }



- (IBAction)cancelButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];}


                      
@end
