//
//  HJLMainViewController.m
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/22.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import "HJLMainViewController.h"
#import "HJLMainTopView.h"
@interface HJLMainViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (nonatomic , strong) NSArray *datalist;

@property (nonatomic , strong) HJLMainTopView *topView;

@end

@implementation HJLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI
{
    //添加左右按钮
    [self setupNav];
    
    
    //添加子视图控制器
    [self addChildViewControllers];
}

- (void)addChildViewControllers
{
    NSArray *vcNames = @[@"HJLFocuseViewController" , @"HJLHotViewController" , @"HJLNearViewController"];
    
    for (int i = 0; i < vcNames.count; i++) {
        NSString *vcName = vcNames[i];
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
        vc.title = self.datalist[i];
        //当执行addChildViewController时，不会走viewDidLoad
        [self addChildViewController:vc];
    }
    
    //将子视图控制器的view加到mainVC的scrollview上
    
    
    //设置scrollview的contentsize
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.datalist.count, 0);
    
    //默认展示第二个界面
    self.contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    
    //进入主控制器加载第一个页面
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

//动画结束调用代理
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGFloat width = SCREEN_WIDTH;
    
    CGFloat offset = scrollView.contentOffset.x;
    //获取索引值
    NSInteger idx = offset / width;
    
    //索引值联动topView
    [self.topView scrolling:idx];
    //根据索引值返回VC的引用
    UIViewController *vc = self.childViewControllers[idx];
    //判断当前vc是否执行过viewDidLoad
    if ([vc isViewLoaded]) return;
    
    //设置子控制器view的大小
    vc.view.frame = CGRectMake(offset, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    
    //将子控制器的view加入scrollview上
    [scrollView addSubview:vc.view];
}

//scrollview减速结束调用加载子视图控制器方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

- (void)setupNav
{
    self.navigationItem.titleView = self.topView;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:nil action:nil];
    
}

- (HJLMainTopView *)topView
{
    if (!_topView) {
        _topView = [[HJLMainTopView alloc] initWithFrame:CGRectMake(0, 0, 200, 50) titleNames:self.datalist];
        
        @weakify(self);
        
        _topView.block = ^(NSInteger tag) {
            
            @strongify(self);
            
            CGPoint point = CGPointMake(tag * SCREEN_WIDTH, self.contentScrollView.contentOffset.y);
            
            [self.contentScrollView setContentOffset:point animated:YES];
        };
    }
    return _topView;
}

- (NSArray *)datalist
{
    if (!_datalist) {
        _datalist = @[@"关注" , @"热门" , @"附近"];
    }
    return _datalist;
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
