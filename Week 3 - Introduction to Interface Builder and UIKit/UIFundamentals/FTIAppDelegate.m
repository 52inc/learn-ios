//
//  FTIAppDelegate.m
//  UIFundamentals
//
//  Created by Brendan Lee on 6/25/14.
//  Copyright (c) 2014 52Inc. All rights reserved.
//

#import "FTIAppDelegate.h"
#import "FTIViewController.h"

@implementation FTIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //For more information on programmatically creating view controllers and windows in code, see Week 2's video.
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //**************************************************************************
    // TO LOAD FROM XIB FILE:
    //      Comment out this next line to do manual loading of views or to use Storyboards.
    //      Only use 1 of the 'controller' creation lines. Comment out those not in use.
    //**************************************************************************
    
    //FTIViewController *controller = [[FTIViewController alloc] initWithNibName:@"FTIViewController" bundle:nil];
    
    //**************************************************************************
    // TO LOAD FROM CODE:
    //      Uncomment out this next line to do manual loading of views from -loadView and -viewWillLayoutSubviews.
    //      Make sure you uncomment those methods in FTIViewController if you do this! If you don't override -loadSubviews it will automatically attempt to load the XIB file. Also: Never rely on that behavior. Explicitly specify where you want things to come from.
    //      Only use 1 of the 'controller' creation lines. Comment out those not in use.
    //**************************************************************************
    
    //FTIViewController * controller = [[FTIViewController alloc] init];
    
    //**************************************************************************
    // TO LOAD FROM STORYBOARD:
    //      Uncomment out this next line to load the controller from Storyboard.
    //      Only use 1 of the 'controller' creation lines. Comment out those not in use.
    //**************************************************************************
    
    FTIViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    
    
    
    //Don't modify below here.
    _window.rootViewController = controller;
    
    [_window makeKeyAndVisible];
    
    return YES;
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
