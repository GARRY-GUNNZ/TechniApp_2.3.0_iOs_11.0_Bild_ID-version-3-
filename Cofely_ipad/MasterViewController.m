//
//  MasterViewController.m

//
//  Created by James Yu on 12/29/11.
//

#import "MasterViewController.h"
#import "MBProgressHUD.h"
#import "InstalViewController.h"
#import "Instalation.h"
#import <UIKit/UIKit.h>
#import <CloudKit/CloudKit.h>
//#import "SWRevealViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TechniApp-Bridging-Header.h"

#import "AddInstallationViewController.h"
#import "TechniApp-Swift.h"

@interface MasterViewController ()


@end
@implementation MasterViewController {
    
}
@synthesize listeBati,liste;

/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

*/

- (void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableviewBati.delegate = self;
    self.tableviewBati.dataSource =self;
    
    
   [_nomContrat setText:_viaSegue];
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
   //    self.tableView.backgroundColor = [UIColor clearColor];
    //self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
    
   //     self.tableView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg@2x.png"]];
    
   // self.overlayView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0f];
  //  self.overlayView .layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.7].CGColor;
  //  self.overlayView.layer.borderWidth = 0.5f;

    
    
    self.refreshControl=[[UIRefreshControl alloc]init];
    self.refreshControl.backgroundColor = [UIColor grayColor];
    self.refreshControl.tintColor = [UIColor brownColor];
  
    [self.refreshControl addTarget:self action:@selector(getBati)
                  forControlEvents:UIControlEventValueChanged];
    
    //[self getBati];
    
    UIImage *navBarImage = [UIImage imageNamed:@"ipad-list-element@2x.png"];
    //if(![Utils isVersion6AndBelow])
       // navBarImage = [UIImage tallImageNamed:@"ipad-menubar-left-7.png"];
        
    [self.navigationController.navigationBar setBackgroundImage:navBarImage 
                                       forBarMetrics:UIBarMetricsDefault];
    /*
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshTable:)
                                                 name:@"refreshTable"
                                               object:nil];
    */
    // Retire les bar dans la tableview
    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Ajouter rembourrage en haut de la vue du tableau
    UIEdgeInsets inset = UIEdgeInsetsMake(1.75, 0, 0, 0);
    self.tableView.contentInset = inset;
    
    //Affecter notre propre backgroud pour la vue
    //self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
    //self.tableView.backgroundColor = [UIColor clearColor];
    
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
   /* self.navigationItem.leftBarButtonItem = self.editButtonItem;*/
    
 
    
    [self getBati];
}


- (NSArray *)results
{
    if (!liste) {
        liste = [[NSArray alloc] init];
    }
    
    return liste;
}
#pragma mark - FETCH CLOUDKIT

-(void) getBati
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo: _tableviewBati
                                              animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Téléchargement...";
    hud.color = [UIColor brownColor];
   [hud show:YES];


    _container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
    _publicDB = _container.publicCloudDatabase;
    
   
    
    CKQuery *query = [[CKQuery alloc]initWithRecordType:@"Batiment"
                                              //predicate:[NSPredicate predicateWithValue:YES]];
    
    
    
     predicate:[NSPredicate predicateWithFormat:@"nomContrats == %@", _nomContrat.text]];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"nomBatiment"
                                                                     ascending:YES];
    query.sortDescriptors = @[sortDescriptor];
    
    
    
    [_publicDB performQuery:query
               inZoneWithID:nil
          completionHandler:^(NSArray *results,NSError*error){
        
        if (error) {
            
            
            NSLog(@"ERREUR %@",error.localizedDescription);
        }
        
        //for (CKRecord *record in results)
        
             
            
              self->listeBati = results;
            
            dispatch_async(dispatch_get_main_queue(), ^{
         
            
             [self.refreshControl endRefreshing];
            [self.tableView reloadData];
                
                [hud hide:YES];
            });
        }];
              {
            
                  
              }
              
              
              
          }






- (void)showError:(NSError *)error
{
    if (error) {
        /*[self showLoading:NO];*/
        
        
        UIAlertController * alertView = [UIAlertController alertControllerWithTitle: [self titleForError:error]
                                                                            message:[self messageForError:error]
                                         
                                                                     preferredStyle: UIAlertControllerStyleAlert];
        
        
        
        
        [ self presentViewController : alertView animated : YES completion : nil ] ;
        
        
     
    }
}



- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(@"global.error.title", @"");
}

- (NSString *)messageForError:(NSError *)error
{
    /*if (error.domain == NSURLErrorDomain) {
        if (error.code == kPFErrorConnectionFailed) {
            return NSLocalizedString(@"global.error.network.offline", @"");
        } else if (error.code == kPFErrorTimeout) {
            return NSLocalizedString(@"global.error.network.timeout", @"");
        } else {
            return NSLocalizedString(@"global.error.network.default", @"");
        }
    }*/
    
    return NSLocalizedString(@"global.error.subtitle", @"");
}


#pragma mark - View lifecycle

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

/*
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                            name:@"refreshTable"
                                                  object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/



#pragma mark - Table view data source



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listeBati.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
    
    {
 
        NSString * titreHeader = [[NSString alloc]initWithFormat: @"🏢  Bâtiments  %@  ",_nomContrat.text];
        
       
        return titreHeader;
 
    
    }


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
   
    return 160;
}


/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [UIView.alloc initWithFrame:CGRectMake(100, 100, tableView.frame.size.width, 28)];
    UILabel *lblTitle =[UILabel.alloc initWithFrame:CGRectMake(6, 3, 136, 21)];
    lblTitle.text = @"Contrat: %@  ",_nomContrat.text ;
    [lblTitle setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
    //Font style
    [lblTitle setTextColor:[UIColor blackColor]];
    [lblTitle setTextAlignment:NSTextAlignmentLeft];
    [lblTitle setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg@2x.png"]]];
    
    //Background
    [viewHeader addSubview:lblTitle];
    return viewHeader;
}
*/
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    
    
    
   // UILabel *lblTitle =[UILabel.alloc initWithFrame:CGRectMake(6, 3, 136, 21)];
   // lblTitle.text = @"ddddddddddddddddddddddd"; ///_nomContrat.text ;
    
    //Font style
    //[lblTitle setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
    //[lblTitle setTextColor:[UIColor blackColor]];
    //[lblTitle setTextAlignment:NSTextAlignmentLeft];
    

    // Background color
    view.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"IMG_0028.jpg"]];
    //[UIColor colorWithRed:77.0/255.0 green:162.0/255.0 blue:217.0/255.0 alpha:1.0];
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor blackColor]];
    [header.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:45]];
     //[header.textLabel setText:@"titre"];
     //[UIColor colorWithPatternImage:[UIImage imageNamed:@"ipad-list-item-selected@2x.png"]]];
    
   }
/*
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{

    UIView* bannier = [[UIView alloc] initWithFrame:CGRectMake(30,355,10,50)];
    bannier.tintColor = [UIColor brownColor];


     return @" ";
}
*/

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellB" forIndexPath:indexPath];
    
    if (cell== 0) {
        return cell;
    }
   // cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
    //   reuseIdentifier:@"CellB" ];
    
    UILabel         *numeroInstal     = (UILabel *)[cell viewWithTag:2];
    
    UILabel         *nameBatiment     = (UILabel *)[cell viewWithTag:3];
    
        
        // Configure the cell...
        CKRecord *record = self.listeBati[indexPath.row];
        
        //NSLog(@"liste bati tableview %@" ,listeBati);
        nameBatiment.text = [record objectForKey:@"nomBatiment"];
    
    
        numeroInstal.text = [NSString stringWithFormat:@"Contrat n°%@ ",[record objectForKey:@"numberContrat"]];
        
       
        
        
        
    
    
    return cell;
}

/*
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
*/


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        /*
         NSMutableArray * liste = nil ;
         if (indexPath.section == 0)
         }
         */
        
        ///////////////////////////////////////
        NSLog(@"click delete");
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"EFFACER"
                                      message:(@"Voulez-vous vraiment supprimer ce Batiment du contrat ? cette opération est irreversible !!!" )
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"Effacer"
                             style:UIAlertActionStyleDestructive
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 
                                 MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view
                                                                           animated:YES];
                                 hud.mode = MBProgressHUDModeIndeterminate;
                                 hud.labelText = @"Suppression en cours ... ";
                                 [hud show:YES];
                                 
                                 // NSLog(@" liste instal %@",listeInstal);
                                 
                                 
                                 self->_container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
                                 self->_publicDB = self->_container.publicCloudDatabase;
                          
                                 
                                 
                                 
                                 CKRecord * del =[self->listeBati objectAtIndex:indexPath.row];
                                 
                                 [self->_publicDB deleteRecordWithID:(del.recordID) completionHandler:^(CKRecordID *recordID, NSError *error)
                                  
                                  {
                                      if (error) {
                                          
                                          NSLog(@" erreur ");
                                          NSLog(@"ERREUR %@",error.localizedDescription);
                                      }
                                      dispatch_async(dispatch_get_main_queue(), ^
                                                     {
                                                         NSLog(@"recordID %@",recordID);
                                                         NSLog(@" pas d erreur ");
                                                         
                                                         // [recordID removeObjectAtIndex:indexPath.row] ;
                                                         
                                                         
                                                         
                                                         
                                                         // liste = [[NSMutableArray alloc] init];
                                                         
                                                         [self->listeBati removeObjectAtIndex:indexPath.row];
                                                         
                                                         [self.tableviewBati deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                                         [hud hide:YES];
                                                         NSLog(@" FIN DE SUPRESSION ");
                                                         NSLog(@" FIN DE SUPRESSION ");
                                                     });
                                      
                                  }];
                                 
                                 
                                 
                                 
                                 
                             }];
        
        ///////////////////////////////////////////////////////////////////////
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"Annuler"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                     
                                 }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
        
        
        
        
    }
    
    
    
}






#pragma mark - Table view delegate



 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
 
 
    if ([segue.identifier isEqualToString:@"ShowInstal"]) {
 
        NSIndexPath *indexPath = [[self tableView] indexPathForCell:sender];
 
      // InstalViewController *destViewController = segue.destinationViewController;
        
       
        CKRecord *listinstal = [ self.listeBati objectAtIndex:indexPath.row];
       // Instalation *instalation = [[Instalation alloc] init];
       // instalation.nomBatiment = [listinstal objectForKey:@"nomBatiment"];
         //instalation.nomInstalation = [listinstal objectForKey:@"numberContrat"];
       // instalation.imageFile = [listinstal objectForKey:@"avatarInstal"];
        
        // NSLog(@"nom du batiment  %@",[listinstal objectForKey:@"nomBatiment"]);
       // NSLog(@"number du contrat   %@",[listinstal objectForKey:@"numberContrat"]);
        
        
         [(InstalViewController *)segue.destinationViewController setBatiment:listinstal];
        
        
        
        NSString * nomC =[[NSString alloc]init];
        nomC = _viaSegue;
        
        
        
        InstalViewController * maVuAddBatiment = (InstalViewController *)segue.destinationViewController;
        
        [maVuAddBatiment setViaSegue:nomC];
        
        // AddFiltreViewController *vc = [segue destinationViewController];
       // NSLog(@"_nomContrat %@",_nomContrat);
        
        
        
        
        
     
      
    }
    
    if ([[segue identifier] isEqualToString:@"addBati"])
       {
        
        
       // NSString * nom = [[NSString alloc]init];
        //nom =self.Batiment[@"nomInstal"];
        
        NSString * nomC =[[NSString alloc]init];
        nomC = _viaSegue;
        
       
        
        AddBatiments * vuBati = (AddBatiments *)segue.destinationViewController;
        
        [vuBati setViaSegue:nomC];
       
        // AddFiltreViewController *vc = [segue destinationViewController];
       // NSLog(@"_nomContrat %@",_nomContrat);
        
      }
    if ([segue.identifier isEqualToString:@"ShowInfoContrat"]) {
        
       
        
       // NSString * nomContrat =[[NSString alloc]init];
       // nomContrat = _viaSegue;
        
        
        
       // AddInfoViewController *infoContrat =
      //  (AddInfoViewController *)segue.destinationViewController;
     
        
       // [infoContrat setContratseg:_viaSegue];
        
        
        
    }

   
    


}


@end
