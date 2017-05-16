//
//  HJLTabBar.m
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/22.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import "HJLTabBar.h"

@interface HJLTabBar ()

@property (nonatomic , strong) UIImageView *tabBgView;

@property (nonatomic , strong) NSArray *dataList;

@property (nonatomic , strong) UIButton *lastItem;

@property (nonatomic , strong) UIButton *camerButton;

@end

@implementation HJLTabBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews
{
    //装载背景
    [self addSubview:self.tabBgView];
    
    //装载item
    for (int i = 0; i < self.dataList.count; i++) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //不让图片在高亮下改变
        item.adjustsImageWhenHighlighted = NO;
        [item setImage:[UIImage imageNamed:self.dataList[i]] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:[self.dataList[i] stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
        item.tag = HJLItemTypeLive + i;
        [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            item.selected = YES;
            self.lastItem = item;
        }
        
        [self addSubview:item];
    }
    
    //添加直播按钮
    [self addSubview:self.camerButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tabBgView.frame = self.bounds;
    
    CGFloat width = self.bounds.size.width / self.dataList.count;
    
    for (int i = 0; i < [self subviews].count; i++) {
        
        UIView *btn = [self subviews][i];
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.frame = CGRectMake((btn.tag - HJLItemTypeLive) * width, 0, width, self.frame.size.height);
        }
    }
    
    [self.camerButton sizeToFit];
    self.camerButton.center = CGPointMake(self.center.x , self.bounds.size.height - 50);
}

- (void)clickItem:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(tabbar:clickButton:)]) {
        [self.delegate tabbar:self clickButton:sender.tag];
    }
    
//    !self.block?:self.block(self , sender.tag);
    if (self.block) {
        self.block(self , sender.tag);
    }
    
    if (sender.tag == HJLItemTypeLaunch) {
        return;
    }
    
    
    self.lastItem.selected = NO;
    sender.selected = YES;
    self.lastItem = sender;
    
    //设置动画
    [UIView animateWithDuration:.2 animations:^{
        //将button扩大1.2倍
        sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2 animations:^{
            //恢复原始状态
            sender.transform = CGAffineTransformIdentity;
        }];
    }];
}

- (UIButton *)camerButton
{
    if (!_camerButton) {
        _camerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_camerButton setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        [_camerButton sizeToFit];
        _camerButton.tag = HJLItemTypeLaunch;
        [_camerButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _camerButton;
}

- (NSArray *)dataList
{
    if (!_dataList) {
        _dataList = @[@"tab_live" , @"tab_me"];
    }
    return _dataList;
}
- (UIImageView *)tabBgView
{
    if (!_tabBgView) {
        _tabBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
    }
    return _tabBgView;
}
@end
