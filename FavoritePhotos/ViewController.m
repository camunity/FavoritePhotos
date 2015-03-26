//
//  ViewController.m
//  FavoritePhotos
//
//  Created by Cameron Flowers on 3/26/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "ImageCollectionViewCell.h"

@interface ViewController ()

@property NSDictionary *masterDictionary;
@property NSArray *differentPosts;
@property NSDictionary *individualPosts;
@property NSDictionary *allPicsOnPosts;
@property NSDictionary *almostThere;
@property NSMutableArray *pictureArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSMutableArray *cities;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.pictureArray = [NSMutableArray new];
    [self fillUpTheArray:@"aliveandfreefilm"];
    NSLog(@"%li", self.pictureArray.count);

    self.cities = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"austin"], [UIImage imageNamed:@"chicago"], [UIImage imageNamed:@"nashville"], [UIImage imageNamed:@"sanFran"], nil];
    [self setUpCollectionView];
}


-(void)fillUpTheArray:(NSString *)whatkindoftag
{
    NSString *tempstring = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?access_token=414285079.1fb234f.995c050432af47ebbf899f824d393580", whatkindoftag];
    NSURL *url = [NSURL URLWithString:tempstring];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *connectionError)
     {
         self.masterDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
         self.differentPosts = [self.masterDictionary objectForKey:@"data"];
         for (NSDictionary *tempDic in self.differentPosts)
         {
             self.allPicsOnPosts = [tempDic objectForKey:@"images"];
             self.almostThere = [self.allPicsOnPosts objectForKey:@"standard_resolution"];
             NSString *pictureURL = [self.almostThere objectForKey:@"url"];
             [self.pictureArray addObject:pictureURL];
             NSLog(@"%li", self.pictureArray.count);
         }
     }];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    //cell.cellImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[self.pictureArray firstObject]]];
    cell.cellImageView.image = [self.cities objectAtIndex:indexPath.row];
    return cell;
}

 - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

     return  self.cities.count;
 }

- (void)setUpCollectionView {

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setMinimumLineSpacing:0.1];
    [self.collectionView setPagingEnabled:YES];

}







@end
