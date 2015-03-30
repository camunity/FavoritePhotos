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

@interface FavoritesViewController () <UIAlertViewDelegate>

<
UICollectionViewDataSource,
UICollectionViewDelegate,
FPDataManagerDelegate
>

@property ImageCollectionViewCell *cell;
@property (weak, nonatomic) IBOutlet UICollectionView *favesCollectionView;
@property FPDataManager *favesManager;
@property UIAlertView *deletePhotoConfirmAlert;
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
//    self.alertView = [UIAlertView alloc] initWithTitle:@"Alert!" message:@"Do you want to delete?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil]
//    [self.alertView show];


}

//-(void)collection

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

//
//-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
//
//    if(alertView == self.deletePhotoConfirmAlert){
//        if (buttonIndex == 1){
//            //permission to delete
//
//            NSArray *selecetedItemsIndexPaths = [self.favesCollectionView indexPathsForSelectedItems];
//
//            [self deleteItemsFromDataSourceAtIndexPaths:selecetedItemsIndexPaths];
//
//            [self.favesCollectionView deleteItemsAtIndexPaths:selecetedItemsIndexPaths];
//
//        }
//    }
//}

//-(void)deleteItemsFromDataSourceAtIndexPaths:(NSArray *) indexPaths{
//
//    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
//    for (NSIndexPath *itemPath in indexPaths) {
//        [indexSet addIndex:itemPath.row];
//    }
//        //delete item from data source arrays
//
//        self.dataManager
//
//
//}


@end
