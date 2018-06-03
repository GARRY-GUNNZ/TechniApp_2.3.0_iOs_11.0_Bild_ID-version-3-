//
//  DetailViewController.h
//  Cofely_ipad
//
//  Created by COFELY_Technibook on 07/08/2014.
//  Copyright (c) 2014 COFELY_Technibook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudKit/CloudKit.h>
@class Instalation;


@interface DetailViewController : UITableViewController

<UISplitViewControllerDelegate,UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate>
{
    //UILabel *eSwith;
   UIImage *currentAvatar_;
    NSMutableArray *consomableListe_;
    NSMutableArray * infoInstal_;
    NSArray         *consomable_;
     //NSMutableArray *listeGaz_;
    NSMutableArray *filtre;
  NSDateFormatter *sessionDateFormatter_;
    NSString * contrat;
}


@property (weak, nonatomic) IBOutlet UILabel *contratLabel;

@property (nonatomic, strong) NSString * envoiLeInstal;
@property (nonatomic, strong) NSString * envoiMarque ;
@property (nonatomic, strong) NSString * envoiReference ;
@property (nonatomic, strong) NSString * envoiLenomDuContra;
@property (nonatomic, strong) NSString * envoieLenomDuBatiment;
@property (nonatomic, strong) UIImage  * envoieImage;





@property(nonatomic,readonly) CKContainer *_container;
@property(nonatomic,readonly) CKDatabase *_publicDB;
@property (weak, nonatomic) IBOutlet UITableView *tableConso;
@property (weak, nonatomic) IBOutlet UILabel *nominstal;
//@property(nonatomic, readonly, copy) NSURL *fileUrl;
@property (strong, nonatomic) CKRecord *Batiment;
@property (nonatomic, strong) NSMutableArray *listeGaz_;
@property (nonatomic, strong) NSMutableArray *filtre;
@property (nonatomic, strong) NSMutableArray *consomableListe_;
@property (weak, nonatomic) IBOutlet UITextField *nomInstaltion;
@property (nonatomic, strong) Instalation * instalation;
@property (weak, nonatomic) IBOutlet UITableView *detailTable;
@property (weak, nonatomic) IBOutlet UITextField *marqueTexfield;
@property (weak, nonatomic) IBOutlet UITextField *referenceTexfield;
@property (weak, nonatomic) IBOutlet UIImageView *avatarInstal;


@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) id detailItembat;
@property (assign) BOOL singleEdit;








@end
