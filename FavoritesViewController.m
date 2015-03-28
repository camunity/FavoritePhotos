//
//  FavoritesViewController.m
//  FavoritePhotos
//
//  Created by Micah Lanier on 3/27/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "FavoritesViewController.h"
#import "ImageCollectionViewCell.h"
#import "FPDataManager.h"
#import "ViewController.h"

@interface FavoritesViewController ()

<
UICollectionViewDataSource,
UICollectionViewDelegate,
FPDataManagerDelegate
>

@property ImageCollectionViewCell *cell;
@property (weak, nonatomic) IBOutlet UICollectionView *favesCollectionView;
@property FPDataManager *favesManager;

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.favesArray = [NSMutableArray new];
    self.favesCollectionView.delegate = self;
    self.favesArray = self.dataManager.favoritesArray;
    NSLog(@"%lu", (unsigned long)self.favesArray.count);

}

- (void)viewDidAppear:(BOOL)animated {
    [self.favesCollectionView reloadData];
    animated = YES;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    UIImage *cellImage = [self.favesArray objectAtIndex:indexPath.row];
    cell.cellImageView.image = cellImage;
   //cell.cellImageView.image = [UIImage imageNamed:@"austin"];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.favesArray.count;
}





@end
