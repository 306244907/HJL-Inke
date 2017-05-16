//
//  HJLNearLiveCell.m
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/28.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import "HJLNearLiveCell.h"

@interface HJLNearLiveCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headView;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;


@end
@implementation HJLNearLiveCell

- (void)setLive:(HJLLive *)live
{
    _live = live;
    [self.headView downloadImage:[NSString stringWithFormat:@"%@%@" , IMAGE_HOST , live.creator.portrait] placeholder:@"default_room"];
    
    self.distanceLabel.text = live.creator.nick;
}

- (void)showAnimation
{
    if (self.live.isShow) {
        return;
    }
    self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    
    [UIView animateWithDuration:.5 animations:^{
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);
        self.live.show = YES;
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
