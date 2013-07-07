//
//  HelloAppDelegate.m
//  Hello
//
//  Created by 市岡 侑子 on 13/05/10.
//  Copyright (c) 2013年 Yuko Ichioka. All rights reserved.
//

#import "HelloAppDelegate.h"
#import "HelloViewController.h"
#import "SecondViewController.h"

@implementation HelloAppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //windowを用意している
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    //用意したwindowに載せる、Viewcontrollerを初期化して用意している
    UIViewController *helloViewController = [[HelloViewController alloc]initWithNibName:nil bundle:nil];
    
    //２つ目のViewControllerであるところの、SecondViewControllerを初期化して用意する
    UIViewController *secondViewController = [[SecondViewController alloc] init];
    
    //NSArrayの生成(Xcode 4.4)
    //NSArray *colors = @[@"orange", @"Yellow", `"Green"]; //nilは不要
    NSArray *tabBarControllers = @[helloViewController, secondViewController];
    
    //上で渡しちゃったので、helloViewControllerは用済みなのでリリースする
    [helloViewController release];
    [secondViewController release];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:tabBarControllers animated:NO];
    

    //helloviewControllerをwindowのrootViewControllerにわたす
    self.window.rootViewController = tabBarController;
    [tabBarController release];
    
    
    //self.window.backgroundColor = [UIColor whiteColor];
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
