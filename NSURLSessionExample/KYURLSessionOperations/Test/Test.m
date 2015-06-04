//
//  Test.m
//  KYURLSessionOperations
//
//  Created by kaushal on 6/4/15.
//  Copyright (c) 2015 vStacks Infotech Pvt Ltd. All rights reserved.
//





#import <XCTest/XCTest.h>
#import "KYURLSessionOperations.h"
@interface Test : XCTestCase
@property (nonatomic,strong)NSOperationQueue *queue;
@property (nonatomic,strong)NSURLSession *session;

@end



@implementation Test

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _queue=[[NSOperationQueue alloc]init];
    _queue.maxConcurrentOperationCount=1;
    _session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
}
-(void)test{
    NSArray *arrayURLs=@[[NSURL URLWithString:@"http://api.healthians.com/home/navigation" ],[NSURL URLWithString:@"http://api.healthians.com/hplus/gethqquestion"]];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [_queue addOperation:[[KYURLSessionOperations alloc] initWithSession:_session request:[NSURLRequest requestWithURL:arrayURLs[0]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        XCTAssert(result.count == 0);
        [result addObject:response.URL];
    }]];
    
    [_queue addOperation:[[KYURLSessionOperations alloc] initWithSession:_session URL:arrayURLs[1] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [result addObject:response.URL];
    }]];
    
    [_queue waitUntilAllOperationsAreFinished];
    
    XCTAssertEqualObjects(arrayURLs, result);
}
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
