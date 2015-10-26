//
//  COTPlaybackCell.m
//  CodemindersTask
//
//  Created by Dmytro Benedyk on 10/24/15.
//  Copyright © 2015 Benedyk Dmytro. All rights reserved.
//

#import "COTPlaybackCell.h"

@interface COTPlaybackCell()

@property (nonatomic, weak) IBOutlet UIImageView *previewImageView;

@end

@implementation COTPlaybackCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.contentView.layer.borderWidth = 1.0;
    self.previewImageView.hidden = YES;
    self.contentView.layer.borderColor = [UIColor blueColor].CGColor;
    self.contentView.backgroundColor = [self defaultBackgroundColor];
    UILongPressGestureRecognizer *theLongPress = [[UILongPressGestureRecognizer alloc] 
                                                  initWithTarget:self action:@selector(handleLongPress:)];
    [self.contentView addGestureRecognizer:theLongPress];
    [self.contentView setExclusiveTouch:YES];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.previewImageView.image = nil;
    self.previewImageView.hidden = YES;
}

- (void)setPrevieImage:(UIImage *)anImage
{
    self.previewImageView.hidden = NO;
    self.previewImageView.image = anImage;
}

#pragma mark - Actions

- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)aRecognizer
{
    if (aRecognizer.state == UIGestureRecognizerStateBegan)
    {
        self.contentView.backgroundColor  = [self selectedBackgroundColor];
        if ([self.delegate respondsToSelector:@selector(playbackCellStartCapturing:)])
        {
            [self.delegate playbackCellStartCapturing:self];
            
        }
    }
    else if (aRecognizer.state == UIGestureRecognizerStateCancelled ||
             aRecognizer.state == UIGestureRecognizerStateEnded || 
             aRecognizer.state == UIGestureRecognizerStateFailed)
    {
        [self defaultBackgroundColor];
        if ([self.delegate respondsToSelector:@selector(playbackCellEndCapturing:)])
        {
            [self.delegate playbackCellEndCapturing:self];
        }
        self.contentView.backgroundColor = [self defaultBackgroundColor];
    }
}


#pragma mark - Private

- (nonnull UIColor *)defaultBackgroundColor
{
    return [UIColor colorWithRed:196.0 / 255.0 
                           green:218.0 / 255.0
                            blue:241.0 / 255.0
                           alpha:1.0];

}

- (nonnull UIColor *)selectedBackgroundColor
{
    return [UIColor colorWithRed:65.0 / 255.0 
                           green:173.0 / 255.0
                            blue:57.0 / 255.0
                           alpha:1.0];
}

@end
