//
//  AddBatimentViewController.h
//  TechniApp
//
//  Created by Gаггу-Guииz  on 14/08/2016.
//  Copyright © 2016 COFELY_Technibook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudKit/CloudKit.h>


@interface AddBatimentViewController : UIViewController <UITextFieldDelegate>

{
    NSArray *batiment_;
    NSMutableArray *liste;
    NSString *label;
    CKContainer *_container;
    CKDatabase *_publicDB;
   // UIImage *currentAvatar_;
    
}

@property(nonatomic,readonly) CKContainer * container;
@property(nonatomic,readonly) CKDatabase * publicDB;

@property (weak, nonatomic) IBOutlet UITextField *nomDuBatiment;
@property (nonatomic, strong) NSString *viaSegue;
@property (nonatomic, weak) IBOutlet UILabel * nomdeContrat;
@property (weak, nonatomic) IBOutlet UITextField *numeroContratTextField;
- (IBAction)cancel:(id)sender;

@end
