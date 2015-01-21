//
//  LHOpenURLHandler.h
//  LHOpenURL
//
//  Created by user on 14-12-17.
//  Copyright (c) 2014年 huji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHOpenURLEntity.h"

@protocol LHOpenURLHandler <NSObject>
-(BOOL)handleLHOpenURL:(LHOpenURLEntity*)entity;
@end
