//
//  ViewController.m
//  AlbumsCreate
//
//  Created by Line_Hu on 14-8-15.
//  Copyright (c) 2014年 Alpha. All rights reserved.
//

#import "ViewController.h"
#import "AlbumsManager.h"
@interface ViewController ()
{
    NSMutableArray *albums;
    AlbumsManager *abManager;
}
@property (weak, nonatomic) IBOutlet UICollectionView *clView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *c = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createAlbum)];
    self.navigationItem.rightBarButtonItem = c;
    albums = [NSMutableArray arrayWithCapacity:10];
    abManager = [[AlbumsManager alloc] init];
    [self.clView reloadData];
    //[self createAlbum];
    [self.clView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)createAlbum
{
    [abManager addAlbum];
//    if([abManager.total count] > 0)
//    {
//        NSMutableArray *arr = [abManager findAvailableArr];
//        [arr addObject:[NSString stringWithFormat:@"%d",arc4random()%999]];
//    }
//    else
//    {
//        [abManager.total addObject:[NSMutableArray arrayWithObject:@"1234"]];
//    }
    [self.clView reloadData];
    NSInteger section = [self numberOfSectionsInCollectionView:_clView] - 1;
    NSInteger item = [self collectionView:self.clView numberOfItemsInSection:section] - 1;
    NSIndexPath*  lastIndexPath = [NSIndexPath indexPathForItem:item inSection:section];
    [self.clView scrollToItemAtIndexPath:lastIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
}

#pragma mark - DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [abManager.total count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if(indexPath.section == 0)
    {
        cell.backgroundColor = [UIColor blueColor];
    }
    else
    {
        cell.backgroundColor = [UIColor redColor];
    }
    return cell;
}

#pragma mark - flow
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(30, 30, 30, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 60;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 30;
}

#pragma mark - delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [abManager removeAlbumAtIndex:indexPath.row];
    [self.clView deleteItemsAtIndexPaths:@[indexPath]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
