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

@interface ViewController () <FPDataManagerDelegate>
@property FPDataManager *dataManager;
@property NSMutableArray *pictureArray;
@property NSMutableArray *locationArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSMutableArray *cities;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.dataManager = [FPDataManager new];
    self.dataManager.delegate = self; 
    self.pictureArray = [NSMutableArray new];
    self.locationArray = [NSMutableArray new];
    [self.dataManager giveMeMyArray:@"lions"];

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
    return cell;
}

 - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

     return  self.pictureArray.count;
 }

- (void)setUpCollectionView {

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setMinimumLineSpacing:0.1];
    [self.collectionView setPagingEnabled:YES];

}





@end
