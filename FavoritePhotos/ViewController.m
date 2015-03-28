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
#import "FavoritesViewController.h"

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
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property FavoritesViewController *target;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.searchBar.delegate = self;
    self.tabBar.delegate = self;
    self.dataManager = [FPDataManager new];
    self.dataManager.delegate = self; 
    self.pictureArray = [NSMutableArray new];
    self.locationArray = [NSMutableArray new];
    self.target = [self.storyboard instantiateViewControllerWithIdentifier:@"FavesID"];
    self.target.favesArray = [NSMutableArray new];
    self.target.favesArray = self.dataManager.favoritesArray;



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
    [self.dataManager.favoritesArray addObject:cell.cellImageView.image];
    NSLog(@"%lu", self.dataManager.favoritesArray.count);
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"tapped");
    if (tabBar.selectedItem == [tabBar.items objectAtIndex:0]) {
        [self.navigationController pushViewController:self.target animated:YES];
        self.target.title = @"Favorites";
        self.target.dataManager = [FPDataManager new];
        self.target.dataManager = self.dataManager;
        //[self performSegueWithIdentifier:@"ShowFavesSegue" sender:item];
    }
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"ShowFavesSegue"]) {
//        FavoritesViewController *fvc = segue.destinationViewController;
//        fvc.favesArray = self.dataManager.favoritesArray;
//    }
//}



@end
