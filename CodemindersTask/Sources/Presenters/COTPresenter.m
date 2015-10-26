//
//  COTPresenter.m
//  CodemindersTask
//
//  Created by Dmytro Benedyk on 10/24/15.
//  Copyright © 2015 Benedyk Dmytro. All rights reserved.
//

#import "COTPresenter.h"
#import "PBJVideoPlayerController.h"
#import "PBJVision.h"
#import "COTVideoStore.h"
#import "COTPlaybackCell.h"

const NSInteger kCOTPresenterDefaultNumerOfCells = 9;
const NSInteger kCOTPresenterDefaultCellsPerRow = 3;
const CGFloat kCOTPresenterDefaultSpaceBetweeenCells = 10.0;

@interface COTPresenter()<PBJVideoPlayerControllerDelegate, PBJVisionDelegate,
    COTPlaybackCellDelegate>

@property (nonatomic, strong) PBJVideoPlayerController *videoPlayerController;
@property (nonatomic, strong) COTVideoStore *videoStore;
@property (nonatomic, weak) UIViewController *rootViewController;
@property (nonatomic, strong) COTPlaybackCell *playbackCell;

- (CGFloat)gridItemWidthForViewFrame:(CGRect)aViewFrame;
- (CGFloat)gridItemHeightForViewFrame:(CGRect)aViewFrame;

@end


@implementation COTPresenter

@synthesize cellsPerRow;
@synthesize numberOfCells;
@synthesize spaceBetweenCells;
@synthesize videoPlayerController;
@synthesize rootViewController;
@synthesize videoStore;

- (instancetype)initWithRooViewController:(UIViewController *)aController
{
    self = [super init];
    if (nil != self)
    {
        cellsPerRow = kCOTPresenterDefaultCellsPerRow;
        numberOfCells = kCOTPresenterDefaultNumerOfCells;
        spaceBetweenCells = kCOTPresenterDefaultSpaceBetweeenCells;
        rootViewController = aController;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithRooViewController:
            [[[UIApplication sharedApplication].windows firstObject] 
             rootViewController]];
}

- (CGSize)gridCellSizeForViewFrame:(CGRect)aViewFrame
{
    return CGSizeMake([self gridItemWidthForViewFrame:aViewFrame],
                      [self gridItemHeightForViewFrame:aViewFrame]);
}

- (UIEdgeInsets)gridInsetsForViewFrame:(CGRect)aViewFrame
{
    CGFloat theHeight = CGRectGetHeight(aViewFrame);
    CGFloat theVerticalOffset = ceilf((theHeight - 
        [self gridItemHeightForViewFrame:aViewFrame] * 
        self.numberOfCells / self.cellsPerRow) / 2.0);
    
    
    return UIEdgeInsetsMake(theVerticalOffset, self.spaceBetweenCells, 
                            theVerticalOffset, self.spaceBetweenCells);
}

- (nonnull UICollectionViewCell *)gridCellInCollectionView:(nonnull UICollectionView *)aCollectionView
                                              forIndexPath:(nonnull NSIndexPath *)anIndexPath
{
    static NSString *sStreamingCellIdentifier = @"StreamingCell";
    static NSString *sPlaybackCellIdentifier = @"PlaybackCell";
    
    NSInteger theMiddleItem = self.numberOfCells / 2;
    
    if (anIndexPath.item  == theMiddleItem)
    {
        return [aCollectionView dequeueReusableCellWithReuseIdentifier:sStreamingCellIdentifier 
                                                          forIndexPath:anIndexPath];
    }
    COTPlaybackCell *theCell = (COTPlaybackCell *)[aCollectionView 
        dequeueReusableCellWithReuseIdentifier:sPlaybackCellIdentifier 
                                  forIndexPath:anIndexPath];
    theCell.tag = anIndexPath.item;
    theCell.delegate = self;
    return theCell;
}


- (void)playVideoForItem:(nonnull UIView *)aView 
             atIndexPath:(nonnull NSIndexPath *)anIndexPath
{
    self.videoPlayerController.videoPath = 
        [self.videoStore videoInfoForIndexPath:anIndexPath][PBJVisionVideoPathKey];
    self.videoPlayerController.view.frame = aView.bounds;
    [aView addSubview:self.videoPlayerController.view];
    
    [self.videoPlayerController playFromBeginning];
}

#pragma mark - Properties

- (PBJVideoPlayerController *)videoPlayerController
{
    if (nil == videoPlayerController)
    {
        videoPlayerController = [[PBJVideoPlayerController alloc] init];
        videoPlayerController.delegate = self;
        videoPlayerController.videoFillMode = AVLayerVideoGravityResizeAspectFill;
        [self.rootViewController addChildViewController:videoPlayerController];
        [videoPlayerController didMoveToParentViewController:self.rootViewController];
    }
    
    return videoPlayerController;
}

- (COTVideoStore *)videoStore
{
    if (nil == videoStore)
    {
        videoStore = [COTVideoStore new];
    }
    
    return videoStore;
}

#pragma mark - Private

- (CGFloat)gridItemWidthForViewFrame:(CGRect)aViewFrame
{
    return ceilf((CGRectGetWidth(aViewFrame) -
        (self.cellsPerRow + 2) * self.spaceBetweenCells) / self.cellsPerRow);
}

- (CGFloat)gridItemHeightForViewFrame:(CGRect)aViewFrame
{
    return ceilf([self gridItemWidthForViewFrame:aViewFrame] * 4.0 / 3.0);
}

- (void)setupStreaming
{
    PBJVision *theVision = [PBJVision sharedInstance];
    theVision.delegate = self;
    theVision.cameraMode = PBJCameraModeVideo;
    theVision.cameraOrientation = PBJCameraOrientationPortrait;
    theVision.focusMode = PBJFocusModeContinuousAutoFocus;
    theVision.outputFormat = PBJOutputFormatPreset;
    
    [theVision startPreview];
}

#pragma mark - PBJViedeoControllerDeleagate

- (void)videoPlayerReady:(PBJVideoPlayerController *)videoPlayer
{

}

- (void)videoPlayerPlaybackStateDidChange:(PBJVideoPlayerController *)videoPlayer
{
    
}

- (void)videoPlayerPlaybackWillStartFromBeginning:(PBJVideoPlayerController *)videoPlayer
{

}

- (void)videoPlayerPlaybackDidEnd:(PBJVideoPlayerController *)videoPlayer
{
    [self.videoPlayerController.view removeFromSuperview];
}

#pragma mark - PBJVisionDelegate

- (void)vision:(PBJVision *)vision 
    capturedVideo:(nullable NSDictionary *)videoDict 
         error:(nullable NSError *)error;
{
    NSIndexPath *theIndexPath = [NSIndexPath indexPathForItem:self.playbackCell.tag 
                                                    inSection:0];
    [self.videoStore setVideoInfo:videoDict forIndexPath:theIndexPath];
    [self.playbackCell setPrevieImage:videoDict[PBJVisionVideoThumbnailKey]];
    self.playbackCell = nil;
}

#pragma mark - COTPlaybackCellDelegate

- (void)playbackCellEndCapturing:(COTPlaybackCell *)aCell
{
    [[PBJVision sharedInstance] endVideoCapture];
}

- (void)playbackCellStartCapturing:(COTPlaybackCell *)aCell
{
    self.playbackCell = aCell;
    [[PBJVision sharedInstance] startVideoCapture];
}

@end
