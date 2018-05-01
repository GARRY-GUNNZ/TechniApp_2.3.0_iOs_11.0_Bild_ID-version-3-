//
//  FiltreViewTableViewController.h
//  Cofely_ipad
//
//  Created by Gаггу-Guииz  on 09/12/2015.
//  Copyright © 2015 COFELY_Technibook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudKit/CloudKit.h>
@interface FiltreViewTableViewController : UITableViewController

{
    
    NSArray         *listeFiltreModel_;
    CKContainer *_container;
    CKDatabase *_publicDB;
    CKDatabase *_privateDB;
    
}




@property(nonatomic,readonly) CKContainer *_container;
@property(nonatomic,readonly) CKDatabase *_publicDB;
@property (weak, nonatomic) IBOutlet UITableView *tableFiltreModel;
- (IBAction)cancelButton:(id)sender;
//@property (strong, nonatomic) PFObject *filtremodel;
@end
