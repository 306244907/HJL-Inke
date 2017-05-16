//
//  HJLCacheHelper.m
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/28.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import "HJLCacheHelper.h"

#define adverImage @"adImage"
@implementation HJLCacheHelper

+ (NSString *)getAdvertise
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:adverImage];
}

+ (void)setAdvertise:(NSString *)adImage
{
    [[NSUserDefaults standardUserDefaults] setObject:adImage forKey:adverImage];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
@end
