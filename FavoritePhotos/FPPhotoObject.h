//
//  FPPhotoObject.h
//  FavoritePhotos
//
//  Created by Cameron Flowers on 3/26/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface FPPhotoObject : NSObject
@property  NSString *photoString;
@property BOOL containsLocation;
@property CLLocation *location;

@end
