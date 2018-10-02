//
//  AppDelegate.m
//  Cofely_ipad
//
//  Created by COFELY_Technibook on 07/08/2014.
//  Copyright (c) 2014 COFELY_Technibook. All rights reserved.
//

#import "AppDelegate.h"
#import <CloudKit/CloudKit.h>

@implementation AppDelegate
//@synthesize value;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions




{
    
    // AJOUT D UN MESSAGE ALERTE 
    
    /*
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([[NSFileManager defaultManager]
             URLForUbiquityContainerIdentifier:nil] != nil)
            NSLog(@"iCloud is available\n");
        else
            NSLog(@"This Application requires iCloud, but it is not available.\n");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert Connexion"
                                                        message:@"Crée un compte iCloud pour pouvoir Utilser le TechniApp rendez-vous dans l'application Réglage, Compte iCloud"
                                                       delegate:self
                                              cancelButtonTitle:@"j'ai déja un compte iCloud"
                                              otherButtonTitles:@"Ok",nil];
        [alert show];
      
        
        
    });


    */

    
    
    
    // Register for push notifications
  /*
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge
              categories:nil];
    
    [application registerUserNotificationSettings:notificationSettings];
    [application registerForRemoteNotifications];
    
    
    
    
    CKModifyBadgeOperation *badgeResetOperation = [[CKModifyBadgeOperation alloc] initWithBadgeValue:0];
    [badgeResetOperation setModifyBadgeCompletionBlock:^(NSError * operationError) {
        if (!operationError) {
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
    }];
    
   ;
   
    
    [[CKContainer containerWithIdentifier:@"iCloud.kerck.TechniApp"] addOperation:badgeResetOperation];
    
    */
    
    
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    // Change the font style of the navigation bar
  
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 0);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:10.0/255.0
                                                                           green:10.0/255.0
                                                                            blue:10.0/255.0
                                                                           alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"verdana"
                                                                           size:21.0],
                                                           NSFontAttributeName, nil]];
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
    
    
    CKNotification *cloudKitNotification = [CKNotification notificationFromRemoteNotificationDictionary:userInfo];
   // NSString *alertBody = cloudKitNotification.alertBody;
    
    if (cloudKitNotification.notificationType == CKNotificationTypeQuery) {
      //  CKRecordID *recordID = [(CKQueryNotification *)cloudKitNotification recordID];
    }
}

















- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
