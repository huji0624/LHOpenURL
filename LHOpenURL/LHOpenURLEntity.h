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
@property(nonatomic,strong) UIApplication *application;
@property(nonatomic,strong) NSURL *url;
@property(nonatomic,strong) NSString *sourceApplication;
@property(nonatomic,weak) id annotation;
@property(nonatomic,strong) NSDictionary<NSString*, id> * options;

//data parsed from url query.
@property(nonatomic,strong) NSDictionary *params;
@end
