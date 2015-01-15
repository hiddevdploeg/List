//
//  OCTAppDelegate.m
//  Todoo
//
//  Created by Hidde van der Ploeg on 11-07-14.
//  Copyright (c) 2014 Octoo Apps. All rights reserved.
//

#import "OCTAppDelegate.h"
#import "OCTListViewController.h"

@implementation OCTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //[UIApplication sharedApplication].applicationSupportsShakeToEdit = NO;
    
    self.window.backgroundColor = [UIColor colorWithRed:0.2 green:0.5 blue:0.8 alpha:1.0];
    
    UIViewController *viewController = [[OCTListViewController alloc]init];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:viewController];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
