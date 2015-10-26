//
//  COTVideoStore.h
//  CodemindersTask
//
//  Created by Dmytro Benedyk on 10/24/15.
//  Copyright © 2015 Benedyk Dmytro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COTVideoStore : NSObject

- (NSDictionary *)videoInfoForIndexPath:(NSIndexPath *)anIndexPath;

- (void)setVideoInfo:(NSDictionary *)aPath forIndexPath:(NSIndexPath *)anIndexPath;



@end
