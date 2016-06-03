//
//  SecondViewController.m
//  iOSWorkshop2
//
//  Created by Pedro Ontiveros on 5/30/16.
//  Copyright © 2016 Pedro Ontiveros. All rights reserved.
//

#import "AdvancedVC.h"
#import "UICustomCoCellView.h"

@interface AdvancedVC ()

@property(nonatomic, retain) NSMutableDictionary *items;

@end

@implementation AdvancedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Advanced";
    self.items = [[NSMutableDictionary alloc] init];
    
    [self.items setObject:@"Geolocation" forKey:@"openGeolocation"];
    for (int i = 0; i < 20; i++) {
        [self.items setObject:[NSString stringWithFormat:@"Item order %d", i] forKey:[NSString stringWithFormat:@"Key%d", i]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICustomCoCellView *cell = (UICustomCoCellView*)[collectionView dequeueReusableCellWithReuseIdentifier:@"UICustomCoCellView" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UICustomCoCellView alloc] init];
    }
    
    NSString *subtitle = [[self.items allKeys] objectAtIndex:indexPath.row];
    NSString    *title = [self.items objectForKey:subtitle];
    
    [cell.title setText:title];
    [cell.subTitle setText:subtitle];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"working on...");
}

@end
