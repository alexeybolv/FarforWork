//
//  AppDelegate.m
//  FarforWork
//
//  Created by Алексей on 16.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import "AppDelegate.h"
#import "OfferParser.h"
#import "Offer.h"
#import "CategoryParser.h"
#import "Category.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"startParsing"
             object:nil];
        });
        [self parseCategory];
        [self parseOffer];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"finishParsing"
             object:nil];
        });
    });
    return YES;
}

#pragma mark - Parsing Offer

-(void) parseOffer{
    self.offerArray = [[NSMutableArray alloc]init];
    OfferParser *offerParser = [[OfferParser alloc]initWithArray:self.offerArray];
    [offerParser parseXMLFile];
}

#pragma mark - Parsing Category

-(void) parseCategory{
    self.categoryArray = [[NSMutableArray alloc]init];
    CategoryParser *categoryParser = [[CategoryParser alloc]initWithArray:self.categoryArray];
    [categoryParser parseXMLFile];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
