//
//  DetailViewController.m
//  Cofely_ipad
//
//  Created by COFELY_Technibook on 07/08/2014.
//  Copyright (c) 2014 COFELY_Technibook. All rights reserved.
//
#import "TypeSelectionViewController.h"
#import "IngredientDetailViewController.h"
#import "ListeFiltre.h"
#import "DetailViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "MBProgressHUD.h"
#import "Instalation.h"
#import "InstalViewController.h"
#import "CHViewController.h"
#import "AddFiltreViewController.h"
#import "InstructionsViewController.h"
#import "AsyncImageView.h"
#import <Foundation/Foundation.h>
#import <CloudKit/CloudKit.h>
#import "TechniApp-Swift.h"
#import <UIKit/UIKit.h>
@class Instalation;
@interface DetailViewController ()

@property (strong, nonatomic) ListNotesViewController * listeNote;
@end

@implementation DetailViewController {
    
}

@synthesize marqueTexfield,referenceTexfield,detailTable,consomableListe_,instalation,filtre,avatarInstal,contratLabel;

#pragma mark - DECLARATION SECTIONS

// table's section indexes
//#define TYPE_SECTION            4
#define CONSOMABLE_SECTION     1
#define PIECESDETACHE_SECTION    0
#define GAZ_SECTION 3
#define FILTRE_SECTION 2

// segue ID when "Add Ingredient" cell is tapped
static NSString *kAddIngredientSegueID = @"addFiltre";

// segue ID when "Instructions" cell is tapped
static NSString *kShowInstructionsSegueID = @"showInstructions";

// segue ID when the recipe (category) cell is tapped
//static NSString *kShowRecipeTypeSegueID = @"showRecipeType";

static NSString *kShowGazTypeSegueID = @"showGaz";
static NSString *kShowFiltreTypeSegueID = @"showFiltre";



#pragma mark - INITIALISATION

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
         self.listeGaz_= nil;
        self.consomableListe_= nil;
        self.filtre = nil;
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void) dataMaster {
    {
        [self recupGaz];}
    {
    [self recupConso];
    }

    {   [self recupFiltre];

    }

   
   

}


#pragma mark - LIFE VIEW

- (void)viewDidLoad {
    
  [super viewDidLoad];
  [self configureView];
    
    UIImage *navBarImage = [UIImage imageNamed:@"ipad-list-element@2x.png"];
    //if(![Utils isVersion6AndBelow])
    // navBarImage = [UIImage tallImageNamed:@"ipad-menubar-left-7.png"];
    
    [self.navigationController.navigationBar setBackgroundImage:navBarImage
                                                  forBarMetrics:UIBarMetricsDefault];

    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
   // self.navigationItem.title = self.Batiment[@"nomInstal"];
    
    // Retire les bar dans la tableview
   // [self.detailTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Ajouter rembourrage en haut de la vue du tableau
    UIEdgeInsets inset = UIEdgeInsetsMake(1.75, 0, 0, 0);
    self.detailTable.contentInset = inset;
    
    
     self.tableView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg@2x.png"]];

    [self dataMaster];

    
}





- (void)viewWillAppear:(BOOL)animated {
    
    
    //[self fetchData];
    
    
    
    [super viewWillAppear:animated];
    
    self.nominstal.text = self.Batiment[@"nomBatiment"];
    self.navigationItem.title = self.instalation.nomInstalation;
    self.nomInstaltion.text = self.Batiment[@"nomInstal"];
    self.marqueTexfield.text = self.Batiment[@"marque"];
    self.referenceTexfield.text = self.Batiment[@"reference"];
    CKAsset * asset = self.Batiment[@"avatarInstal"];
    avatarInstal.imageURL = asset.fileURL;
    contratLabel.text =  self.Batiment[@"Contrat"];
    ///////// design Avatar////////
    self.avatarInstal.clipsToBounds = YES;
    self.avatarInstal.layer.cornerRadius = 3.0f;
    self.avatarInstal.layer.borderWidth = 0.5f;
    self.avatarInstal.layer.shadowRadius = 10.0f;
    self.avatarInstal.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self dataMaster];
    
}


#pragma mark - ALERT VIEW (FITRE-COURROIES-GAZ..)

-(void) alertCommandeFiltre
    {
        

         UIAlertController * alert = [ UIAlertController
                                      alertControllerWithTitle :@"Voulez-vous commander ce filtre"
                                      message :((void)(@" VOULEZ-VOUS COMMANDER CE FILTRE %@"),_Batiment[@"nomInstal"])
                             preferredStyle : UIAlertControllerStyleAlert ] ;
       
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"ok"
                             style:UIAlertActionStyleDestructive
                             handler:^(UIAlertAction * action)
                             {

                             }];
        
                             [alert addAction:ok];
                            // [alert addAction:cancel];
                             
                             [self presentViewController:alert animated:YES completion:nil];
                             

    

                             }
-(void) alertCommandeCourroie
{
    
    
    UIAlertController * alert = [ UIAlertController
                                 alertControllerWithTitle :@"Voulez-vous commander cette Courroie?"
                                 message :((void)(@" VOULEZ-VOUS COMMANDER CETTE COURROIES %@"),self.Batiment[@"nomInstal"])
                                 preferredStyle : UIAlertControllerStyleAlert ] ;
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             
                         }];
    
    /*UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Annuler"
                             style:UIAlertActionStyleDestructive
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 
                                 [alert dismissViewControllerAnimated:YES completion:nil];}];
     */
    
    [alert addAction:ok];
    //[alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    
}



-(void) nomdelInstalation :(NSString *)nom
{
    nom = self.Batiment[@"nomInstal"];
}


#pragma mark - Editing

- (void)setEditing:(BOOL)editing
          animated:(BOOL)animated {
    
    [super setEditing:editing
             animated:animated];
    
     if (!self.singleEdit) {
         
        
        /*[self updatePhotoButton];*/
         
        self.nomInstaltion.enabled = editing;
        self.marqueTexfield.enabled = editing;
        self.referenceTexfield.enabled = editing;
        [self.navigationItem setHidesBackButton:editing animated:YES];
        
        [self.detailTable beginUpdates];
        
        NSUInteger ingredientsCount = self.consomableListe_.count;
         
        
        NSArray *ingredientsInsertIndexPath = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:ingredientsCount
                               inSection:CONSOMABLE_SECTION]];
        
        if (editing) {
            [self.detailTable insertRowsAtIndexPaths:ingredientsInsertIndexPath withRowAnimation:UITableViewRowAnimationTop];
            self.marqueTexfield.placeholder = @"Saisir Marque";
        } else {
            [self.detailTable deleteRowsAtIndexPaths:ingredientsInsertIndexPath withRowAnimation:UITableViewRowAnimationTop];
            self.marqueTexfield.placeholder = @"Saisir reference";
        }
        
        [self.detailTable endUpdates];
    }
    
    /*
     If editing is finished, save the managed object context.
     */
    if (!editing) {
        [self.navigationItem setHidesBackButton:editing animated:YES];
        
        
        [self dataMaster];
        
        
           }
}



#pragma mark - CLOUDKIT FETCH

- (void)recupConso
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view
                                              animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Téléchargement ";
     hud.color = [UIColor brownColor];
    [hud show:YES];
    

    __container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
    __publicDB = __container.publicCloudDatabase;
    
    
  

    NSString * bati = nil;
    bati = self.Batiment[@"nomBatiment"];
    NSString * noninstal = nil;
    noninstal = self.Batiment[@"nomInstal"];

    NSArray* args = @[noninstal, bati];
    
    NSPredicate *predicat =[NSPredicate predicateWithFormat:@"nomInstal == %@ AND nomBati == %@"
                                              argumentArray: args];
    
    CKQuery *query = [[CKQuery alloc]initWithRecordType :@"Courroies"predicate:predicat];
    
    [[self _publicDB] performQuery:query
                      inZoneWithID:nil
                 completionHandler:^(NSArray *objects, NSError *error){
                     
                     if (error) {
                         
                         NSLog(@"ERREUR %@",error.localizedDescription);
                         
                     } self.consomableListe_ = objects;
                     dispatch_async(dispatch_get_main_queue(), ^{
                         
                         [self.refreshControl endRefreshing];
                         [self.detailTable reloadData];
                         [hud hide:YES];
                     });
                 }];
    {
    }
   
}





- (void)handleQueryResponse:(NSArray *)response
{
        self.consomableListe_ = response;
    
    [[self detailTable ] reloadData];


}



- (void)recupGaz
{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.color = [UIColor brownColor];
        hud.labelText = @"Téléchargement ";
        [hud show:YES];
        
    __container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
    __publicDB = __container.publicCloudDatabase;
    
    NSString * bati = nil;
    bati = self.Batiment[@"nomBatiment"];
    NSString * noninstal = nil;
    noninstal = self.Batiment[@"nomInstal"];
   
    NSArray* args = @[noninstal, bati];
    
    NSPredicate *predicat =[NSPredicate predicateWithFormat:@"nomInstal == %@ AND nomBati == %@"
     argumentArray: args];
    
    
        CKQuery *query = [[CKQuery alloc]initWithRecordType :@"Gaz"
    
                                                   predicate:predicat];
   

    
        
        [[self _publicDB] performQuery:query
                          inZoneWithID:nil
                     completionHandler:^(NSArray *objects, NSError *error){
                         
                         if (error) {
                             
                             
                             
                             NSLog(@"ERREUR %@",error.localizedDescription);
                         }_listeGaz_ = objects;
                         dispatch_async(dispatch_get_main_queue(), ^{
                             
                             [self.refreshControl endRefreshing];
                             [self.detailTable reloadData];
                             [hud hide:YES];
                         });
                     }];
    
            
        }
    
    
    - (void)QueryResponseGaz:(NSArray *)response
{
 
    self.listeGaz_ = response;
    
   // NSLog(@"le resultat de responseGAZ  %@",response);
    
 
    // Et on met à jour la tableView
    [[self detailTable ] reloadData];
    
}


- (void)recupFiltre
{

MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view
                                          animated:YES];
hud.mode = MBProgressHUDModeIndeterminate;
     hud.color = [UIColor brownColor];
hud.labelText = @"Téléchargement ";
[hud show:YES];


    __container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
    __publicDB = __container.publicCloudDatabase;

    
NSString * bati = nil;
    bati = self.Batiment[@"nomBatiment"];
    NSString * noninstal = nil;
    noninstal = self.Batiment[@"nomInstal"];
    
    NSString * etatcomande = nil;
    etatcomande = self.Batiment[@"Etat"];
    
    
    NSArray* args = @[noninstal, bati];
    
    NSPredicate *predicat =[NSPredicate predicateWithFormat:@"nomInstal == %@ AND nomBati == %@"
                                              argumentArray: args];
    

    CKQuery *query = [[CKQuery alloc]initWithRecordType :@"Filtres"
                      
                                               predicate:predicat];
    

    
    
   
     // CKQuery *query = [[CKQuery alloc]initWithRecordType :@"Filtres"
                  
    
       // predicate:[NSPredicate predicateWithFormat:@"nomInstal == %@", noninstal]];
    
    
   // NSPredicate *predicate = nil;
  //  predicate = [NSPredicate predicateWithFormat:@"batiment == %@", bati];
  
    
    
    
   // NSLog(@"PREDICATE FILTRE %@",predicate);
   // NSLog(@"LISTE FILTRE %@",filtre);
    
    

[[self _publicDB] performQuery:query
                  inZoneWithID:nil
             completionHandler:^(NSArray *objects, NSError *error){
                 
                 if (error) {
                     
                     
                     
                     NSLog(@"ERREUR %@",error.localizedDescription);
                 } self.filtre = objects;
                 dispatch_async(dispatch_get_main_queue(), ^{
                     
                     
                    
                     [self.refreshControl endRefreshing];
                     [self.detailTable reloadData];
                     [hud hide:YES];
                      // NSLog(@"filtre %@",filtre);
                 });
             }];


}







- (void)QueryResponseFiltre:(NSArray *)responseFiltre
{
    // On récupère le tableau, on le stocke.
    self.filtre = responseFiltre;
    
    //NSLog(@"le resultat de responseFiltre  %@",responseFiltre);
    
 
    // Et on met à jour la tableView
    [[self detailTable ] reloadData];
    
}




///////////////////////////////////////////////////////////////

- (void)showError:(NSError *)error
{
    if (error) {
        /*[self showLoading:NO];*/
        
        
         UIAlertController * alert = [ UIAlertController alertControllerWithTitle : [self titleForError:error]
                            message :@"Pas de reseau"
                     preferredStyle : UIAlertControllerStyleAlert ] ;
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(30, 9, 200, 40)];
      //label.textColor = [UIColor brownColor];
    
    
    //[title setText:[UIColor brownColor]];
    
    return 40;
}
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
     //UIImage *myImage = [UIImage imageNamed:@"ipad-list-element.png"];
     UIImageView *imageView = [[UIImageView alloc]init];
     imageView.frame = CGRectMake(10, 10, 1, 30);
     //imageView.tintColor = [UIColor brownColor];
     
     //return imageView;
    
    
    //UIView *headerColor = [[UIView alloc]initWithFrame:CGRectMake(0,0,tableView.frame.size.width,50.0)];
    //headerColor.backgroundColor = [UIColor grayColor];
   //return headerColor;
    
    UILabel *headerLabel =[[UILabel alloc]initWithFrame:CGRectMake(15, 15, 0, 25)];
    [headerLabel setFont:[UIFont fontWithName:@"Verdana" size:20.0]];
    //headerLabel.text =@"Menu";
    [headerLabel addSubview:imageView];
    return headerLabel;
    
}

*/








////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - UITableView CELL CUSTOM

- (BOOL)detailTable:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *title = nil;
    
    // return a title or nil as appropriate for the section
    switch (section) {
        case GAZ_SECTION:
            title = @"Quantitée De Gaz Présente Dans l'Installation";
            if (_listeGaz_.count == 0)
         {
             title = nil;
            }
            
            break;
            
        case CONSOMABLE_SECTION:
            title = @"Liste des Consommables";
            if (consomableListe_.count == 0)
            {
                title = nil;
            }

            
            
            break;
        case PIECESDETACHE_SECTION :
            title = @"";
            break;
        case FILTRE_SECTION:
            title = @"Liste des Filtres ";
            if (filtre.count == 0)
            {
                title = nil;
            }

            
            
            break;

      //  case TYPE_SECTION:
         //   title = @"Documentations";
           // break;
     
        default:
            break;
    }
    
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    
    /*
     The number of rows depends on the section.
     In the case of ingredients, if editing, add a row in editing mode to present an "Add Ingredient" cell.
     */
    switch (section) {
       // case TYPE_SECTION:
          //  rows = 1;
          //  break;
        case PIECESDETACHE_SECTION :
            // these sections have only one row
            rows = 1;
            break;
        case CONSOMABLE_SECTION:
            rows = self.consomableListe_.count;
            if (self.editing) {
                rows++;
            }
            break;
        case GAZ_SECTION:
            // these sections have only one row
            //rows = 1;
            rows = self.listeGaz_.count;
            
            break;
        case FILTRE_SECTION:
            // these sections have only one row
            //rows = 1;
            rows = self.filtre.count;
           // if (self.editing) {
              //  rows++;
           // }

            
            break;

        default:
            break;
    }
    
    return rows;
}

- (NSDateFormatter *)sessionDateFormatter
{
    if (!sessionDateFormatter_) {
        sessionDateFormatter_           = [[NSDateFormatter alloc] init];
        sessionDateFormatter_.dateStyle = NSDateFormatterMediumStyle;
    }
    
    return sessionDateFormatter_;
}



//


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    // AJOUTER FILTRE CONSOMBLE
    UITableViewCell *cell = nil;
    
    
    if (indexPath.section == CONSOMABLE_SECTION) {
        NSUInteger ingredientCount = self.consomableListe_.count;
        NSInteger row = indexPath.row;
        
        if (indexPath.row < (NSInteger)ingredientCount) {
            
            
           
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:@"IngredientsCell" ];
            
            
            UISwitch *aSwitch = [[UISwitch alloc] initWithFrame:(CGRectZero)];
            
            aSwitch.onTintColor = [UIColor brownColor];
            aSwitch.tag = indexPath.row;
            //[cell.contentView addSubview:aSwitch];
            
            cell.accessoryView = aSwitch;
            
            
            [aSwitch addTarget:self
                        action:@selector(switchConsoAction:)
              forControlEvents:UIControlEventValueChanged];

            CKRecord *record = [self.consomableListe_ objectAtIndex:row];
       
            
            
           cell.textLabel.text = [record objectForKey:@"type"];
           cell.detailTextLabel.text = [record objectForKey:@"dimention"];
            
            if ([[record objectForKey:@"EtatComande"]boolValue])
            {
                [aSwitch setOn:YES
                      animated:YES];
                
            }
            
            
            
            
            
        }
        
        else {
                       cell = [tableView dequeueReusableCellWithIdentifier:@"AddIngredientCellIdentifier" forIndexPath:indexPath];
        
        }
        
        
    }
    else {switch (indexPath.section) {
    
            
            
            case PIECESDETACHE_SECTION : //cellule Note
                cell = [tableView dequeueReusableCellWithIdentifier:@"Instructions" forIndexPath:indexPath];
                break;
    
            
    
    
            case GAZ_SECTION: //cellule Note
            
            
            
                cell = [tableView dequeueReusableCellWithIdentifier:@"gazCell" forIndexPath:indexPath];
         
            
            
                
                UILabel         *nameInstal     = (UILabel *)[cell viewWithTag:2];
            
                UILabel         *dateControl     = (UILabel *)[cell viewWithTag:4];
                UILabel         *typeGaz     = (UILabel *)[cell viewWithTag:3];
         
            
            
            //////////  CLOUDKIT
            
            
            CKRecord *instalations = [_listeGaz_ objectAtIndex:indexPath.row];
            //CKAsset *imageAsset = record[@"avatarInstal"];
            // imageView.imageURL = imageAsset.fileURL;
            
            nameInstal.text = instalations[@"nomInstal"];
            //nameBatiment.text = instalations[@"nomBati"];
            //dateControl.text = instalations[@"date"];
            
            typeGaz.text = [NSString stringWithFormat:@"%@ | %@ Kg",
                            instalations[@"typeGaz"], instalations[@"quantite"]];
            
            dateControl.text=[[self sessionDateFormatter] stringFromDate:instalations[@"date"]];
            
            
            
            
                break;
  ////////////////////////FILTRE SECTION //////////////////////////////////
        
    }   if (indexPath.section == FILTRE_SECTION) {
        //switch {
       

            //case FILTRE_SECTION: //cellule Note
                cell = [tableView dequeueReusableCellWithIdentifier:@"filtreCell" forIndexPath:indexPath];
        
                //static NSString *CellIdentifie = @"filtreCell";
                //UITableViewCell *cells          = [tableView dequeueReusableCellWithIdentifier:CellIdentifie //forIndexPath:indexPath];

        
        
            
            UISwitch *aSwitch = [[UISwitch alloc] initWithFrame:(CGRectZero)];
     
        aSwitch.onTintColor = [UIColor brownColor];
        aSwitch.tag = indexPath.row;
        
        
        cell.accessoryView = aSwitch;
        

  [aSwitch addTarget:self
              action:@selector(switchFiltreAction:)
    forControlEvents:UIControlEventValueChanged];
        
        
                      // UILabel         *namInstal    = (UILabel *)[cells viewWithTag:12];
                UIImageView     *image        = (UIImageView *)[cell viewWithTag:13];
               // UILabel         *namBatiment  = (UILabel *)[cells viewWithTag:11];
                UILabel         *nameLong     = (UILabel *)[cell viewWithTag:14];
                UILabel         *nameLarg     = (UILabel *)[cell viewWithTag:15];
                UILabel         *nameProf     = (UILabel *)[cell viewWithTag:16];
                UILabel         *nameQuant    = (UILabel *)[cell viewWithTag:17];
                UILabel        *lableSwitch  = (UILabel *)[cell viewWithTag:21];
                       // UILabel         *dateControl     = (UILabel *)[cell viewWithTag:4];
               // UILabel         *typeGaz     = (UILabel *)[cell viewWithTag:3];
               // UISwitch    *switchFiltre  = (UISwitch *)[cell viewWithTag:18];
        
        CKRecord *instal = [filtre objectAtIndex:indexPath.row];
        
        // Et on affiche l'image (via son URL)
        CKAsset *imageAsset = instal[@"avatarFiltre"];
        image.imageURL = imageAsset.fileURL;
        
        /*
        image.clipsToBounds = YES;
        image.layer.cornerRadius = 5.0f;
        image.layer.borderWidth = 0.5f;
        image.layer.borderColor = [UIColor blackColor].CGColor;
        */
        nameLong.text = instal[@"type"];
        nameLarg.text = instal[@"dimention"];
        nameProf.text = instal[@"Profondeur"];
        nameQuant.text = instal[@"quantite"];
        lableSwitch.text = instal[@"Etat"];
        
    if ([[instal objectForKey:@"EtatComande"]boolValue])
        {
            [aSwitch setOn:YES
                  animated:YES];
     
        }
    }}
    return cell;
}


#pragma mark - SWITCH ACTION

- (void)switchConsoAction:(id)sender {
    
    UISwitch *senderSwitch = (UISwitch *)sender;
    
    if (senderSwitch.on)
    {
        
        CKRecord *tempObject = [consomableListe_ objectAtIndex:senderSwitch.tag];
        
        
        [tempObject setObject:@1        forKey:@"EtatComande"];
        [tempObject setObject:@"en commande" forKey:@"Etat"];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view
                                                  animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"Téléchargement ";
        
        [hud show:YES];
        {
            [self alertCommandeCourroie];
            
        }
        
        __container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
        __publicDB = __container.publicCloudDatabase;
        [__publicDB  saveRecord:tempObject
                                                     completionHandler:^(CKRecord *tempObject,NSError *error)
         {
             
             
             // Si tout s'est bien passé, on ferme le vc modal.
             [hud hide:YES];}];
        
    }
    
    else {
        
        CKRecord *tempObjec = [consomableListe_ objectAtIndex:senderSwitch.tag];
        [tempObjec setObject: @NO forKey:@"EtatComande"];
        [tempObjec setObject:@"en Stock" forKey:@"Etat"];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view
                                                  animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"Téléchargement ";
        [hud show:YES];
        
        __container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
        __publicDB = __container.publicCloudDatabase;
        [__publicDB  saveRecord:tempObjec
                                                     completionHandler:^(CKRecord *tempObjec,NSError *error){
                                                         
                                                         
                                                         [hud hide:YES ];}];
        
    }
    {
        
    }
    
}

- (void)switchFiltreAction:(id)sender {
    
    
    
    UISwitch *senderSwitch = (UISwitch *)sender;
    
    if (senderSwitch.on)
    {
        

        
        CKRecord *tempObject = [filtre objectAtIndex:senderSwitch.tag];
        
        
        [tempObject setObject:@YES           forKey:@"EtatComande"];
        [tempObject setObject:@"en commande" forKey:@"Etat"];
       
        
      
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view
                                                  animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"Téléchargement ";
        
        [hud show:YES];
        {
        [self alertCommandeFiltre];
        
}
        __container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
        __publicDB = __container.publicCloudDatabase;
        [__publicDB saveRecord:tempObject
                                                     completionHandler:^(CKRecord *tempObject,NSError *error)
        {
           
            
                    // Si tout s'est bien passé, on ferme le vc modal.
                     [hud hide:YES];}];
       
       
                                                     
                                                     
    }

         else {
            
        
        CKRecord *tempObjec = [filtre objectAtIndex:senderSwitch.tag];
        [tempObjec setObject: @NO forKey:@"EtatComande"];
        [tempObjec setObject:@"en Stock" forKey:@"Etat"];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view
                                                  animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"Téléchargement ";
        [hud show:YES];
             __container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
             __publicDB = __container.publicCloudDatabase;
             
        [__publicDB saveRecord:tempObjec
                                                     completionHandler:^(CKRecord *tempObjec,NSError *error){
                   
                       
        [hud hide:YES ];}];
             
  
    }
    {
   
    }
    
}





- (IBAction)cancelButtonAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



/////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // user has started a swipe to delete operation
    self.singleEdit = YES;
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // swipe to delete operation has ended
    self.singleEdit = NO;
}

- (ListeFiltre *)filtreByName:(NSString *)filtreName {
    
    ListeFiltre *ingredient = nil;
    NSArray *ingredients = [self.instalation.filtres allObjects];
    for (ingredient in ingredients) {
        if ([ingredient.nomfiltre isEqualToString:filtreName])
            break;  // we found the right ingredient by title
    }
    return ingredient;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
   /* if (indexPath.section == TYPE_SECTION && indexPath.row == 0) {
        // edit the recipe "type"- pass the recipe
        //
        TypeSelectionViewController *typeSelectionViewController =
        [[TypeSelectionViewController alloc] initWithStyle:UITableViewStylePlain];
        typeSelectionViewController.instalation = self.instalation;
        
        // present modally the recipe type view controller
        UINavigationController *navController =
        [[UINavigationController alloc] initWithRootViewController:typeSelectionViewController];
        navController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.navigationController presentViewController:navController animated:YES completion:nil];
    }
    */
    
    //else
        if (indexPath.section == CONSOMABLE_SECTION) {
        // edit the recipe "ingredient" - pass the ingredient
        //
        IngredientDetailViewController *ingredientDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"IngredientDetailViewController"];
        ingredientDetailViewController.instalation = self.instalation;
        
        
     
        
        
        
        // find the selected ingredient table cell (based on indexPath),
        // use it's ingredient title to find the right ingredient object in this recipe.
        // note: you can't use indexPath.row to lookup the recipe's ingredient object because NSSet is not ordered
        //
        UITableViewCell *ingredientCell = [tableView cellForRowAtIndexPath:indexPath];
        ingredientDetailViewController.listeFiltre = [self filtreByName:ingredientCell.textLabel.text];
    
        // present modally the ingredient detail view controller
        UINavigationController *navController =
        [[UINavigationController alloc] initWithRootViewController:ingredientDetailViewController];
        navController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.navigationController presentViewController:navController animated:YES completion:nil];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath *rowToSelect = indexPath;
    NSInteger section = indexPath.section;
    BOOL isEditing = self.editing;
    
    // If editing, don't allow instructions to be selected
    // Not editing: Only allow instructions to be selected
    //
    if ((isEditing && section == PIECESDETACHE_SECTION ) || (!isEditing && section != PIECESDETACHE_SECTION )) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        rowToSelect = nil;
    }
    
    return rowToSelect;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCellEditingStyle style = UITableViewCellEditingStyleNone;
        if (indexPath.section == CONSOMABLE_SECTION)  {
        // If this is the last item, it's the insertion row.
        if (indexPath.row == (NSInteger)consomableListe_.count) {
            style = UITableViewCellEditingStyleInsert;
        }
       
       
            
        else {
            style = UITableViewCellEditingStyleDelete;
        }
    }
    
    return style;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Only allow deletion, and only in the ingredients section
    if ((editingStyle == UITableViewCellEditingStyleDelete) && (indexPath.section == CONSOMABLE_SECTION)) {
        //NSLog(@"click delete");
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"EFFACER "
                                      message:@"Voulez-vous vraiment supprimer cette courroies ? cette opération est irreversible !!! "
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
                                 
                                 CKContainer *container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
                                 CKDatabase *database = container.publicCloudDatabase;
                                 
                                
                                 
                                 CKRecord * del =[self.consomableListe_ objectAtIndex:indexPath.row];
                                 
                                 [database deleteRecordWithID:(del.recordID) completionHandler:^(CKRecordID *recordID, NSError *error)
                                  
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
                                                         
                                                         [self.consomableListe_ removeObjectAtIndex:indexPath.row];
                                                         
                                                         [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
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
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // user tapped the "+" button to add a new ingredient
        
        [self performSegueWithIdentifier:kAddIngredientSegueID sender:self.instalation];
    }
    
    ////////////////////// del gaz ////////////
    
    if ((editingStyle == UITableViewCellEditingStyleDelete) && (indexPath.section == GAZ_SECTION)) {
        //NSLog(@"click delete");
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"EFFACER "
                                      message:@"Voulez-vous vraiment supprimer gaz ? cette opération est irreversible !!! "
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
                                 
                                 CKContainer *container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
                                 CKDatabase *database = container.publicCloudDatabase;
                                 
                                 
                                 CKRecord * del =[self.listeGaz_ objectAtIndex:indexPath.row];
                                 
                                 [database deleteRecordWithID:(del.recordID) completionHandler:^(CKRecordID *recordID, NSError *error)
                                  
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
                                                         
                                                         [self.listeGaz_ removeObjectAtIndex:indexPath.row];
                                                         
                                                         [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
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
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // user tapped the "+" button to add a new ingredient
        
        [self performSegueWithIdentifier:kAddIngredientSegueID sender:self.instalation];
    }
    
    ////////////////////// del gaz ////////////
    
    if ((editingStyle == UITableViewCellEditingStyleDelete) && (indexPath.section == FILTRE_SECTION)) {
        //NSLog(@"click delete");
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"EFFACER "
                                      message:@"Voulez-vous vraiment cette reference de filte cette opération est irreversible !!! "
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
                                 
                                 CKContainer *container = [CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"];
                                 CKDatabase *database = container.publicCloudDatabase;
                                 
                                 
                                 CKRecord * del =[self.filtre objectAtIndex:indexPath.row];
                                 
                                 [database deleteRecordWithID:(del.recordID) completionHandler:^(CKRecordID *recordID, NSError *error)
                                  
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
                                                         
                                                         [self.filtre removeObjectAtIndex:indexPath.row];
                                                         
                                                         [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
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










- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    NSIndexPath *target = proposedDestinationIndexPath;
    
    // Moves are only allowed within the ingredients section, so make sure the destination
    // is in the ingredients section. If the destination is in the ingredients section,
    // make sure that it's not the Add Ingredient row -- if it is, retarget for the penultimate row.
    //
    NSUInteger proposedSection = proposedDestinationIndexPath.section;
    
    if (proposedSection < CONSOMABLE_SECTION) {
        target = [NSIndexPath indexPathForRow:0 inSection:CONSOMABLE_SECTION];
    } else if (proposedSection > CONSOMABLE_SECTION) {
        target = [NSIndexPath indexPathForRow:(self.consomableListe_.count - 1) inSection:CONSOMABLE_SECTION];
    } else {
        NSUInteger ingredientsCount_1 = self.consomableListe_.count - 1;
        
        if (proposedDestinationIndexPath.row > (NSInteger)ingredientsCount_1) {
            target = [NSIndexPath indexPathForRow:ingredientsCount_1 inSection:CONSOMABLE_SECTION];
        }
    }
    
    return target;
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BOOL canMove = NO;
    // Moves are only allowed within the ingredients section.  Within the ingredients section, the last row (Add Ingredient) cannot be moved.
    if (indexPath.section == CONSOMABLE_SECTION) {
        canMove = indexPath.row != (NSInteger)self.consomableListe_.count;
    }
    return canMove;
}


/////////////////////////////////////////////////////////////////////////////

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    /*
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }*/
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem)
    {
        
        /*self.detailDescriptionLabel.text = [self.detailItem description];*/
        

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Action bouton 


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"addFiltre"]){
        
        
        NSString * nom = [[NSString alloc]init];
        nom =self.Batiment[@"nomInstal"];
        
        NSString * nombat =[[NSString alloc]init];
        nombat =self.Batiment[@"nomBatiment"];
        
        NSString * nomCon =[[NSString alloc]init];
        nomCon =self.Batiment[@"Contrat"];
     
        AddFiltreViewController *controller = (AddFiltreViewController *)[[segue destinationViewController]
                                                                    topViewController];
        [controller setDetailItem:nom];
        [controller setDetailItembat:nombat];
        [controller setMaVariableATransmet:nomCon];
        
 
 
        
    }
    if ([[segue identifier] isEqualToString:kShowInstructionsSegueID]){
        
        
        NSString * nom = [[NSString alloc]init];
        nom =self.Batiment[@"nomInstal"];
        
        NSString * nombat =[[NSString alloc]init];
        nombat =self.Batiment[@"nomBatiment"];
  
        InstructionsViewController *instructionsViewController =
        (InstructionsViewController *)segue.destinationViewController;
        [instructionsViewController setDetailItem:nom];
        [instructionsViewController setDetailItembat:nombat];

   
        
    }
    if ([segue.identifier isEqualToString:@"ShowNote"]) {
      
        NSString * nom = [[NSString alloc]init];
        nom =self.Batiment[@"nomInstal"];
        
        NSString * nombat =[[NSString alloc]init];
        nombat = self.Batiment[@"nomBatiment"];
        
        NSString * nomCon =[[NSString alloc]init];
        nomCon =self.Batiment[@"Contrat"];
        
    
        ListNotesViewController *listeNote =
        (ListNotesViewController *)segue.destinationViewController;
      [listeNote setNomBatisegu:nombat];
        [listeNote setInstalsegu:nom];
        [listeNote setContratsegu:nomCon];
     
      
        
    }
    }


@end

