//
//  HJLNearLiveCell.h
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/28.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJLLive.h"
@interface HJLNearLiveCell : UICollectionViewCell

@property (nonatomic , strong) HJLLive *live;

- (void)showAnimation;
@end
