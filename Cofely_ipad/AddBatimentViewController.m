//
//  AddBatimentViewController.m
//  TechniApp
//
//  Created by Gаггу-Guииz  on 14/08/2016.
//  Copyright © 2016 COFELY_Technibook. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "AddBatimentViewController.h"

#import "MBProgressHUD.h"
#import "InstalViewController.h"
@interface AddBatimentViewController ()

<UINavigationControllerDelegate, UIImagePickerControllerDelegate>



@property (strong, nonatomic) IBOutlet UIImageView *photoBatiment;
- (IBAction)boutonAddPhoto:(id)sender;

@end

@implementation AddBatimentViewController {
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image
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
    
    self.photoBatiment.image = image;
    //[self updateDoneButtonStatus];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.photoBatiment.image = nil ;
    }
    return self;
}

- (IBAction)doneButtonAction:(id)sender
{
    // On crée un objet de classe Session
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view
                                              animated:YES];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Téléchargement ";
    [hud show:YES];
    NSData *imageData = [[NSData alloc] init];
    
    imageData = UIImageJPEGRepresentation(self.photoBatiment.image, 0.30);
    CKRecord *addBatiment = [[CKRecord alloc]initWithRecordType:@"Batiment"];

    
    // Il suffit de setter tous les champs
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *file = [documentsDirectory stringByAppendingPathComponent:@"data.jpg"];
    [imageData writeToFile:file atomically:YES];
    
    CKAsset *asset = [[CKAsset alloc] initWithFileURL:[NSURL fileURLWithPath:file]];
    [addBatiment setObject:asset forKey:@"xavatarBati"];
    
    addBatiment[@"nomBatiment"]    = self.nomDuBatiment.text;
    addBatiment[@"numberContrat"] = self.numeroContratTextField.text;
    addBatiment[@"nomContrats"] = self.nomdeContrat.text;
    
    
    _container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
    _publicDB = _container.publicCloudDatabase;
    
 
    
    [_publicDB saveRecord:addBatiment
                                                 completionHandler:^(CKRecord *addBatiment,NSError *error){
                                                     
                                                     // Si tout s'est bien passé, on ferme le vc modal.
                                                     [hud hide:YES];
                                                     
                                                     [self dismissViewControllerAnimated:YES completion:nil];
                                                     }];
    
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _photoBatiment = Nil;
    
     [_nomdeContrat setText: _viaSegue];
   
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    /*[self updateDoneButtonStatus];*/
    return NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"probleme memoire dans le menu AddBatiment");
    NSLog(@"%@", self.description);
}


- (IBAction)cancel:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}








- (IBAction)boutonAddPhoto:(id)sender {
    
    
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
@end



