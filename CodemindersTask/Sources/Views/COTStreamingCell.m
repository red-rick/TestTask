//
//  COTStreamingCell.m
//  CodemindersTask
//
//  Created by Dmytro Benedyk on 10/24/15.
//  Copyright © 2015 Benedyk Dmytro. All rights reserved.
//

#import "COTStreamingCell.h"
#import "PBJVision.h"

@implementation COTStreamingCell

- (void)awakeFromNib
{
    self.contentView.backgroundColor = [UIColor redColor];
    
    AVCaptureVideoPreviewLayer *thePreviewLayer = 
        [[PBJVision sharedInstance] previewLayer];
    thePreviewLayer.frame = self.contentView.bounds;
    thePreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.contentView.layer addSublayer:thePreviewLayer];
}



@end
