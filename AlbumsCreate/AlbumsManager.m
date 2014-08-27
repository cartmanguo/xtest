//
//  AlbumsManager.m
//  AlbumsCreate
//
//  Created by Line_Hu on 14-8-15.
//  Copyright (c) 2014年 Alpha. All rights reserved.
//

#import "AlbumsManager.h"
#import "Album.h"
@implementation AlbumsManager
- (id)init
{
    self = [super init];
    if (self)
    {
        self.total = [NSMutableArray arrayWithCapacity:20];
        [self getAlbums];
    }
    return self;
}

- (NSMutableArray *)findAvailableArr
{
    NSMutableArray *arr = self.total[[_total count] - 1];
    if([arr count] < 2)
    {
        return arr;
    }
    else
    {
        [_total addObject:[NSMutableArray array]];
        return _total[[_total count] - 1];
    }
    return 0;
}

- (void)rearrangeAlbumsAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section < [self.total count]-1)
    {
        NSMutableArray *albumsAtSection = self.total[indexPath.section];
        NSLog(@"cnt1:%d",[albumsAtSection count]);
        NSMutableArray *nextSectionAlbums = self.total[indexPath.section + 1];
        NSLog(@"cnt2:%d",[nextSectionAlbums count]);
        id firstObj = [nextSectionAlbums objectAtIndex:0];
        [albumsAtSection addObject:firstObj];
        NSLog(@"remove item:%@",firstObj);
        [nextSectionAlbums removeObject:firstObj];
        NSLog(@"removed:%d",[nextSectionAlbums count]);
        NSLog(@"rearranged:%d,%d",[albumsAtSection count],[nextSectionAlbums count]);
    }
    
}

- (void)getAlbums
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSMutableArray *folders = (NSMutableArray *)[fm subpathsAtPath:docPath];
    for (NSString *path  in folders)
    {
        Album *album = [[Album alloc] init];
        album.albumName = path;
        album.albumPath = [docPath stringByAppendingPathComponent:path];
        [self.total addObject:album];
    }
}

- (void)addAlbum
{
    Album *album = [[Album alloc] init];
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *folderName = [NSString stringWithFormat:@"%d",arc4random()%999];
    NSString *folderPath = [docPath stringByAppendingPathComponent:folderName];
    album.albumName = folderName;
    album.albumPath = folderPath;
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    [self.total addObject:album];
}

- (void)removeAlbumAtIndex:(NSInteger)index
{
    Album *deleteAlbum = (Album *)self.total[index];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSLog(@"rm:%@",deleteAlbum.albumPath);
    [fm removeItemAtPath:deleteAlbum.albumPath error:nil];
    [self.total removeObjectAtIndex:index];
}
@end
