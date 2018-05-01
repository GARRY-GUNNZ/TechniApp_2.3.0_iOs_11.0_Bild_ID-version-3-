//
//  TraitementDeauTableViewController.m
//  KerckCharge
//
//  Created by kerckweb on 26/04/2014.
//
//

#import "TraitementDeauTableViewController.h"
#import "TeauCell.h"
#import "SWRevealViewController.h"
@interface TraitementDeauTableViewController ()

@property (nonatomic, strong) NSArray *teauData;



@end


#pragma mark -

@implementation TraitementDeauTableViewController

static NSString *MyIdentifier = @"MyIdentifier";


///////////
- (void)viewDidLoad {

_sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];

// Set the side bar button action. When it's tapped, it'll show up the sidebar.
_sidebarButton.target = self.revealViewController;
_sidebarButton.action = @selector(revealToggle:);

//////////

}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.teauData.count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // create a new TemperatureCell
    TeauCell *cell =
    (TeauCell *)[aTableView dequeueReusableCellWithIdentifier:MyIdentifier
                                                        forIndexPath:indexPath];
    
    // configure the temperature cell with the relevant data
    NSDictionary *teauDictionary = [self.teauData objectAtIndex:indexPath.row];
    [cell setTeauDataFromDictionary:teauDictionary];
    
    return cell;
}

/////////////





////////////


#pragma mark - Temperature data

- (NSArray *)teauData {
	
	if (_teauData == nil) {
		// Get the temperature data from the TemperatureData property list.
		NSString *teauDataPath = [[NSBundle mainBundle] pathForResource:@"TeauData" ofType:@"plist"];
		NSArray *array = [[NSArray alloc] initWithContentsOfFile:teauDataPath];
		self.teauData = array;
	}
	return _teauData;
}


#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    
	[super didReceiveMemoryWarning];
	self.teauData = nil;
}

@end