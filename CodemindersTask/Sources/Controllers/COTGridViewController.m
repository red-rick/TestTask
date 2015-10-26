//
//  COTGridViewController.m
//  CodemindersTask
//
//  Created by Dmytro Benedyk on 10/24/15.
//  Copyright © 2015 Benedyk Dmytro. All rights reserved.
//

#import "COTGridViewController.h"
#import "COTPresenter.h"

@interface COTGridViewController()<UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) COTPresenter *presenter;

@end

@implementation COTGridViewController

@synthesize presenter;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *theLayout = 
        (UICollectionViewFlowLayout *)self.collectionViewLayout;
    theLayout.sectionInset = 
        [self.presenter gridInsetsForViewFrame:self.collectionView.frame];
    [self.presenter setupStreaming];
}

#pragma mark - Properties

- (COTPresenter *)presenter
{
    if(nil == presenter)
    {
        presenter = [COTPresenter new];
    }
    return presenter;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)aCollectionView
    didSelectItemAtIndexPath:(NSIndexPath *)anIndexPath
{
    UICollectionViewCell *theCell = [aCollectionView cellForItemAtIndexPath:anIndexPath];
    [self.presenter playVideoForItem:theCell atIndexPath:anIndexPath]; 
}

- (CGSize)collectionView:(UICollectionView *)aCollectionView
    layout:(UICollectionViewLayout *)aCollectionViewLayout
    sizeForItemAtIndexPath:(nonnull NSIndexPath *)anIndexPath
{
    return [self.presenter gridCellSizeForViewFrame:aCollectionView.frame];
}

#pragma mnark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)aCollectionView
     numberOfItemsInSection:(NSInteger)aSection
{
    return self.presenter.numberOfCells;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView
    cellForItemAtIndexPath:(NSIndexPath *)anIndexPath
{
    return [self.presenter gridCellInCollectionView:aCollectionView 
                                        forIndexPath:anIndexPath];
}
@end
