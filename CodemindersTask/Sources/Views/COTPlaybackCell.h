//
//  COTPlaybackCell.h
//  CodemindersTask
//
//  Created by Dmytro Benedyk on 10/24/15.
//  Copyright © 2015 Benedyk Dmytro. All rights reserved.
//

#import "COTGridCell.h"

@protocol COTPlaybackCellDelegate;

@interface COTPlaybackCell : COTGridCell

@property (nonatomic, weak) id<COTPlaybackCellDelegate> delegate;

- (void)setPrevieImage:(UIImage *)anImage;

@end


@protocol COTPlaybackCellDelegate <NSObject>

@optional
- (void)playbackCellStartCapturing:(COTPlaybackCell *)aCell;
- (void)playbackCellEndCapturing:(COTPlaybackCell *)aCell;

@end