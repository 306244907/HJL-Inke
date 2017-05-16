//
//  HJLTabBar.h
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/22.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger , HJLItemType) {
    HJLItemTypeLaunch = 10, //启动直播
    HJLItemTypeLive = 100, //展示直播
    HJLItemTypeMe, //我的
    
};

@class HJLTabBar;

typedef void(^TabBlock)(HJLTabBar *tabbar , HJLItemType idx);

@protocol HJLTabBarDelegate <NSObject>

- (void)tabbar:(HJLTabBar *)tabbar clickButton:(HJLItemType) idx;

@end

@interface HJLTabBar : UIView

@property (nonatomic , weak) id<HJLTabBarDelegate>delegate;

@property (nonatomic , copy) TabBlock block;

@end
