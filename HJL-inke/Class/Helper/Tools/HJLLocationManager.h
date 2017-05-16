//
//  HJLLocationManager.h
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/25.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^locationBlock)(NSString *lat , NSString *lon);

@interface HJLLocationManager : NSObject

+ (instancetype)sharedManager;

- (void)getGps:(locationBlock)block;

@property (nonatomic , strong) NSString *lat;
@property (nonatomic , strong) NSString *lon;
@end
