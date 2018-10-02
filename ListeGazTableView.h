//
//  ListeGazTableView.h
//  Cofely_ipad
//
//  Created by Gаггу-Guииz  on 16/12/2015.
//  Copyright © 2015 COFELY_Technibook. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CloudKit/CloudKit.h>
#import "CHViewController.h"

@interface ListeGazTableView : UITableViewController
<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *listeGaz_;
    NSDateFormatter *sessionDateFormatter_;
    //UILabel *dateControl;
    CKContainer *_container;
    CKDatabase *_publicDB;
    CKDatabase *_privateDB;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITableView *tableGaz;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented;
@property(nonatomic,readonly) CKContainer *_container;
@property(nonatomic,readonly) CKDatabase *_publicDB;
@property (strong, nonatomic) CKRecord           *batiment;
//@property (weak, nonatomic) IBOutlet UISwitch *switchControl;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented;
@property (weak, nonatomic) IBOutlet UISegmentedControl *actionSegmented;
//@property (weak, nonatomic) IBOutlet UILabel *typeGaz;
//@property (weak, nonatomic) IBOutlet UILabel *dateControl;
- (IBAction)actionSegment:(id)sender;
//- (IBAction)actionSwitch:(id)sender;

@end
