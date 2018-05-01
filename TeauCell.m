//
//  TeauCell.m
//  KerckCharge
//
//  Created by kerckweb on 26/04/2014.
//
//

#import "TeauCell.h"

@implementation TeauCell 

- (void)setTeauDataFromDictionary:(NSDictionary *)teauDictionary {
    
    // update text in labels from the dictionary
    self.eaudevilleLabel.text = [teauDictionary objectForKey:@"c"];
    self.valeurLabel.text = [teauDictionary objectForKey:@"f"];
    self.reseauLabel.text = [teauDictionary objectForKey:@"g"];
}

@end
