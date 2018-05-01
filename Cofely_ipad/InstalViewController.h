//
//  InstalViewController.h
//  Cofely_ipad
//
//  Created by kerckweb on 21/11/2014.
//  Copyright (c) 2014 COFELY_Technibook. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CloudKit/CloudKit.h>
@class DetailViewController;


@interface InstalViewController : UITableViewController
<UITableViewDataSource, UITableViewDelegate>

{ NSMutableArray *listeInstal;
    
    CKContainer *_container;
    CKDatabase *_publicDB;
    CKDatabase *_privateDB;


    
    
}

@property (weak, nonatomic) IBOutlet UIImageView *avatarBati;

@property (weak, nonatomic) IBOutlet UIView *overlayView;

@property (nonatomic, strong) NSString *viaSegue;
@property (nonatomic, weak) IBOutlet UILabel * nomContrat;
@property(nonatomic,readonly) CKContainer *_container;
@property(nonatomic,readonly) CKDatabase *_publicDB;
@property (strong, nonatomic) CKRecord           *batiment;
@property (strong, nonatomic) NSMutableArray *listeInstal;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addInstalation;

@property (strong, nonatomic) IBOutlet UITableView * tableView;
 @property (weak, nonatomic) IBOutlet UILabel *batiTextField;


@end
