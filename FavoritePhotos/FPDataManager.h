//
//  FPDataManager.h
//  FavoritePhotos
//
//  Created by Cameron Flowers on 3/26/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol FPDataManagerDelegate <NSObject>

@optional
-(void)getPhotoData:(NSMutableArray *)data;
-(void)getLocationData:(NSMutableArray *)data;
@end

@interface FPDataManager : NSObject //<NSCoding>
@property NSURL *photosURL;
@property NSMutableArray *pictureArray;
@property NSMutableArray *locationArray;
@property NSMutableArray *favoritesArray;
@property NSDictionary *initialDictionary;
@property NSArray *differentPosts;
@property NSDictionary *individualPosts;
@property NSDictionary *allPicsOnPosts;
@property NSDictionary *almostThere;
@property NSDictionary *favoritesMasterDictionary;
@property NSString *searchQuery;


@property (nonatomic, assign) id <FPDataManagerDelegate> delegate;
-(void)giveMeMyArray:(NSString *)query;
-(void)addFave:(NSData *)image;
-(void)setUpDataManager;
- (void)load;
//-(NSString*)createJSON;




@end
