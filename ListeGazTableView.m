//
//  ListeGazTableView.m
//  Cofely_ipad
//
//  Created by Gаггу-Guииz  on 16/12/2015.
//  Copyright © 2015 COFELY_Technibook. All rights reserved.
//
//#import "MenuTableViewController.h"
#import "ListeGazTableView.h"
#import "AsyncImageView.h"
#import "SVProgressHUD.h"
#import "MBProgressHUD.h"
#import "CHViewController.h"
#import "SWRevealViewController.h"

@interface ListeGazTableView ()

@end

@implementation ListeGazTableView
@synthesize tableGaz,_container,_publicDB;






- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [self recupGaz];
    /*[PFObject fetchAllIfNeededInBackground:self.Batiment[@"lien"]
     
     block:^(NSArray *objects, NSError *error) {
   
     
     if (error) {
     [self showError:error];
     } else {
     instal_ = objects;
     [[self tableViEw] reloadData];
     
     }
     }];
     */
    [super viewWillAppear:animated];
    
   
    
}


- (void)recupGaz
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view
                                              animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Téléchargement ";
    [hud show:YES];
    
    
    NSString * bati = nil;
    bati = @"2016";
    
    
   NSDate * now = [NSDate date];

    
    
    
    
    
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"YYYY-01-01 00:00:00 0000"];
   
    NSString *dateStr = [fmt stringFromDate:[NSDate date]];
    [fmt setDateFormat: @"YYYY-MM-DD HH:mm:ss zzzz"];
    
    NSDate *premierjour = [fmt dateFromString:dateStr];
    //return firstDate;
    NSLog(@"1 journde l anné %@",premierjour);
    
    
    /*
    
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"YYYY-12-31 23:59:00 0000"];
    NSString *dateSt = [fm stringFromDate:[NSDate date]];
    [fm setDateFormat: @"YYYY-MM-DD HH:mm:ss zzzz"];
    NSDate *dernierjour = [fm dateFromString:dateSt];
    //return firstDate;
  //  NSLog(@"dernier jour de l anné %@",dernierjour);
    
    */
    
    

 
    
    
    _container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
    _publicDB = _container.publicCloudDatabase;
    
    CKQuery *query = [[CKQuery alloc]initWithRecordType :@"Gaz"
                      // predicate:[NSPredicate
                                      //predicateWithValue:YES ]];
                      
       //NSPredicate *predicate = nil;
                                              predicate : [NSPredicate predicateWithFormat:@"(date > %@) AND (date < %@)", premierjour, now]];
    
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date"
                                                                     ascending:YES];
    query.sortDescriptors = @[sortDescriptor];
    
    

    

    
    
                      
   // predicate:[NSPredicate predicateWithFormat:@"nomInstal == %@", noninstal]];
    
    
   // NSLog(@"self.Batiment nomBatiment %@",self.batiment [@"nomBatiment" ]);
   // NSLog(@"Batiment  %@",self.batiment);
    
    [[self _publicDB] performQuery:query
                      inZoneWithID:nil
                 completionHandler:^(NSArray *results, NSError *error){
                     
                     if (error) {
                         
                         
                         
                         NSLog(@"ERREUR %@",error.localizedDescription);
                     }listeGaz_ = results;
                     dispatch_async(dispatch_get_main_queue(), ^{
                         
                         
                         
                      [self.refreshControl endRefreshing];
                         [self.tableGaz reloadData];
                         [hud hide:YES];
                     });
                 }];
    {
        
        
        
        
        // NSLog(@"nom bati %@" ,[record objectForKey:@"nomBatiment"]);
        //  NSLog(@"nom contrat %@" ,[record objectForKey:@"numerContrat"]);
        // NSLog(@"liste des batiment%@" ,listeBati);
        
        
    }
    
    
    
}


- (void)fetchDataEnstock
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view
                                              animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Téléchargement ";
    [hud show:YES];
    
    
    NSString * bati = nil;
    bati = @"En stock";
    
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"YYYY-01-01 00:00:00 0000"];
    NSString *dateStr = [fmt stringFromDate:[NSDate date]];
    [fmt setDateFormat: @"YYYY-MM-DD HH:mm:ss zzzz"];
    NSDate *premierjour = [fmt dateFromString:dateStr];
    //return firstDate;
    //NSLog(@"1 journde l anné %@",premierjour);
    
    
    _container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
    _publicDB = _container.publicCloudDatabase;
    
   
    
    CKQuery *query = [[CKQuery alloc]initWithRecordType :@"Gaz"
                      //   predicate:[NSPredicate
                      // predicateWithValue:YES ]];
                                               predicate:[NSPredicate predicateWithFormat:@"date < %@", premierjour]];
    
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date"
                                                                     ascending:YES];
    query.sortDescriptors = @[sortDescriptor];
    

    
    
    
    
    
    
    
    [[self _publicDB] performQuery:query
                      inZoneWithID:nil
                 completionHandler:^(NSArray *results, NSError *error){
                     
                     if (error) {
                         
                         
                         
                         NSLog(@"ERREUR %@",error.localizedDescription);
                     }listeGaz_ = results;
                     dispatch_async(dispatch_get_main_queue(), ^{
                         
                         
                         
                         [self.refreshControl endRefreshing];
                         [self.tableGaz reloadData];
                         [hud hide:YES];
                     });
                 }];
    {
        
        
        
        
        // NSLog(@"nom bati %@" ,[record objectForKey:@"nomBatiment"]);
        //  NSLog(@"nom contrat %@" ,[record objectForKey:@"numerContrat"]);
        // NSLog(@"liste des batiment%@" ,listeBati);
        
        
    }
    
    
    
}




















- (void)handleQueryResponse:(NSArray *)response
{
    // On récupère le tableau, on le stocke.
    listeGaz_ = response;
    
    // On retire le loader
    // [hud show:NO];
    // Et on met à jour la tableView
   [[self tableGaz ] reloadData];
}

- (void)showError:(NSError *)error
{
    if (error) {
        /*[self showLoading:NO];*/
        
        UIAlertController * alert = [ UIAlertController alertControllerWithTitle :[self titleForError:error]
                                                                         message : @"pas de reseau" preferredStyle : UIAlertControllerStyleAlert ] ;
        
        
        [ self presentViewController : alert animated : YES completion : nil ] ;
        
        
        
        /*
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[self titleForError:error]
         message:[self messageForError:error]
         delegate:nil
         cancelButtonTitle:NSLocalizedString(@"global.OK", @"")
         otherButtonTitles:nil];
         [alertView show];
         
         
         */
    }
}
- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(@"global.error.title", @"");
}



- (void)awakeFromNib
{
    /*self.clearsSelectionOnViewWillAppear = NO;*/
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ///////////  bouton slideBar ****************
  //  _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
   // _sidebarButton.target = self.revealViewController;
  //  _sidebarButton.action = @selector(revealToggle:);
    // Set the gesture
   // [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    
  //  self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg@2x.png"]];
 //   self.tableView.backgroundColor = [UIColor clearColor];
    


    
    
    
    
    
    
    [self recupGaz];
    
    
    
    self.refreshControl=[[UIRefreshControl alloc]init];
    self.refreshControl.backgroundColor = [UIColor brownColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(recupGaz)
                  forControlEvents:UIControlEventValueChanged];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
     
    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Segment action


- (IBAction)actionSegment:(id)sender {
    
    // Gaz
    if (_segmented.selectedSegmentIndex == 0) {
        
        [self recupGaz];
    }
    // FILTRES
    else if (_segmented.selectedSegmentIndex == 1)
    {
        
        [self fetchDataEnstock];
        //dateControl.hidden = YES;
        /*
        self.labelA.text = @"Largeur";
         self.labelB.text = @"Longeur";
         self.labelC.text = @"Filtres";
         self.pickerGaz.hidden = YES;
         self.typeDeGaz.hidden = YES;
         */
   }
    
}






#pragma mark - TableView

////////////////////////   Image des cellule   //////////////////////////////////
/*
- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowCount = [self tableView:[self tableGaz] numberOfRowsInSection:0];
    NSInteger rowIndex = indexPath.row;
    UIImage *background = nil;
    
    if (rowIndex == 0) {
        background = [UIImage imageNamed:@"cell_top.png"];
    } else if (rowIndex == rowCount - 1) {
        background = [UIImage imageNamed:@"cell_bottom.png"];
    } else {
        background = [UIImage imageNamed:@"cell_middle.png"];
    }
    
    return background;
}
 */
////////////////////////////////////////////////////////////////////////////////////

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listeGaz_ count];
    
     //NSLog(@"le resultat liste gaz: %@",listeGaz_);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(30, 9, 200, 40)];
    //label.textColor = [UIColor brownColor];
    
    return 30;
}
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    
    
    
   // return self.Batiment[@"title"];
}
*/
/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    PFObject *object = [instal_ objectAtIndex:indexPath.row];
    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [object deleteInBackground];
        [[self tableViEw ] reloadData];
        
        [self fetchData];
    }];
    
}

*/


/*
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section

{ return @"Liste Instalations"; }

// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
    */

- (NSDateFormatter *)sessionDateFormatter
{
    if (!sessionDateFormatter_) {
        sessionDateFormatter_           = [[NSDateFormatter alloc] init];
        sessionDateFormatter_.dateStyle = NSDateFormatterMediumStyle;
            }
    
    return sessionDateFormatter_;
}

    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellI";
    UITableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel         *nameInstal     = (UILabel *)[cell viewWithTag:2];
  //  UIImageView     *imageView      = (UIImageView *)[cell viewWithTag:1];
    UILabel         *nameBatiment     = (UILabel *)[cell viewWithTag:3];
    UILabel         *nameMarque     = (UILabel *)[cell viewWithTag:4];
    UILabel         *dateControl     = (UILabel *)[cell viewWithTag:5];
    UILabel         *typeGaz     = (UILabel *)[cell viewWithTag:6];
   // UILabel         *poids     = (UILabel *)[cell viewWithTag:7];
    
    CKRecord *instalations = [listeGaz_ objectAtIndex:indexPath.row];
    
   // PFFile *imageFile = (PFFile *)instalations[@"avatar"];
    
    // Et on affiche l'image (via son URL)
    //imageView.imageURL = [NSURL URLWithString:[imageFile url]];
    
    //NSDate *sessionDate = instalations[@"date"];
    
    nameInstal.text = instalations[@"nomInstal"];
    nameBatiment.text = instalations[@"nomBati"];
    nameMarque.text = instalations[@"reference"];
    
   typeGaz.text = [NSString stringWithFormat:@"%@ | %@ Kg",
                                 instalations[@"typeGaz"], instalations[@"quantite"]];
   
    dateControl.text=[[self sessionDateFormatter] stringFromDate:instalations[@"date"]];
    
    
    return cell;
    
    
}

- (IBAction)actionSwitch:(id)sender {
    
}
@end
