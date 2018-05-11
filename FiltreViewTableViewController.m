//
//  FiltreViewTableViewController.m
//  Cofely_ipad
//
//  Created by Gаггу-Guииz  on 09/12/2015.
//  Copyright © 2015 COFELY_Technibook. All rights reserved.
//

#import "FiltreViewTableViewController.h"
#import <CloudKit/CloudKit.h>
#import "InstalViewController.h"
#import "MasterViewController.h"
#import "AddInstallationViewController.h"
#import "MBProgressHUD.h"
#import "AsyncImageView.h"
#import "Instalation.h"


@interface FiltreViewTableViewController ()

@end

@implementation FiltreViewTableViewController

@synthesize _publicDB,_container;


- (void)viewWillAppear:(BOOL)animated
{
    [self fetchData];
        [super viewWillAppear:animated];
    
    
    
}

- (void)fetchData

{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view
                                              animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Téléchargement ";
    [hud show:YES];
    
    
    _container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
    _publicDB = _container.publicCloudDatabase;
    
    
    
    // _privateDB = _container.privateCloudDatabase;
    
    CKQuery *query = [[CKQuery alloc]initWithRecordType :@"TypeFiltre"
                                               predicate:[NSPredicate predicateWithValue:YES ]];
    
    // NSLog(@"self.Batiment nomBatiment %@",self.batiment [@"nomBatiment" ]);
    // NSLog(@"Batiment  %@",self.batiment);
    
    [[self _publicDB] performQuery:query
                      inZoneWithID:nil
                 completionHandler:^(NSArray *results, NSError *error){
                     
                     if (error) {
                         
                         
                         
                         NSLog(@"ERREUR %@",error.localizedDescription);
                     }listeFiltreModel_ = results;
                     dispatch_async(dispatch_get_main_queue(), ^{
                         
                         [self.refreshControl endRefreshing];
                         [self.tableView reloadData];
                         [hud hide:YES];
                     });
                 }];
    {
        
        
        
        
        // NSLog(@"liste filtre %@" ,listeFiltreModel_);
         //NSLog(@"liste filtre %@" ,[results]);
        //  NSLog(@"nom contrat %@" ,[record objectForKey:@"numerContrat"]);
        // NSLog(@"liste des batiment%@" ,listeBati);
        
        
    }
    
    
    
}





- (void)handleQueryResponse:(NSArray *)response
{
    // On récupère le tableau, on le stocke.
    listeFiltreModel_ = response;
   // NSLog(@"liste response %@" ,response);
    // On retire le loader
    /*[self showLoading:NO];*/
    // Et on met à jour la tableView
    [[self tableFiltreModel ] reloadData];
}

- (void)showError:(NSError *)error
{
    if (error) {
        /*[self showLoading:NO];*/
        
        UIAlertController * alert = [ UIAlertController alertControllerWithTitle :[self titleForError:error]
                                                                         message : @"pas de reseau"preferredStyle : UIAlertControllerStyleAlert ] ;
        
        
        [ self presentViewController : alert animated : YES completion : nil ] ;
        
        
        
            }
}
- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(@"global.error.title", @"");
}
/*
- (NSString *)messageForError:(NSError *)error
{
    if (error.domain == NSURLErrorDomain) {
        if (error.code == kPFErrorConnectionFailed) {
            return NSLocalizedString(@"global.error.network.offline", @"");
        } else if (error.code == kPFErrorTimeout) {
            return NSLocalizedString(@"global.error.network.timeout", @"");
        } else {
            return NSLocalizedString(@"global.error.network.default", @"");
        }
    }
    
    return NSLocalizedString(@"global.error.subtitle", @"");
}
*/

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
    
    
    self.refreshControl=[[UIRefreshControl alloc]init];
    //self.refreshControl.backgroundColor = [UIColor brownColor];
    self.refreshControl.tintColor = [UIColor brownColor];
    [self.refreshControl addTarget:self action:@selector(fetchData)
                  forControlEvents:UIControlEventValueChanged];

    
    
    // Retire les bar dans la tableview
   // [self.tableFiltreModel setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Ajouter rembourrage en haut de la vue du tableau
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tableFiltreModel.contentInset = inset;
    
    //Affecter notre propre backgroud pour la vue
   // self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
    
    //////couleur de fond ////
  //  self.tableFiltreModel.backgroundColor = [UIColor clearColor];
    
    // Uncomment the following line to preserve selection between presentations.
    /*self.clearsSelectionOnViewWillAppear = NO;*/
}

/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}







#pragma mark - TableView


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listeFiltreModel_ count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(30, 9, 200, 40)];
    label.textColor = [UIColor brownColor];
    
    return 20;
}
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    
    
    
    //return [@"title"];
 }


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    PFObject *object = [listeFiltreModel_ objectAtIndex:indexPath.row];
    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [object deleteInBackground];
        [[self tableFiltreModel ] reloadData];
        
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellI";
    UITableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel         *nameInstal     = (UILabel *)[cell viewWithTag:2];
    UIImageView     *imageView      = (UIImageView *)[cell viewWithTag:1];
    UILabel         *caracteristique     = (UILabel *)[cell viewWithTag:3];
    UILabel         *reference     = (UILabel *)[cell viewWithTag:4];
    UILabel         *type     = (UILabel *)[cell viewWithTag:5];
    
    CKRecord *instalations = [listeFiltreModel_ objectAtIndex:indexPath.row];
    
    CKAsset *imageAsset = instalations[@"AvatarFiltre"];
    imageView.imageURL = imageAsset.fileURL;
    
    nameInstal.text = instalations[@"NomFiltre"];
    caracteristique.text = instalations[@"Caracteristique"];
    reference.text = instalations[@"Reference"];
    type.text = instalations[@"TypeFiltration"];
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [[self navigationController] popViewControllerAnimated:YES]; 
    
}



- (IBAction)cancelButton:(id)sender{
     [self dismissViewControllerAnimated:YES completion:nil];
    
    
}




@end
