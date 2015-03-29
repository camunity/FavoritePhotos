//
//  FPDataManager.m
//  FavoritePhotos
//
//  Created by Cameron Flowers on 3/26/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "FPDataManager.h"
#import <UIKit/UIKit.h>

@implementation FPDataManager 


-(void)setUpDataManager{
    self.favoritesArray = [NSMutableArray new];
    self.favoritesMasterDictionary = [NSMutableDictionary new];
    NSMutableArray *masterFavesArray = [NSMutableArray new];
    [self.favoritesMasterDictionary setValue:masterFavesArray forKey:@"masterFaves" ];

}

-(void)giveMeMyArray:(NSString *)query
{
    self.pictureArray = [NSMutableArray new];
    self.locationArray = [NSMutableArray new];
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


-(void)addFave:(NSData *) image{

    if(!([self.favoritesArray containsObject:image])){
    [self addFavestoDictionary:image];
    NSLog(@"FAVORITED!");
    }
    NSLog(@"dictionary saved");
}

-(void)addFavestoDictionary:(NSData *) image {

    if([self checkExists:(NSData *)image]){
        NSLog(@"ADDED TO ARRAY!");
    }
    else{
        NSLog(@"We Have To Set Up Another Queue based on new query homie");
//        NSMutableArray *queryArray = [NSMutableArray new];
//        [queryArray addObject:image];
        NSDictionary *query = [[NSDictionary alloc] initWithObjectsAndKeys:self.favoritesArray, self.searchQuery, nil];
        [self.favoritesMasterDictionary[@"masterFaves"] addObject:query];
        NSLog(@"%li", [self.favoritesMasterDictionary[@"masterFaves"] count]);
        [self.favoritesArray addObject:image];
        [self saveDictionary];

    }
        NSArray *temp = self.favoritesMasterDictionary[@"masterFaves"];
        NSLog(@"%li Total Favorited Queries",temp.count);
        NSLog(@"%li Total Favorite Photos", self.favoritesArray.count);
}

-(bool)checkExists:(NSData *)image{
    for (NSDictionary *dict in self.favoritesMasterDictionary[@"masterFaves"]) {
        if ([dict.allKeys containsObject:self.searchQuery]) {
            NSLog(@"QUERY ALREADY EXISTED ADDING TO ARRAY!");
            NSString *query = self.searchQuery;
            [dict[query] addObject:image];
            return YES;
        }
    }
        return NO;
}



- (NSURL *)documentsDirectory {
    NSLog(@"%@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject] );

    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
}

- (void)saveDictionary {
    NSURL *plist = [[self documentsDirectory] URLByAppendingPathComponent:@"Favorites.plist"];
    [self.favoritesMasterDictionary writeToURL:plist atomically:YES];
}

- (void)load {
    NSURL *plist = [[self documentsDirectory] URLByAppendingPathComponent:@"Favorites.plist"];
    self.favoritesMasterDictionary = [NSDictionary dictionaryWithContentsOfURL:plist];
}


@end
