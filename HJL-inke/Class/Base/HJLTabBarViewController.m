//
//  HJLTabBarViewController.m
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/22.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import "HJLTabBarViewController.h"
#import "HJLTabBar.h"
#import "HJLBaseNavViewController.h"
#import "HJLLaunchViewController.h"
@interface HJLTabBarViewController ()<HJLTabBarDelegate>

@property (nonatomic , strong) HJLTabBar *hjlTabbar;
@end

@implementation HJLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //加载控制器
    [self configViewControllers];
    //加载tabbar
    [self.tabBar addSubview:self.hjlTabbar];
    
    //删除tabbar的阴影线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
}

- (void)configViewControllers
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"HJLMainViewController",@"HJLMeViewController"]];
    
    for (int i = 0; i < array.count; i++) {
        
        NSString *vcName = array[i];
        
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
        
        HJLBaseNavViewController *nav = [[HJLBaseNavViewController alloc] initWithRootViewController:vc];
        
        [array replaceObjectAtIndex:i withObject:nav];
    }
    
    self.viewControllers = array;
}

- (void)tabbar:(HJLTabBar *)tabbar clickButton:(HJLItemType)idx
{
    if (idx != HJLItemTypeLaunch) {
        self.selectedIndex = idx - HJLItemTypeLive;
        return;
    }
    
    HJLLaunchViewController *launchVC = [[HJLLaunchViewController alloc] init];
    [self presentViewController:launchVC animated:YES completion:nil];
    
}
- (HJLTabBar *)hjlTabbar
{
    if (!_hjlTabbar) {
        _hjlTabbar = [[HJLTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _hjlTabbar.delegate = self;
    }
    return _hjlTabbar;
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
