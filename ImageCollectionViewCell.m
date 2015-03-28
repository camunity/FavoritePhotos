//
//  ImageCollectionViewCell.m
//  FavoritePhotos
//
//  Created by Micah Lanier on 3/26/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import "FPDataManager.h"

@implementation ImageCollectionViewCell



- (void)tapToFavorite {

    self.isFavorite = NO;

    if (self.favoritedLabel == NO) {
        [self.favoritedLabel setHidden:YES];
    } else {
        [self.favoritedLabel setHidden:NO];
        
    }

}

@end
