//
//  COTPresenterTests.m
//  CodemindersTask
//
//  Created by Dmytro Benedyk on 10/25/15.
//  Copyright © 2015 Benedyk Dmytro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "COTPresenter.h"
#import "COTGridCell.h"
#import "COTStreamingCell.h"
#import "COTPlaybackCell.h"

@interface COTPresenterTests : XCTestCase <UICollectionViewDataSource>

@property (nonatomic, strong) COTPresenter *presenter;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation COTPresenterTests

- (void)setUp 
{
    [super setUp];

    self.presenter = [COTPresenter new];
    self.presenter.spaceBetweenCells = 15.0;
    self.presenter.numberOfCells = 15;
    self.presenter.cellsPerRow = 5;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, 1000.0, 1000.0) 
                                             collectionViewLayout: [[UICollectionViewFlowLayout alloc] init]];
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[COTStreamingCell class] forCellWithReuseIdentifier:@"StreamingCell"];
    [self.collectionView registerClass:[COTPlaybackCell class] forCellWithReuseIdentifier:@"PlaybackCell"];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return [self.presenter gridCellInCollectionView:collectionView forIndexPath:indexPath];
}

#pragma mark -

- (void)tearDown 
{
    [super tearDown];
    self.presenter = nil;
}

- (void)test_presenterItemSize00 
{
    CGSize theSize = [self.presenter gridCellSizeForViewFrame:CGRectMake(0.0, 0.0, 1000.0, 1000.0)];
    CGSize theExpectedSize = CGSizeMake(179.0, 239.0);
    XCTAssertTrue(CGSizeEqualToSize(theSize, theExpectedSize), @"Wrong text size");
}

- (void)test_presenterGridInset00
{
    UIEdgeInsets theInsets = [self.presenter gridInsetsForViewFrame:CGRectMake(0.0, 0.0, 1000.0, 1000.0)];
    UIEdgeInsets theExpectedInsets = UIEdgeInsetsMake(142, 15, 142, 15);
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(theInsets, theExpectedInsets), @"Wrong insets");
}

- (void)test_presenterGridCell00
{
    NSIndexPath *theIndexPath = [NSIndexPath indexPathForItem:7 inSection:0];
    UICollectionViewCell *theCell = [self.presenter gridCellInCollectionView:self.collectionView forIndexPath:theIndexPath];
    NSIndexPath *theIndexPath2 = [NSIndexPath indexPathForItem:8 inSection:0];
    UICollectionViewCell *theCell2 = [self.presenter gridCellInCollectionView:self.collectionView forIndexPath:theIndexPath2];
    XCTAssertTrue([theCell isKindOfClass:[COTStreamingCell class]], @"It hast to be streming cell in the middle");
    XCTAssertTrue([theCell2 isKindOfClass:[COTPlaybackCell class]], @"Wrong cell - has to be playback cell");
}


@end
