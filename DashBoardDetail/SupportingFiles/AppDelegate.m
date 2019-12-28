//
//  AppDelegate.m
//  dashBoardDetail
//
//  Created by Planet on 2/17/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import "AppDelegate.h"
#import "APIManager.h"
#import "ModelManager.h"
#import <MoEngage.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[APIManager APIManager] initializeNetworkObject];
    [ModelManager initializeModelManager];
    // Separate initialization methods for Dev and Prod initializations
    // openDeeplinkUrlAutomatically tells us whether you want the SDK to call handleOpenUrl for deeplinks specified while creating a campaign
#ifdef DEBUG
    [[MoEngage sharedInstance] initializeDevWithApiKey:@"YH8IDWGG3QSB923GTDN7BRP9" inApplication:application withLaunchOptions:launchOptions openDeeplinkUrlAutomatically:YES];
#else
    [[MoEngage sharedInstance] initializeProdWithApiKey:@"YH8IDWGG3QSB923GTDN7BRP9" inApplication:application withLaunchOptions:launchOptions openDeeplinkUrlAutomatically:YES];
#endif
    //Rest of the implementation of method
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[MoEngage sharedInstance] stop:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[MoEngage sharedInstance] applicationWillEnterForeground:application];

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[MoEngage sharedInstance] applicationBecameActiveinApplication:application];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[MoEngage sharedInstance] applicationTerminated:application];
}


@end
