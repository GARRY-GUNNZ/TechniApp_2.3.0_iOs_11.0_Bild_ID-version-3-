//
//  UIWebDetailFluxRSS.m
//  Cofely_ipad
//
//  Created by Gаггу-Guииz  on 10/04/2016.
//  Copyright © 2016 COFELY_Technibook. All rights reserved.
//

#import "UIWebDetailFluxRSS.h"
#import "TableViewListeRSSTableViewController.h"

@interface UIWebDetailFluxRSS ()



@end

@implementation UIWebDetailFluxRSS
- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *myURL = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    [self.webView loadRequest:request];
}

@end
