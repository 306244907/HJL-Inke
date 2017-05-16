//
//  HJLFocuseViewController.m
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/22.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import "HJLFocuseViewController.h"
#import "HJLLiveCell.h"
#import "HJLPlayerViewController.h"
static NSString *identifier = @"HJLLiveFocuseCell";
@interface HJLFocuseViewController ()

@property (nonatomic , strong) NSArray *datalist;

@end

@implementation HJLFocuseViewController

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HJLLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.live = self.datalist[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HJLLive *live = self.datalist[indexPath.row];
    
    HJLPlayerViewController *playerVC = [[HJLPlayerViewController alloc] init];
    playerVC.live = live;
    [self.navigationController pushViewController:playerVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70 + SCREEN_WIDTH;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    HJLLive *live = [[HJLLive alloc] init];
    live.city = @"上海青浦";
    live.onlineUsers = 15829;
    live.streamAddr = Live_Jinlong;
    
    HJLCreator *create = [[HJLCreator alloc] init];
    live.creator = create;
    create.nick = @"金龙";
    create.portrait = @"myPhoto";
    
    self.datalist = @[live];
    [self.tableView reloadData];
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
