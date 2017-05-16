//
//  HJLHotViewController.m
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/22.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import "HJLHotViewController.h"
#import "HJLLiveHandler.h"
#import "HJLLiveCell.h"
#import "HJLPlayerViewController.h"
static NSString *identifier = @"HJLLiveCell";
@interface HJLHotViewController ()

@property (nonatomic , strong) NSMutableArray *dataList;
@end

@implementation HJLHotViewController

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HJLLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.live = self.dataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HJLLive *live = self.dataList[indexPath.row];
    
    HJLPlayerViewController *playerVC = [[HJLPlayerViewController alloc] init];
    playerVC.live = live;
    [self.navigationController pushViewController:playerVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70 + SCREEN_WIDTH;
}

- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self initUI];
    
    [self loadData];
}

- (void)initUI
{
    [self.tableView registerNib:[UINib nibWithNibName:@"HJLLiveCell" bundle:nil] forCellReuseIdentifier:identifier];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)loadData
{
    [HJLLiveHandler executeGetHotLiveTaskWithSuccess:^(id obj) {
        NSLog(@"%@" , obj);
        
        [self.dataList addObjectsFromArray:obj];
        [self.tableView reloadData];
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
