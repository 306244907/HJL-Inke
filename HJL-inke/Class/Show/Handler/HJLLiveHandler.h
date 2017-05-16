//
//  HJLLiveHandler.h
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/24.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import "HJLBaseHandler.h"

@interface HJLLiveHandler : HJLBaseHandler

/**
 *   获取热门直播信息
 *   success
 
*/
+ (void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

//获取附近直播
+ (void)executeGetNearLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

//获取广告页
+ (void)executeGetAdvertiseTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;
@end
