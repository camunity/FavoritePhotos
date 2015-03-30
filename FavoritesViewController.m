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
    [self.dataManager load];
    self.favesArray = [NSMutableArray new];
    self.favesCollectionView.delegate = self;
    self.favesArray = self.dataManager.favoritesArray;
    NSLog(@"%lu", (unsigned long)self.favesArray.count);


}

- (void)viewWillAppear:(BOOL)animated {
    [self.favesCollectionView reloadData];
    animated = YES;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.favesCollectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
}

//-(void)remove:(int)i {
//
//    [self.favesCollectionView performBatchUpdates:^{
//        [self.favesArray removeObjectAtIndex:i];
//        NSIndexPath *indexPath =[NSIndexPath indexPathForRow:i inSection:0];
//        [self.favesCollectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
//
//    } completion:^(BOOL finished) {
//        
//    }];
//}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSData *cellImage = [self.favesArray objectAtIndex:indexPath.row];
    cell.cellImageView.image = [UIImage imageWithData:cellImage];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.favesArray.count;
}





@end
