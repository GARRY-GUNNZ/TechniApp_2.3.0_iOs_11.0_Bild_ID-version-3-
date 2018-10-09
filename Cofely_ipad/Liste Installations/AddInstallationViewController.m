//
//  AddInstallationViewController.m
//  TechniApp
//
//  Created by Gаггу-Guииz  on 14/08/2016.
//  Copyright © 2016 COFELY_Technibook. All rights reserved.
//
#import "AddInstallationViewController.h"
#import "SVProgressHUD.h"
#import "MBProgressHUD.h"
#import <CloudKit/CloudKit.h>
@interface AddInstallationViewController ()
<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation AddInstallationViewController{
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_nomContrat setText:_viaSegue];
    [_labelBatiment setText:_segueBati];
    
 
}



//////////////////////////////////////////////////////

- (IBAction)ajouterPhotos:(id)sender {
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Ajouter une photo"
                                                                   message:@"Choisissez de prendre une photo ou d'en choisir une dans votre photothèque"
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
    // 5
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil]; // 6
    
    
    
}

- (void) imagePickerController:(UIImagePickerController *)picker
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
   // currentAvatar_       = image;
    
    self.imageView.image = image;
    
   // [self updateDoneButtonStatus];
}



//////////////////////////////////////////////////////


- (IBAction)doneButtonAction:(id)sender
{
    //[self uploadImage:currentAvatar_];
    
    [self ajouterInstal];
    
    
}
- (void)ajouterInstal

{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view
                                              animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Téléchargement ";
    [hud show:YES];
    //[self setLoadingProgress:-1];
    
    NSData *imageData = [[NSData alloc] init];
    
      imageData = UIImageJPEGRepresentation(self.imageView.image, 0.3);
    ///////////////// cloudkit///////////////////////////
    
    
    CKRecord * obj = [[CKRecord alloc] initWithRecordType:@"Installation"];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *file = [documentsDirectory stringByAppendingPathComponent:@"data.jpg"];
    [imageData writeToFile:file
                atomically:YES];
    
    CKAsset *asset = [[CKAsset alloc] initWithFileURL:[NSURL fileURLWithPath:file]];
    [obj setObject:asset forKey:@"avatarInstal"];
    
    obj[@"nomInstal"] = self.nameTextField.text;
    obj[@"nomBatiment"] = self.labelBatiment.text;
    obj[@"marque"] = self.marqueTextfield.text;
    obj[@"reference"] = self.referenceTextfield.text;
    obj[@"Contrat"] = self.nomContrat.text;
    
    _container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
    _publicDB = _container.publicCloudDatabase;
    
    
    [_publicDB saveRecord:obj completionHandler:^(CKRecord *obj,NSError *error){
        
        // Si tout s'est bien passé, on ferme le vc modal.
        [hud hide:YES];
        [self dismissViewControllerAnimated:YES completion:nil];}];

    
}


/*
- (void)updateDoneButtonStatus
{
    // Le bouton done n'est activé que si on a un nom et un avatar
    BOOL shouldEnableDoneButton = YES;
    
    if ((self.nameTextField.text == nil) || (self.nameTextField.text.length < 1) || (currentAvatar_ == nil)
         ||(self.referenceTextfield == nil) || (self.marqueTextfield == nil)) {
       // shouldEnableDoneButton = NO;
    }
    
   // self.doneButton.enabled = shouldEnableDoneButton;
}
*/
- (NSString *)title
{
    return NSLocalizedString(@"Ajouter Instalation", @"");
}
/*
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateDoneButtonStatus];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self updateDoneButtonStatus];
    return NO;
}

*/
- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.nameTextField resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   // return NSDebugDescriptionErrorKey (@"probleme memoire",@"");
}

- (IBAction)cancelButtonAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end


