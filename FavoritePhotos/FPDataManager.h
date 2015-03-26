//
//  FPDataManager.h
//  FavoritePhotos
//
//  Created by Cameron Flowers on 3/26/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FPDataManagerDelegate <NSObject>

@optional
-(void)getPhotoData:(id)data;

@end

@interface FPDataManager : NSObject
@property NSURL *photosURL;
@property (nonatomic, assign) id <FPDataManagerDelegate> delegate;
- (instancetype)initWithURL;
@end
