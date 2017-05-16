//
//  HJLLiveChatViewController.m
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/25.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import "HJLLiveChatViewController.h"

@interface HJLLiveChatViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *peopleCountLB;
@property (weak, nonatomic) IBOutlet UIButton *yingPiaoLB;

@end

@implementation HJLLiveChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.iconView.layer.cornerRadius = 15;
    self.iconView.layer.masksToBounds = YES;
    
    
    [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
        self.peopleCountLB.text = [NSString stringWithFormat:@"%d" , arc4random_uniform(10000)];
    } repeats:YES];
    [self.yingPiaoLB setTitle:[NSString stringWithFormat:@"映票：%d" , arc4random_uniform(10000)] forState:UIControlStateNormal];
}

- (void)setLive:(HJLLive *)live
{
    _live = live;
    [self.iconView downloadImage:[NSString stringWithFormat:@"%@%@" , IMAGE_HOST , live.creator.portrait] placeholder:@"default_room"];
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
