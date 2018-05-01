//
//  TeauCell.h
//  KerckCharge
//
//  Created by kerckweb on 26/04/2014.
//
//

@interface TeauCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *eaudevilleLabel;
@property (nonatomic, strong) IBOutlet UILabel *valeurLabel;
@property (nonatomic, strong) IBOutlet UILabel *reseauLabel;

- (void)setTeauDataFromDictionary:(NSDictionary *)teauDictionary;

@end
