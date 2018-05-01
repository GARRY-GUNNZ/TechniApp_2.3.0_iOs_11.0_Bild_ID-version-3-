/*
     File: IngredientDetailViewController.m
 Abstract: Table view controller to manage editing details of a recipe ingredient -- its name and amount.
 
  Version: 1.5
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 
 */


#import "IngredientDetailViewController.h"
#import "ListeFiltre.h"
#import "Instalation.h"
#import "EditingTableViewCell.h"
#import "SVProgressHUD.h"
#import "AddInstallationViewController.h"
#import "MBProgressHUD.h"
#import "CHViewController.h"
#include "AddInstallationViewController.h"
@interface IngredientDetailViewController ()

// table's data source
@property (nonatomic, strong) NSString *dimention;
@property (nonatomic, strong) NSString *type;

@end

// view tags for each UITextField
#define kIngredientFieldTag     1
#define kAmountFieldTag         2

static NSString *IngredientsCellIdentifier = @"IngredientsCell";


@implementation IngredientDetailViewController


- (void)viewDidLoad {
    
	[super viewDidLoad];
    
	self.title = @"Type d'Equipements";
    
    self.tableView.allowsSelection = NO;
	self.tableView.allowsSelectionDuringEditing = NO;
}

- (void)setListeFiltre:(ListeFiltre *)listeFiltre {
    
    _listeFiltre = listeFiltre ;
    
    _dimention = listeFiltre.nomfiltre;
    _type = listeFiltre.dimentionFiltre;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EditingTableViewCell *cell =
        (EditingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:IngredientsCellIdentifier
                                                                forIndexPath:indexPath];
    if (indexPath.row == 0) {
        // cell ingredient name
        cell.label.text = @"Dimention";
        cell.textField.text = self.dimention;
        cell.textField.placeholder = @"Saisir les dimentions";
        cell.textField.tag = kIngredientFieldTag;
    }
	else if (indexPath.row == 1) {
        // cell ingredient amount
        cell.label.text = @"Type";
        cell.textField.text = self.type;
        cell.textField.placeholder = @"Saisir type";
        cell.textField.tag = kAmountFieldTag;
    }

    return cell;
}


#pragma mark - Save and cancel

- (IBAction)save:(id)sender {
  
    
    
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    // editing has ended in one of our text fields, assign it's text to the right
    // ivar based on the view tag
    //
    switch (textField.tag)
    {
        case kIngredientFieldTag:
            self.dimention = textField.text;
            break;
            
        case kAmountFieldTag:
            self.type = textField.text;
            break;
    }
}

@end
