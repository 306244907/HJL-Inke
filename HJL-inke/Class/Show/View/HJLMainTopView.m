//
//  HJLMainTopView.m
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/23.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import "HJLMainTopView.h"

@interface HJLMainTopView ()

@property (nonatomic , strong) UIView *lineView;

@property (nonatomic , strong) NSMutableArray *btns;

@end

@implementation HJLMainTopView

- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat btnWidth = self.width / titles.count;
        CGFloat btnHeight = self.height;
        
        for (int i = 0; i < titles.count ; i++) {
            
            UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
          
            NSString *vcName = titles[i];
            [titleBtn setTitle:vcName forState:UIControlStateNormal];
            [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            titleBtn.titleLabel.font = [UIFont systemFontOfSize:18];
            titleBtn.tag = i;
            titleBtn.frame = CGRectMake(btnWidth * i, 0, btnWidth, btnHeight);
            
            [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:titleBtn];
            
            [self.btns addObject:titleBtn];
            
            if (i == 1) {
                
                CGFloat h = 2;
                CGFloat y = 40;
                
                [titleBtn.titleLabel sizeToFit];
                
                self.lineView = [[UIView alloc] init];
                self.lineView.backgroundColor = [UIColor whiteColor];
                
                self.lineView.height = h;
                self.lineView.width = titleBtn.titleLabel.width;
                self.lineView.top = y;
                self.lineView.centerX = titleBtn.centerX;
                
                [self addSubview:self.lineView];
            }
        }
    }
    return self;
}

- (void)titleClick:(UIButton *)sender
{
    if (self.block) {
        self.block(sender.tag);
    }
    
    [self scrolling:sender.tag];
}

- (void)scrolling:(NSInteger)tag
{
    UIButton *button = self.btns[tag];
    
    [UIView animateWithDuration:.5 animations:^{
        self.lineView.centerX = button.centerX;
    }];

}

- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
