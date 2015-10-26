//
//  COTVideoStore.m
//  CodemindersTask
//
//  Created by Dmytro Benedyk on 10/24/15.
//  Copyright © 2015 Benedyk Dmytro. All rights reserved.
//

#import "COTVideoStore.h"
#import "PBJVision.h"

@interface COTVideoStore()

@property (nonatomic, strong) NSMutableDictionary *videoPathsMap;

@end

@implementation COTVideoStore

@synthesize videoPathsMap;

- (void)dealloc
{
    [self.videoPathsMap enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull aKey, id  _Nonnull anObj, BOOL * _Nonnull aStop)
     {
         NSDictionary *theInfo = anObj;
         NSString *thePath = theInfo[PBJVisionVideoPathKey];
         [self removeFileAtPath:thePath];
     }];
}

#pragma mark -

- (NSDictionary *)videoInfoForIndexPath:(NSIndexPath *)anIndexPath;
{
    if (nil == anIndexPath) 
    {
        NSLog(@"%@: index path is nill",NSStringFromSelector(_cmd));
        return nil;
    }
    return self.videoPathsMap[anIndexPath];
}

- (void)setVideoInfo:(NSDictionary *)anInfo forIndexPath:(NSIndexPath *)anIndexPath;
{
    if (nil == anInfo)
    {
        NSLog(@"%@: info is nill", NSStringFromSelector(_cmd));
        return;
    }
    
    if (nil == anIndexPath)
    {
        NSLog(@"%@: index path is nill", NSStringFromSelector(_cmd));
        return;
    }
    
    NSString *thePath = self.videoPathsMap[anIndexPath][PBJVisionVideoPathKey];
    [self removeFileAtPath:thePath];
    
    self.videoPathsMap[anIndexPath] = anInfo;
}


#pragma mark - Properties

- (NSMutableDictionary *)videoPathsMap
{
    if (nil == videoPathsMap)
    {
        videoPathsMap = [NSMutableDictionary new];
    }
    return videoPathsMap;
}

#pragma mark - Private

- (void)removeFileAtPath:(NSString *)aPath
{
    if (nil != aPath)
    {
        NSError *theError = nil;
        [[NSFileManager defaultManager] removeItemAtPath:aPath error:&theError];
        if (theError != nil)
        {
            NSLog(@"Error ocured: %@", [theError localizedDescription]);
        }
    }
}

@end
