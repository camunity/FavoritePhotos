//
//  FPDataManager.m
//  FavoritePhotos
//
//  Created by Cameron Flowers on 3/26/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "FPDataManager.h"

@implementation FPDataManager

-(void)giveMeMyArray:(NSString *)query
{
    self.pictureArray = [NSMutableArray new];
    self.locationArray = [NSMutableArray new];
    self.urlArray = [NSMutableArray new];
    self.searchQuery = query;
    
    NSString *tempstring = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?access_token=414285079.1fb234f.995c050432af47ebbf899f824d393580", query];
    NSURL *url = [NSURL URLWithString:tempstring];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *connectionError)
     {
         self.initialDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
         self.differentPosts = [self.initialDictionary objectForKey:@"data"];
         for (NSDictionary *individualPosts in self.differentPosts)
         {
             self.allPicsOnPosts = [individualPosts objectForKey:@"images"];
             self.almostThere = [self.allPicsOnPosts objectForKey:@"standard_resolution"];
             NSString *pictureURL = [self.almostThere objectForKey:@"url"];
             [self.pictureArray addObject:pictureURL];
             if (self.pictureArray.count > 9) {
                 break;
             }
             [self.locationArray addObject: [individualPosts objectForKey:@"location"]];
             if (self.locationArray.count > 9) {
                 break;
             }
         }
         [self.delegate getPhotoData:self.pictureArray];
         [self.delegate getLocationData:self.locationArray];

     }];
}


-(void)addFavestoDictionary {
   


}



@end
