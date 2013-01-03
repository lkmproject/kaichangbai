//
//  AppDelegate.m
//  KaiChangBai
//
//  Created by kwongming lau on 12-12-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "IndexViewController.h"
#import "MobClick.h"
@implementation AppDelegate

@synthesize window = _window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    IndexViewController *indexViewController = [[IndexViewController alloc] init];
    UINavigationController *navIndex = [[UINavigationController alloc] initWithRootViewController:indexViewController];
    self.window.rootViewController = navIndex;
    
   // [MobClick startWithAppkey:@"50e54bb55270151a14000020" reportPolicy:REALTIME channelId:nil];
    [MobClick startWithAppkey:@"50e54bb55270151a14000020"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
   
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}


@end
