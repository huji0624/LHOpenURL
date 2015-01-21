//
//  LHOpenURLEntity.h
//  LHOpenURL
//
//  Created by user on 14-12-17.
//  Copyright (c) 2014年 huji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LHOpenURLEntity : NSObject
@property(nonatomic,weak) UIApplication *application;
@property(nonatomic,weak) NSURL *url;
@property(nonatomic,weak) NSString *sourceApplication;
@property(nonatomic,weak) id annotation;

//data parsed from url query.
@property(nonatomic,weak) NSDictionary *params;
@end
