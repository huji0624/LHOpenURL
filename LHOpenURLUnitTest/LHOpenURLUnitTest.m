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
@interface NSString (URLEncode)
@end
@implementation NSString (URLEncode)
- (NSString *)URLDecode
{
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)URLEncode
{
    return [self urlEncodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding)));
}
@end

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



- (void)testUrlPath{
    NSString *urlValue = @"http://wiki.intra.xiaojukeji.com/pages/viewpage.action?pageId=98852671&type=7";
//    NSString *urlValue = @"http%3A%2F%2Fwiki.intra.xiaojukeji.com%2Fpages%2Fviewpage.action%3FpageId%3D98852671%26type%3D7";
    NSString *orignStr = [NSString stringWithFormat:@"unidriver://web?url=%@&name=chan", urlValue.URLEncode];
    
    NSURL *url = [NSURL URLWithString:orignStr];
    NSDictionary *d = [[[LHOpenURL alloc] init] paramsFromQuery:url];
    
    NSString *urldecode = [d[@"url"] URLDecode];
    NSAssert([d[@"name"] isEqualToString:@"chan"], @"par1 parse fail.");
    NSAssert([urldecode isEqualToString:urlValue], @"par2 parse fail.");
}
- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
//    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *orignStr = @"test://some/path?p1=1&p2=2&p3=string_in_par3";
    
    NSURL *url = [NSURL URLWithString:orignStr];
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

