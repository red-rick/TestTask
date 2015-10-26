//
//  COTVideoStoreTest.m
//  CodemindersTask
//
//  Created by Dmytro Benedyk on 10/26/15.
//  Copyright © 2015 Benedyk Dmytro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "COTVideoStore.h"

@interface COTVideoStoreTest : XCTestCase

@property (nonatomic, strong) COTVideoStore *videoStore;

@end

@implementation COTVideoStoreTest

- (void)setUp 
{
    self.videoStore = [COTVideoStore new];
    [super setUp];
}

- (void)tearDown 
{
    self.videoStore = nil;
    [super tearDown];
}

- (void)test_videStore 
{
    NSDictionary *theDictionary = @{@"theKey":@"video"};
    NSIndexPath *theIndexPath1 = [NSIndexPath indexPathForItem:0 inSection:0];
    NSIndexPath *theIndexPath2 = [NSIndexPath indexPathForItem:0 inSection:1];
    
    [self.videoStore setVideoInfo:theDictionary forIndexPath:theIndexPath1];
    NSDictionary *theReceivedDictionary1 = [self.videoStore videoInfoForIndexPath:theIndexPath1];
    NSDictionary *theReceivedDictionary2 = [self.videoStore videoInfoForIndexPath:theIndexPath2];
    
    XCTAssertTrue([theDictionary isEqualToDictionary:theReceivedDictionary1], @"Store returned wrong dictionary");
    XCTAssertTrue(theReceivedDictionary2 == nil, @"Store has to return nil value");
    
}


@end
