//
//  TableViewListeRSSTableViewController.m
//  Cofely_ipad
//
//  Created by Gаггу-Guииz  on 10/04/2016.
//  Copyright © 2016 COFELY_Technibook. All rights reserved.
//


#import "TableViewListeRSSTableViewController.h"
#import "AsyncImageView.h"
#import "UIWebDetailFluxRSS.h"
#import "SWRevealViewController.h"

@interface TableViewListeRSSTableViewController () {
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *image;
    NSMutableString *link;
    NSString *element;
}
@end

@implementation TableViewListeRSSTableViewController




- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    feeds = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:@"http://techniapp.tumblr.com/rss"];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    NSLog(@" le resultat de FEED %@",feeds);
    
    
    
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg@2x.png"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    

    
    
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    

    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return feeds.count;
  //  NSLog(@" le resultat de FEED %lu",(unsigned long)feeds.count);
}


- (NSDateFormatter *)sessionDateFormatter
{
    if (!sessionDateFormatter_) {
        sessionDateFormatter_           = [[NSDateFormatter alloc] init];
        sessionDateFormatter_.dateStyle = NSDateFormatterMediumStyle;
    }
    
    return sessionDateFormatter_;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    UILabel         *titleBlog     = (UILabel *)[cell viewWithTag:2];
    UIImageView     *imageBlog      = (UIImageView *)[cell viewWithTag:1];
    UILabel         *linkBlog     = (UILabel *)[cell viewWithTag:3];
    UILabel         * descritions     = (UILabel *)[cell viewWithTag:4];
    
    
    
    ///////////////////////////////////////////////////////////////////////
    //  imageBlog.image= [NSURL URLWithString: _url];
    titleBlog.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"title"];
    linkBlog.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"pubDate"];
    descritions.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"link"];
   
    
    
    
    NSURL *urls = [NSURL URLWithString:@"http://www.abondance.com/Bin/videos-seo-abondance.png"];
    
    imageBlog.imageURL = urls;
    //////////////////////////////////////////////////////////////////////////////////////
    //NSURL *urls = [NSURLLocalizedLabelKey stringByAppendingPathExtension:@".jpg"];
    // NSURL *urls = [NSURL
    // imageBlog.imageURL = urls;
    //NSURL *urls = [[NSURL alloc] init stringByAppendingPathExtension:@".jpg"];
    //imageBlog.imageURL = urls;
    
    
    /*
     
     NSLog(@"liste feed description = %@", feeds.description);
     
     
     NSString * imageb = [[NSString alloc]init ];
     imageb =[[feeds objectAtIndex:indexPath.row]
     objectForKey: @"description"];
     NSLog(@"imageb URL = %@", imageb);
     
     NSURL *baseURL = [NSURL URLWithString:@"http://"];
     NSURL *url = [NSURL URLWithString:@".jpg" relativeToURL:baseURL];
     NSURL *absURL = [url absoluteURL];
     imageBlog.imageURL = absURL;
     NSLog(@"base URL = %@", baseURL);
     
     */
    
    //NSURL *urls = [feeds.description stringByAbbreviatingWithTildeInPath:@".jpg"];
    ////////////////////////////////////////////////////////////////////////////////////
    return cell;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        image   = [[NSMutableString alloc] init];
        link    = [[NSMutableString alloc] init];
        NSLog(@" le resultat de item %@",elementName);
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"pubDate"];
        [item setObject:image forKey:@"link"];
        
        [feeds addObject:[item copy]];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    }
    if ([element isEqualToString:@"link"]) {
        [image appendString:string];
        
        
    } else if ([element isEqualToString:@"pubDate"]) {
        [link appendString:string];
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *string = [feeds[indexPath.row] objectForKey: @"link"];
        [[segue destinationViewController] setUrl:string];
        
    }
}

@end

