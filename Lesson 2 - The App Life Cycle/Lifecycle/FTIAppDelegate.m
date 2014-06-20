//
//  FTIAppDelegate.m
//  Lifecycle
//
//  Created by Brendan Lee on 6/18/14.
//  Copyright (c) 2014 52Inc. All rights reserved.
//

#import "FTIAppDelegate.h"
#import "FTIViewController.h"

@implementation FTIAppDelegate

/**
 Because of the sentence-like naming convention of Objective-C methods, you probably already know what the method below does.
 
 This method is named -application:didFinishLaunchingWithOptions:.
 
 Remember in the first video we discuss protocols? Then we used them to show we implemented a method so that we could return or pass a value. Protocols are also used to notify an object when an event occurs. This is known as the 'Delegate' pattern. 
 
 The concept of delegates is extraordinary in its simplicity, but not always the easiest thing to initially grasp.
 
 In CocoaTouch (the UI layer on iOS) and Foundation (Apple's framework that provides common use objects), many objects have a -delegate property. That is, a property that can hold any generic object of your choosing...as long as it implements the protocol the original object wants to use.
 
 The class we're currently in is the "App Delegate". It's a subclass of NSObject that implements the 'UIApplicationDelegate" protocol. UIApplication (your app's instance) has a -delegate property, where any object can be assigned to it as long as it implements the UIApplicationDelegate protocol.
 
 The UIApplicationDelegate protcol has several methods that are called when your app has important app-wide events that occur. Because you implement the protocol, the UIApplication instance knows that when it calls the method -application:didFinishLaunchingWithOptions:, that your custom subclass will have implmented that method.
 
 As you can see below, a handful of methods (all from UIApplicationDelegate protocol) have been implemented for us...but, they don't do anything. They serve purely as event callbacks right now, unless we choose to do something with them.
 
 In this tutorial, we're going to add log statements into key methods throughout this 'starter' template and see what the app lifecycle is like.
 */

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    /**
     Typically additional work will be done here. Things like deciding to show a login screen or load the main app, setting up theme colors, kicking off updating of data from an API, etc.
     
     If you aren't using Storyboards, substantially more work will be done here so that you can manually setup your UI and window.
     */
    
    NSLog(@"Application did finish launching with options.");
    
    //_window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    /**
     Programmatically create a view controller and set it as the window's root VC from a single xib file.
    
    FTIViewController *controller = [[FTIViewController alloc] initWithNibName:@"FTIViewController" bundle:nil];
    
    _window.rootViewController = controller;
     */
    
    /**
     Programmatically create the first view controller of a storyboard and set it as the root VC for the window.
     
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    FTIViewController *controller = [storyboard instantiateInitialViewController];
    
    _window.rootViewController = controller;
     
     */
    
    /**
     Programmatically create the view controller with no interface builder support.
    
    FTIViewController *controller = [[FTIViewController alloc] init];
    
    controller.view.backgroundColor = [UIColor redColor];
    
    _window.rootViewController = controller;
     
     */
    
    //[_window makeKeyAndVisible];
    
    NSLog(@"Application did finish launching with options. -END");

    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    NSLog(@"Application will resign active.");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"Application did enter background.");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"Application will enter foreground.");
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"Application did become active.");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    NSLog(@"Application will terminate.");
}

@end
