//
//  BRYAppDelegate.m
//  BRYSerialAnimationExample
//
//  Created by Bryan Irace on 12/19/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "BRYAppDelegate.h"
#import "BRYViewController.h"

@implementation BRYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[BRYViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
