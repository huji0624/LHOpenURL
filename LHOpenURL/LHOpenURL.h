//
//  LHOpenURL.h
//  LHOpenURL
//
//  Created by user on 14-12-17.
//  Copyright (c) 2014年 huji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 How to:
 
 1.add code in appdelegate.
 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation NS_AVAILABLE_IOS(4_2);{
     LHOpenURL *ou = [[LHOpenURL alloc] init];
     return [ou application:application openURL:[NSURL URLWithString:urlstring] sourceApplication:sourceApplication annotation:annotation];
 }
 
 2.customize your open url handler class.only host can has '.'.
 //for scheme://apple.boy/patha/pathb?p1=p&p2=q
 @interface SchemeApple_BoyPathaPathbHandler<LHOpenURLHandler>
 @end
 
 
 3.if you don't want to follow the handler name rule for some scheme.
 
 //before call [LHOpenURL application....]
 [LHOpenURL addSchemeHandler:@"somescheme" handlerName:@"someHandler"];
 
 //for somescheme://apple.boy/patha/pathb?p1=p&p2=q
 @interface someHandler<LHOpenURLHandler>
 @end
*/
#define LHOPENURL_HANDLE_SUFFIX @"Handler"

@interface LHOpenURL : NSObject
{
    NSMutableDictionary *_schemesMap;
}

- (void)addSchemeHandler:(NSString*)scheme handlerName:(NSString*)hander;


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;  // Will be deprecated at some point, please replace with application:openURL:sourceApplication:annotation:


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation NS_AVAILABLE_IOS(4_2); // no equiv. notification. return NO if the application can't open for some reason

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options;

@end
