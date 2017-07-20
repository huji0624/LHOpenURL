//
//  LHOpenURLUnitTest.m
//  LHOpenURLUnitTest
//
//  Created by __huji on 20/7/17.
//  Copyright © 2017年 huji. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LHOpenURL_UnitTest.h"
#import "LHOpenURL.h"

@interface LHOpenURLUnitTest : XCTestCase

@end

@implementation LHOpenURLUnitTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSURL *url = [NSURL URLWithString:@"test://some/path?p1=1&p2=2&p3=\"string_in_par3\""];
    NSDictionary *d = [[[LHOpenURL alloc] init] paramsFromQuery:url];
    NSAssert([d[@"p1"] isEqualToString:@"1"], @"par1 parse fail.");
    NSAssert([d[@"p2"] isEqualToString:@"2"], @"par2 parse fail.");
    NSAssert([d[@"p3"] isEqualToString:@"string_in_par3"], @"par3 parse fail.");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
