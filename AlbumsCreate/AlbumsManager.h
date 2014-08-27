//
//  AlbumsManager.h
//  AlbumsCreate
//
//  Created by Line_Hu on 14-8-15.
//  Copyright (c) 2014年 Alpha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumsManager : NSObject
{
}
@property (strong, nonatomic) NSMutableArray *total;
- (void)addAlbum;
- (void)removeAlbumAtIndex:(NSInteger)index;
- (NSMutableArray *)findAvailableArr;
- (void)rearrangeAlbumsAtIndexPath:(NSIndexPath *)indexPath;
@end
