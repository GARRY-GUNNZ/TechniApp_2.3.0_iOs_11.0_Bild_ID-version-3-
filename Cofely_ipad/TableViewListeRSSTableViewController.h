//
//  TableViewListeRSSTableViewController.h
//  Cofely_ipad
//
//  Created by Gаггу-Guииz  on 10/04/2016.
//  Copyright © 2016 COFELY_Technibook. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface TableViewListeRSSTableViewController : UITableViewController <NSXMLParserDelegate>
{
    NSDateFormatter *sessionDateFormatter_;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
//@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end


