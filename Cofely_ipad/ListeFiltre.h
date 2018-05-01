//
//  ListeFiltre.h
//  Cofely_ipad
//
//  Created by kerckweb on 17/06/2015.
//  Copyright (c) 2015 COFELY_Technibook. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Instalation;
@interface ListeFiltre : NSObject

@property (nonatomic, strong) NSString *nomfiltre;
@property (nonatomic, strong) NSString *dimentionFiltre;
@property (nonatomic, strong) Instalation *instalation;
@property (nonatomic, strong) NSNumber *displayOrder;

@end


