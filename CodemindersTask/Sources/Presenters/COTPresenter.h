//
//  COTPresenter.h
//  CodemindersTask
//
//  Created by Dmytro Benedyk on 10/24/15.
//  Copyright © 2015 Benedyk Dmytro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface COTPresenter : NSObject

- (nullable instancetype)initWithRooViewController:(nonnull UIViewController *)aController;

//! Geometry
@property (nonatomic) CGFloat spaceBetweenCells;
@property (nonatomic) NSUInteger numberOfCells;
@property (nonatomic) NSUInteger cellsPerRow;

- (CGSize)gridCellSizeForViewFrame:(CGRect)aViewFrame;

- (UIEdgeInsets)gridInsetsForViewFrame:(CGRect)aViewFrame;

//! Video
- (void)setupStreaming;
- (void)playVideoForItem:(nonnull UIView *)aView 
             atIndexPath:(nonnull NSIndexPath *)anIndexPath;

//!Views
- (nonnull UICollectionViewCell *)gridCellInCollectionView:(nonnull UICollectionView *)aCollectionView
                                              forIndexPath:(nonnull NSIndexPath *)anIndexPath;

@end
