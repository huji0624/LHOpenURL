//
//  LHOpenURL.m
//  LHOpenURL
//
//  Created by user on 14-12-17.
//  Copyright (c) 2014年 huji. All rights reserved.
//

#import "LHOpenURL.h"
#import "LHOpenURLEntity.h"
#import "LHOpenURLHandler.h"

@implementation LHOpenURL

-(void)addSchemeHandler:(NSString *)scheme handlerName:(NSString *)hander{
    if (_schemesMap==nil) {
        _schemesMap = [NSMutableDictionary dictionary];
    }
    if (scheme&&hander) {
        [_schemesMap setObject:hander forKey:scheme];
    }else{
        NSLog(@"scheme or handlerName invalid.");
    }
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [self application:application openURL:url sourceApplication:nil annotation:nil];
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    if (!url) {
        NSLog(@"url is nil.");
        return NO;
    }
    
    LHOpenURLEntity *entity = [[LHOpenURLEntity alloc] init];
    entity.url = url;
    entity.params = [self paramsFromQuery:url];
    entity.options = options;
    entity.application = app;
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0) {
        entity.sourceApplication = options[UIApplicationOpenURLOptionsSourceApplicationKey];
        entity.annotation = options[UIApplicationOpenURLOptionsAnnotationKey];
    }
    
    return [self openWithEntity:entity];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if (!url) {
        NSLog(@"url is nil.");
        return NO;
    }
    
    LHOpenURLEntity *entity = [[LHOpenURLEntity alloc] init];
    entity.application = application;
    entity.url = url;
    entity.sourceApplication = sourceApplication;
    entity.annotation = annotation;
    entity.params = [self paramsFromQuery:url];
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0) {
        NSMutableDictionary<NSString*, id> *options = [NSMutableDictionary dictionary];
        if (sourceApplication) {
            [options setObject:sourceApplication forKey:UIApplicationOpenURLOptionsSourceApplicationKey];
        }
        if (annotation) {
            [options setObject:annotation forKey:UIApplicationOpenURLOptionsAnnotationKey];
        }
        entity.options = options;
    }
    
    return [self openWithEntity:entity];
}

-(BOOL)openWithEntity:(LHOpenURLEntity*)entity{
    NSURL *url = entity.url;
    
    if (url == nil || [url scheme] == nil || [url host] == nil) {
        return NO;
    }
    
    __block BOOL customScheme = NO;
    __block BOOL customRes = NO;
    [_schemesMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *keystr = key;
        if ([keystr isEqualToString:[url scheme]]) {
            NSString *valuestr = obj;
            customRes = [self handle:valuestr withEntity:entity];
            customScheme = YES;
            *stop = YES;
        }else{
            *stop = NO;
        }
    }];
    
    if (customScheme) {
        return customRes;
    }
    
    NSMutableString *classString = [NSMutableString string];
    [classString appendString:[[url scheme] capitalizedString]];
    [classString appendString:[[[url host] stringByReplacingOccurrencesOfString:@"." withString:@"_"] capitalizedString]];
    NSString *path = url.path;
    NSArray *pathes = [path componentsSeparatedByString:@"/"];
    for (NSString *comp in pathes) {
        [classString appendString:[comp capitalizedString]];
    }
    [classString appendString:LHOPENURL_HANDLE_SUFFIX];
    
    return [self handle:classString withEntity:entity];
}

-(BOOL)handle:(NSString*)classString withEntity:(LHOpenURLEntity*)entity{
    Class hc = NSClassFromString(classString);
    if (!hc) {
        NSLog(@"No handler %@ defined.",classString);
        return NO;
    }else{
        id<LHOpenURLHandler> handler = [[hc alloc] init];
        if ([handler conformsToProtocol:@protocol(LHOpenURLHandler)]) {
            return [handler handleLHOpenURL:entity];
        }else{
            NSLog(@"%@ did not conforms to LHOpenURLHandler.",classString);
            return NO;
        }
    }
}


-(NSDictionary*)paramsFromQuery:(NSURL*)url{
    if (!url.query) {
        NSLog(@"url query invalid.");
        return nil;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSArray *components = [url.query componentsSeparatedByString:@"&"];
    
    for (NSString *oneCom in components) {
        if (oneCom.length > 0) {
            NSArray *keyValue = [oneCom componentsSeparatedByString:@"="];
            if (keyValue.count == 2) {
                [dict setObject:keyValue[1] forKey:keyValue[0]];
            }
        }
    }
    
    return dict;
}
@end
