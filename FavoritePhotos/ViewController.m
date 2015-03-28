//
//  ViewController.m
//  FavoritePhotos
//
//  Created by Cameron Flowers on 3/26/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "ImageCollectionViewCell.h"
#import "FPDataManager.h"

@interface ViewController ()
<
FPDataManagerDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate,
UISearchBarDelegate,
UITabBarDelegate
>
@property FPDataManager *dataManager;
@property NSMutableArray *pictureArray;
@property NSMutableArray *locationArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSMutableArray *cities;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property ImageCollectionViewCell *imageViewCell;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.searchBar.delegate = self;
    self.dataManager = [FPDataManager new];
    self.dataManager.delegate = self; 
    self.pictureArray = [NSMutableArray new];
    self.locationArray = [NSMutableArray new];
//    [self.dataManager giveMeMyArray:self.searchBar.text];

}


-(void)getPhotoData:(NSMutableArray *)data{
    self.pictureArray = data;
    NSLog(@"%li",self.pictureArray.count);
    [self.collectionView reloadData];
}


-(void)getLocationData:(NSMutableArray *)data{
    self.locationArray = data;
    NSLog(@"%li",self.locationArray.count);

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.cellImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.pictureArray objectAtIndex:indexPath.row]]]];
    cell.favoritedLabel.tag = indexPath.row;
    [cell.favoritedLabel setHidden:YES];
    return cell;
}

 - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

     return  self.pictureArray.count;
 }



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.dataManager giveMeMyArray:self.searchBar.text];
    [self.searchBar resignFirstResponder];
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"You tapped me");
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell tapToFavorite];
    [self.dataManager.urlArray addObject:cell];
    NSLog(@"%lu", self.dataManager.urlArray.count);
}

//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    if ()) {
//        <#statements#>
//    }
//}



@end
