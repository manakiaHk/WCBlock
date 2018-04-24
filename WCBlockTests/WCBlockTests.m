//
//  WCBlockTests.m
//  WCBlockTests
//
//  Created by zhao weicheng on 2018/4/24.
//  Copyright © 2018年 weichengz. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface WCBlockTests : XCTestCase

@end

@implementation WCBlockTests

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
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
