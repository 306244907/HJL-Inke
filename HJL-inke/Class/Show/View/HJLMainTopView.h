//
//  HJLMainTopView.h
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/23.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainTopBlock)(NSInteger tag);

@interface HJLMainTopView : UIView

- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titles;

@property (nonatomic , copy) MainTopBlock block;

- (void)scrolling:(NSInteger)tag;
@end
