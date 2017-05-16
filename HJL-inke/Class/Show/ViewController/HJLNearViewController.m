//
//  HJLNearViewController.m
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/28.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import "HJLNearViewController.h"
#import "HJLLiveHandler.h"
#import "HJLNearLiveCell.h"
#import "HJLPlayerViewController.h"
static NSString *identifier = @"HJLNearLiveCell";

#define kMargin 5
#define kItemWidth 100
@interface HJLNearViewController ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic , strong) NSArray *dataArray;

@end

@implementation HJLNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self loadData];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HJLNearLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.live = self.dataArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    HJLLive *live = self.dataArray[indexPath.row];
    
    HJLPlayerViewController *playerVC = [[HJLPlayerViewController alloc] init];
    playerVC.live = live;
    [self.navigationController pushViewController:playerVC animated:YES];
}

//将要显示时调用
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    HJLNearLiveCell *c = (HJLNearLiveCell *)cell;
    [c showAnimation];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count = self.collectionView.width / kItemWidth;
    CGFloat etraWidth = (self.collectionView.width - kMargin * (count + 1)) / count;
    return CGSizeMake(etraWidth, etraWidth + 20);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (void)initUI
{
    [self.collectionView registerNib:[UINib nibWithNibName:@"HJLNearLiveCell" bundle:nil] forCellWithReuseIdentifier:identifier];
}

- (void)loadData
{
    [HJLLiveHandler executeGetNearLiveTaskWithSuccess:^(id obj) {
        NSLog(@"%@" , obj);
        self.dataArray = obj;
        [self.collectionView reloadData];
    } failed:^(id obj) {
        NSLog(@"%@" , obj);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
