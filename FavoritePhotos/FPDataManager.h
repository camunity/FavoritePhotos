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
-(void)getPhotoData:(NSMutableArray *)data;
-(void)getLocationData:(NSMutableArray *)data;
@end

@interface FPDataManager : NSObject
@property NSURL *photosURL;
@property NSMutableArray *pictureArray;
@property NSMutableArray *locationArray;
@property NSDictionary *masterDictionary;
@property NSArray *differentPosts;
@property NSDictionary *individualPosts;
@property NSDictionary *allPicsOnPosts;
@property NSDictionary *almostThere;
@property (nonatomic, assign) id <FPDataManagerDelegate> delegate;
-(void)giveMeMyArray:(NSString *)query;

@end
