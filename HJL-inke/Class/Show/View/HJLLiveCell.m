//
//  HJLLiveCell.m
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/24.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import "HJLLiveCell.h"

@interface HJLLiveCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@end
@implementation HJLLiveCell

- (void)setLive:(HJLLive *)live
{
    _live = live;
    
    
    
    self.nameLabel.text = live.creator.nick;
    self.locationLabel.text = live.city;
    self.onlineLabel.text = [@(live.onlineUsers) stringValue];
    
    
    if ([live.creator.portrait isEqualToString:@"myPhoto"]) {
        self.headView.image = [UIImage imageNamed:@"myPhoto"];
        self.bigImageView.image = [UIImage imageNamed:@"myPhoto"];
    } else {
        
        [self.headView downloadImage:[NSString stringWithFormat:@"%@%@" , IMAGE_HOST , live.creator.portrait] placeholder:@"default_room"];
        [self.bigImageView downloadImage:[NSString stringWithFormat:@"%@%@" , IMAGE_HOST , live.creator.portrait] placeholder:@"default_room"];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    self.headView.layer.cornerRadius = 25;
//    self.headView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
