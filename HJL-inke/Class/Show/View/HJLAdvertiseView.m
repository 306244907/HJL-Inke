//
//  HJLAdvertiseView.m
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/28.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import "HJLAdvertiseView.h"
#import "HJLLiveHandler.h"
#import "HJLAdvertise.h"
#import "HJLCacheHelper.h"

static NSInteger showTime = 3;
@interface HJLAdvertiseView ()

@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic , strong) dispatch_source_t timer;
@end

@implementation HJLAdvertiseView

+ (instancetype)loadAdvertiseView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HJLAdvertiseView" owner:self options:nil] lastObject];
}

//广告页初始化方法
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.frame = [UIScreen mainScreen].bounds;
    
    //展示广告
    [self showAd];
    //下载广告
    [self downAd];
    
    //倒计时
    [self startTimer];
    
}

- (void)showAd
{
    NSString *fileName = [HJLCacheHelper getAdvertise];
    NSString *filePath = [NSString stringWithFormat:@"%@%@" , IMAGE_HOST , fileName];
    
    UIImage *lastCacheImage = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:filePath];
    if (lastCacheImage) {
        self.bgView.image = lastCacheImage;
    } else {
        self.hidden = YES;
    }
}

- (void)downAd
{
    [HJLLiveHandler executeGetAdvertiseTaskWithSuccess:^(id obj) {
        
        
        HJLAdvertise *ad = obj;
        NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@" , IMAGE_HOST , ad.image]];
        
        //SDWebImageAvoidAutoSetImage 下载完不给imageView赋值
        [[SDWebImageManager sharedManager] downloadImageWithURL:imageUrl options:SDWebImageAvoidAutoSetImage progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//            NSLog(@"图片下载成功");
            [HJLCacheHelper setAdvertise:ad.image];
        }];
        
    } failed:^(id obj) {
        
    }];
}

- (void)startTimer
{
    __block NSUInteger timeOut = showTime + 1;
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    self.timer = timer;
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (timeOut <= 0) {
            dispatch_async(dispatch_get_main_queue(), ^{

                [self dismiss];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.timeLabel.text = [NSString stringWithFormat:@"跳过%zd" ,timeOut];
            });
            timeOut--;
        }
    });
    dispatch_resume(timer);
}

- (void)dismiss
{
    [UIView animateWithDuration:.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
