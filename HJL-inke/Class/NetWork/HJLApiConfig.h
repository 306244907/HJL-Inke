//
//  HJLApiConfig.h
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/24.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJLApiConfig : NSObject

//信息类服务器地址
#define SERVER_HOST @"http://service.ingkee.com"

//图片服务器地址
#define IMAGE_HOST @"http://img.meelive.cn/"

//热门直播
#define API_HotLive @"api/live/gettop"

//附近的人
#define API_NearLive @"api/live/near_recommend" //?uid = 85149891&latitude=40.090562&longitude=116.413353

//广告地址
#define API_Advertise @"advertise/get"

#define Live_Jinlong @"rtmp://live.hkstv.hk.lxdns.com:1935/live/jinlong"
@end
