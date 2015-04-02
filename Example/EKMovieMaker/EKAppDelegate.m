//
//  EKAppDelegate.m
//  EKMovieMaker
//
//  Created by CocoaPods on 03/27/2015.
//  Copyright (c) 2014 Ekhoo. All rights reserved.
//

#import "EKAppDelegate.h"
#import "EKViewController.h"

@implementation EKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    EKViewController *rootViewController  = [EKViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
