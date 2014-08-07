//
//  DetailViewController.h
//  Cofely_ipad
//
//  Created by COFELY_Technibook on 07/08/2014.
//  Copyright (c) 2014 COFELY_Technibook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
