//
//  AppDelegate.m
//  ALLocalizedExample
//
//  Created by Lobanov Aleksey on 30.04.14.
//  Copyright (c) 2014 Lobanov Aleksey. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // language settings
    [[ALLocalizedManager sharedInstance] setLanguages:@[ @{@"ru": @"Русский"}, @{@"en": @"English"} ]];
    [[ALLocalizedManager sharedInstance] setDefaultLanguage:@"ru"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *controller = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
