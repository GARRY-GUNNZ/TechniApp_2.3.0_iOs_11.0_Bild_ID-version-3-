//
//  Instalation.h
//  Cofely_ipad
//
//  Created by kerckweb on 10/03/2015.
//  Copyright (c) 2015 COFELY_Technibook. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CloudKit/CloudKit.h>

@class Equipement;


@interface Instalation : NSObject

/*! block note  */

@property (nonatomic, strong) NSString *contrat;
@property (nonatomic, strong) NSString *instructions; // block note
/*! nom batiment de l'instalation  */
@property (nonatomic, strong) NSString *nomBatiment; // nom batiment de l'instalation
/*! nom instalation  */
@property (nonatomic, strong) NSString *nomInstalation; // nom instalation
/*! réference instalation  */
@property (nonatomic, strong) NSString *reference; // réference instalation
/*! marque instalation@parm essais ; @return Marque  Parse ;  */
@property (nonatomic, strong) NSString *marque; // marque instalation
/*! Image de l instalation @parm essais ; @return Avatar Parse ;   */
//@property (nonatomic, strong) PFImageView *imageFile; // Image de l instalation
@property (nonatomic, strong) CKAsset *imageFile;
/*! @brief ingredients    @param  consomable filtre courroies , @return essais
 */
@property (nonatomic, strong) NSArray *consomable; // ingredients

@property (nonatomic, strong) NSSet *filtres;


 /// convertir en context parse /////
- (void)addFiltres:(NSSet *)value;
- (void)removeIngredients:(NSSet *)value;
@end
