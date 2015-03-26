//
//  ViewController.m
//  FavoritePhotos
//
//  Created by Cameron Flowers on 3/26/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "FPDataManager.h"

@interface ViewController () <FPDataManagerDelegate>
@property FPDataManager *dataManager;
@property NSMutableArray *pictureArray;
@property NSMutableArray *locationArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataManager = [FPDataManager new];
    self.dataManager.delegate = self; 
    self.pictureArray = [NSMutableArray new];
    self.locationArray = [NSMutableArray new];
    [self.dataManager giveMeMyArray:@"aliveandfreefilm"];
}

//based on text field call
-(void)getPhotoData:(NSMutableArray *)data{
    self.pictureArray = data;
    NSLog(@"%li",self.pictureArray.count);
}


-(void)getLocationData:(NSMutableArray *)data{
    self.locationArray = data;
    NSLog(@"%li",self.locationArray.count);

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    return cell;
}

 - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
     return  self.pictureArray.count;
 }

- (void)setUpCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumLineSpacing:0.5];
    [self.collectionView setPagingEnabled:YES];
    [self.collectionView setCollectionViewLayout:flowLayout];
}


//delete

@end
