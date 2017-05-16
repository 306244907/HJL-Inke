//
//  HJLLiveHandler.m
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/24.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import "HJLLiveHandler.h"
#import "HttpTool.h"
#import "HJLLive.h"
#import "HJLLocationManager.h"
#import "HJLAdvertise.h"
@implementation HJLLiveHandler

+ (void)executeGetNearLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed
{
    HJLLocationManager *manager = [HJLLocationManager sharedManager];
    
    NSDictionary *paramDic = @{@"uid":@"85149891" , @"latitude":manager.lat , @"longitude":manager.lon};
    
    [HttpTool getWithPath:API_NearLive params:paramDic success:^(id json) {
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        } else {
            //如果返回信息正确
            //数据解析
            NSArray * lives = [HJLLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            success(lives);
            
        }
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+ (void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed
{
    [HttpTool getWithPath:API_HotLive params:nil success:^(id json) {
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        } else {
            //如果返回信息正确
            //数据解析
           NSArray * lives = [HJLLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            success(lives);
            
        }
    } failure:^(NSError *error) {
        
        failed(error);
        
    }];
}


+ (void)executeGetAdvertiseTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed
{
    [HttpTool getWithPath:API_Advertise params:nil success:^(id json) {
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        } else {
            //如果返回信息正确
            //数据解析
            HJLAdvertise *adcertiseArr = [HJLAdvertise mj_objectWithKeyValues:json[@"resources"][0]];
            success(adcertiseArr);
        }
    } failure:^(NSError *error) {
        failed(error);
    }];
}
@end
