//
//  AddInstallationViewController.h
//  TechniApp
//
//  Created by Gаггу-Guииz  on 14/08/2016.
//  Copyright © 2016 COFELY_Technibook. All rights reserved.
//
#import <CloudKit/CloudKit.h>
#import "CHViewController.h"
@class AddInstallationViewController;

@interface AddInstallationViewController : CHViewController <UITextFieldDelegate>
{
    UIImage *currentAvatar_;
    NSMutableArray *listeBatiInstal;
   // UIPickerView *pickerBatiInstal_;
    NSString *label;
    NSMutableArray *listeEquipement_;
    CKContainer *_container;
    CKDatabase *_publicDB;
    CKDatabase *_privateDB;
   
}
@property(nonatomic,readonly) CKContainer * container;
@property(nonatomic,readonly) CKDatabase * publicDB;
@property (strong, nonatomic) IBOutlet UILabel *labelBatiment;
@property (weak, nonatomic) IBOutlet UILabel *nomContrat;
@property (nonatomic, strong) NSString *viaSegue;
@property (nonatomic, strong) NSString *segueBati;
@property (nonatomic, strong) NSString *objectId;
@property (weak, nonatomic) IBOutlet UITextField     *nameTextField;
@property (weak, nonatomic) IBOutlet UIImageView     *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITextField *marqueTextfield;
@property (weak, nonatomic) IBOutlet UITextField *referenceTextfield;

- (IBAction)doneButtonAction:(id)sender;

- (IBAction)ajouterPhotos:(id)sender;


@end
