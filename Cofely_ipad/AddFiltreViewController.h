//
//  AddFiltreViewController.h
//  Cofely_ipad
//
//  Created by kerckweb on 27/08/2015.
//  Copyright (c) 2015 COFELY_Technibook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudKit/CloudKit.h>
@class Instalation;

@interface AddFiltreViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate> {
    UIImage *currentAvatar_;
    UIPickerView *lePickerView;
    NSMutableArray *liste;
    NSString *label;
    CKContainer *_container;
    CKDatabase *_publicDB;
}
@property (weak, nonatomic) IBOutlet UILabel *nomContrat;
@property (weak, nonatomic) IBOutlet UIStepper *stepperQuantite;
@property (weak, nonatomic) IBOutlet UILabel *labelQ;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateControl;
@property (strong, nonatomic) IBOutlet UILabel *typeDeGaz;
@property(nonatomic,readonly) CKContainer * container;
@property(nonatomic,readonly) CKDatabase * publicDB;
// PAGE FILTRE
@property (strong,nonatomic) NSDictionary *filtreType;
@property (strong,nonatomic) NSMutableArray *liste;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerGaz;
@property (weak, nonatomic) IBOutlet UIImageView *avatarFiltre;
@property (weak, nonatomic) IBOutlet UIButton *boutonTypeDeFiltre;

// DIMENTION

@property (weak, nonatomic) IBOutlet UITextField *dimTexfiled;
@property (weak, nonatomic) IBOutlet UITextField *typeTexfiled;
@property (weak, nonatomic) IBOutlet UITextField *profondeurTexfiled;
@property (weak, nonatomic) IBOutlet UILabel *nomDuBati;
@property (weak, nonatomic) IBOutlet UILabel *nomInst;
@property (weak, nonatomic) IBOutlet UILabel *labelA;
@property (weak, nonatomic) IBOutlet UILabel *labelB;
@property (weak, nonatomic) IBOutlet UILabel *labelC;
@property (weak, nonatomic) IBOutlet UILabel *labelP;

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) id detailItembat;
@property(weak,nonatomic) NSString *maVariableATransmet;
@property (strong, nonatomic) CKRecord *Batiment;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segnmentedSel;
- (IBAction)actionSegment:(id)sender;
- (IBAction)actionStepperQ:(UIStepper *)sender;

- (IBAction)saveButton:(id)sender;
- (IBAction)cancelButton:(id)sender;
@end
