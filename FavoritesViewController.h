//
//  FavoritesViewController.h
//  FavoritePhotos
//
//  Created by Micah Lanier on 3/27/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPDataManager.h"

@interface FavoritesViewController : UIViewController

@property NSMutableArray *favesArray;
@property FPDataManager *dataManager;

@end
