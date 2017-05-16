//
//  HJLBaseHandler.h
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/24.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import <Foundation/Foundation.h>

//处理完成事件
typedef void(^CompleteBlock)();

//处理事件成功  obj：返回数据
typedef void(^SuccessBlock)(id obj);

//处理事件失败 obj:错误信息
typedef void(^FailedBlock)(id obj);
@interface HJLBaseHandler : NSObject

@end
