//
//  HJLLaunchViewController.m
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/22.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import "HJLLaunchViewController.h"
#import "LFLivePreview.h"
@interface HJLLaunchViewController ()

@end

@implementation HJLLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)startLive:(id)sender {
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bgView];
    
    LFLivePreview *preView = [[LFLivePreview alloc] initWithFrame:self.view.bounds];
    preView.vc = self;
    [self.view addSubview:preView];
    //开始直播
    [preView startLive];
}
- (IBAction)closeLaunch:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
