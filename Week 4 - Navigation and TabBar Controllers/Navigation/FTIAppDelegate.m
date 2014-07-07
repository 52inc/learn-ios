//
//  FTIAppDelegate.m
//  Navigation
//
//  Created by Brendan Lee on 7/6/14.
//  Copyright (c) 2014 52inc. All rights reserved.
//

#import "FTIAppDelegate.h"
#import "FTINumberedViewController.h"

@implementation FTIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    //Create your View Controller. If you want it to support navigation controller operations, set it as the root view controller of the nav controller and use the navigation controller as the rootViewController of the window, or as an element in the tabbar. Note: Navigation controllers are NOT required to put a VC in the tabbar.
    
    FTINumberedViewController *controller = [[FTINumberedViewController alloc] initWithNibName:@"FTINumberedViewController" bundle:nil];
    controller.screenNumber = 0;
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:controller];
    
    FTINumberedViewController *controller2 = [[FTINumberedViewController alloc] initWithNibName:@"FTINumberedViewController" bundle:nil];
    controller2.screenNumber = 0;
    UINavigationController *navigation2 = [[UINavigationController alloc] initWithRootViewController:controller2];

    
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    tabbar.viewControllers = @[navigation, navigation2];
    
    self.window.rootViewController = tabbar;

    [self.window makeKeyAndVisible];
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
