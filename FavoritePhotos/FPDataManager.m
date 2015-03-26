//
//  FPDataManager.m
//  FavoritePhotos
//
//  Created by Cameron Flowers on 3/26/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "FPDataManager.h"

@implementation FPDataManager

- (instancetype)initWithURL{
    self = [super init];
    if (self) {
        self.photosURL = [NSURL URLWithString:@"SOME STRING WILL GO HERE"]; ///;
    }

    return self;
}

- (void)getDictionaryData {

    NSString *urlText = @"SOME BIG STRING";
    NSURL *url = [NSURL URLWithString:urlText];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

                               self.dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:NSJSONReadingAllowFragments
                                                                                   error:&connectionError];
                               NSLog(@"Data Received");
                               [self.delegate getMapData:self.dictionary];

                           }];
    
}



@end
