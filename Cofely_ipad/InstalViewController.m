//
//  InstalViewController.m
//  Cofely_ipad
//
//  Created by kerckweb on 21/11/2014.
//  Copyright (c) 2014 COFELY_Technibook. All rights reserved.
//

#import "InstalViewController.h"
#import "MasterViewController.h"
#import "AddInstallationViewController.h"
#import "MBProgressHUD.h"
#import "AsyncImageView.h"
#import "Instalation.h"
#import "TechniApp-Swift.h"

#import <UIKit/UIKit.h>

@interface InstalViewController ()

@end

@implementation InstalViewController{
    
}
@synthesize _container,_publicDB,listeInstal,tableView;



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
   
    // SEGUE
    [_nomContrat setText:_viaSegue];
    _batiTextField.text = self.batiment[@"nomBatiment"];
    
    
    CKAsset * asset = self.batiment[@"xavatarBati"];
    _avatarBati.imageURL = asset.fileURL;

    
    
    
    
    // REFRESH CONTROLE
    self.refreshControl=[[UIRefreshControl alloc]init];
    self.refreshControl.backgroundColor = [UIColor grayColor];
    self.refreshControl.tintColor = [UIColor brownColor];
    [self.refreshControl addTarget:self action:@selector(getInstal)
                  forControlEvents:UIControlEventValueChanged];
    
    // EFFET VISUEL //////////////////
    

    self.overlayView .layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.7].CGColor;
    self.overlayView.layer.borderWidth = 0.5f;
    self.overlayView.layer.shadowRadius = 4.0f;
    
    // Retire les bar dans la tableview
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Ajouter rembourrage en haut de la vue du tableau
     UIEdgeInsets inset = UIEdgeInsetsMake(1.75, 0, 0, 0);
     self.tableView.contentInset = inset;
    
    //Affecter notre propre backgroud pour la vue
    
    self.tableView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg@2x.png"]];
 
    
    //////couleur de fond ////
    
    //self.clearsSelectionOnViewWillAppear = NO;
    
    
    [self getInstal];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
   
    [super didReceiveMemoryWarning];
    
    
    
  
}


- (void)viewWillAppear:(BOOL)animated
{
 
       [super viewWillAppear:animated];
    
}



#pragma mark - CLOUDKIT

-(void) getInstal
    {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo: self.overlayView
                                                  animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"Téléchargement";
        hud.color = [UIColor brownColor];
       
        
        [hud show:YES];
        
        _container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
        _publicDB = _container.publicCloudDatabase;
        
        
       // _privateDB = _container.privateCloudDatabase;
       
        CKQuery *query = [[CKQuery alloc]initWithRecordType :@"Installation"
        
        
        
        predicate:[NSPredicate predicateWithFormat:@"(nomBatiment == %@)", self.batiment [@"nomBatiment" ]]];
    
        
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"nomInstal"
                                                                         ascending:YES];
        query.sortDescriptors = @[sortDescriptor];

                [[self _publicDB] performQuery:query
                                    inZoneWithID:nil
                             completionHandler:^(NSArray *results, NSError *error){
                             
                 if (error) {
                     
                     NSLog(@" erreur ");
                     NSLog(@"ERREUR %@",error.localizedDescription);
                 }
                                 listeInstal = results;
                                 NSLog(@"nombre d instal %lu", (unsigned long)listeInstal.count);
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
        
         UIAlertController * alert = [ UIAlertController
                                alertControllerWithTitle :[self titleForError:error]
                                    message : @"ERREUR"preferredStyle : UIAlertControllerStyleAlert ] ;
        
        
         [ self presentViewController : alert animated : YES completion : nil ] ;
        
        
        
            }
}
- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(@"global.error.title", @"");
}



- (void)awakeFromNib
{

    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}







#pragma mark - TableView


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listeInstal count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    label.textColor = [UIColor whiteColor];
    
    return 50;
}





- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{ //return  self.batiment [@"nomBatiment" ];
    
    NSString * titreHeader = [[NSString alloc]initWithFormat: @"Batiment: %@ ",self.batiment[@"nomBatiment"]];
   
  return titreHeader;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableViEw cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellI";
    
    UITableViewCell *cell           = [tableViEw dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell== 0) {
        return cell;
    }
    
    
    
    UILabel         *nameInstal     = (UILabel *)[cell viewWithTag:2];
    UIImageView     *imageView      = (UIImageView *)[cell viewWithTag:1];
    UILabel         *nameBatiment     = (UILabel *)[cell viewWithTag:3];
    
    
    CKRecord *record = self.listeInstal[indexPath.row];
    CKAsset *imageAsset = record[@"avatarInstal"];
    imageView.imageURL = imageAsset.fileURL;
    
    ///////// design photo////////
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 3.0f;
    imageView.layer.borderWidth = 0.5f;
    imageView.layer.borderColor = [UIColor blackColor].CGColor;
    imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    imageView.layer.shadowRadius = 1.0f;
    ////////////////////////////////

    nameInstal.text = [record objectForKey:@"nomInstal"];
    nameBatiment.text = [record objectForKey:@"marque"];
    
    
    
    return cell;
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //NSMutableArray * insta = nil ;
        // if (indexPath.section == 0) {
        
        
        ///////////////////////////////////////
       // NSLog(@"click delete");
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"EFFACER "
                                      message:@"Voulez-vous vraiment supprimer cette installation ? cette opération est irreversible !!! "
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
                                 
                                
                                 
                                 _container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
                                 _publicDB = _container.publicCloudDatabase;
                                 
                            CKRecord * del =[listeInstal objectAtIndex:indexPath.row];
                        
                           [_publicDB deleteRecordWithID:(del.recordID) completionHandler:^(CKRecordID *recordID, NSError *error)
                            
                                  {
                                      if (error) {
                                          
                                          NSLog(@" erreur ");
                                          NSLog(@"ERREUR %@",error.localizedDescription);
                                      }
                                      dispatch_async(dispatch_get_main_queue(), ^
                                                     {
                                                         NSLog(@"recordID %@",recordID);
                                                         NSLog(@" pas d'erreur ");
                                                         
                                                         // [recordID removeObjectAtIndex:indexPath.row] ;
                                                         
                                                         [listeInstal removeObjectAtIndex:indexPath.row];
                                                         
                                                         [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                                         [hud hide:YES];
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





- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowDetail"]) {
        
        NSIndexPath *indexPath = [[self tableView] indexPathForCell:sender];
        
         InstalViewController *destViewController = segue.destinationViewController;
        
        
        CKRecord *listinstal = [ listeInstal objectAtIndex:indexPath.row];
        Instalation *instalation = [[Instalation alloc] init];
        instalation.nomBatiment = [listinstal objectForKey:@"nomBatiment"];
        instalation.nomInstalation = [listinstal objectForKey:@"nomInstal"];
       instalation.imageFile = [listinstal objectForKey:@"avatarInstal"];
       instalation.contrat = [listinstal objectForKey:@"Contrat"];
        
    
       
  //   NSLog(@"nomducontat segu instalvIEW %@" , instalation.contrat );
      //  code pour efface le bouton de navigation
       destViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        
        [(InstalViewController *)segue.destinationViewController setBatiment:listinstal];
        
        
    }
    if ([[segue identifier] isEqualToString:@"addInstal"])
    {
        
        
        // NSString * nom = [[NSString alloc]init];
        //nom =self.Batiment[@"nomInstal"];
        
        NSString * nomC =[[NSString alloc]init];
        nomC = _viaSegue ;
        
        NSString * nomB =[[NSString alloc]init];
        nomB = self.batiment [@"nomBatiment" ] ;
        
        
        AddInstallationViewController * maVuAddBatiment = (AddInstallationViewController *)segue.destinationViewController;
        
        [maVuAddBatiment setViaSegue:nomC];
        [maVuAddBatiment setSegueBati:nomB];
        
        // AddFiltreViewController *vc = [segue destinationViewController];
       // NSLog(@"_nomContrat %@",_nomContrat);
        
    }
    
    if ([segue.identifier isEqualToString:@"detailCommande"]) {
        
        
        
        NSString * nomB =[[NSString alloc]init];
        nomB = self.batiment [@"nomBatiment" ] ;
        
        
        DetailPieceDetache *infoContrat = (DetailPieceDetache *)segue.destinationViewController;
        
        
        //[infoContrat setnomBatisegu:@"ziziziziziz"];
        
        [infoContrat setNomBatisegu:nomB];
        
        
        
    }

    
    
    


    
}


@end
