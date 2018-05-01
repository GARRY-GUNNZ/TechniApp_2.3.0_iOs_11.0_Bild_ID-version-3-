//
//  MasterViewController.h

//
//  Created by James Yu on 12/29/11.
//
#import <UIKit/UIKit.h>
#import <CloudKit/CloudKit.h>

@class DetailViewController;


@interface MasterViewController : UITableViewController
<UITableViewDataSource, UITableViewDelegate>

{ NSArray *liste;
    NSMutableArray *listeBati;
    
    CKContainer *_container;
    CKDatabase *_publicDB;
    CKDatabase *_privateDB;

}
@property (nonatomic, strong) NSString *viaSegue;
@property (nonatomic, weak) IBOutlet UILabel * nomContrat;
//@property (nonatomic, weak) IBOutlet UIView* overlayView;
@property(nonatomic,readonly) CKContainer * container;
@property(nonatomic,readonly) CKDatabase * publicDB;
@property(nonatomic,readonly) CKRecord * nomBatiRecord;
@property (strong, nonatomic) IBOutlet UITableView *tableviewBati;
@property (strong, nonatomic) NSArray *liste;
@property (strong, nonatomic) NSMutableArray *listeBati;
@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addBatiment;


@end


