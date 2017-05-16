//
//  HJLLocationManager.m
//  HJL-inke
//
//  Created by 盘赢 on 2016/11/25.
//  Copyright © 2016年 yingpan. All rights reserved.
//

#import "HJLLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface HJLLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic , strong) CLLocationManager *locManager;

@property (nonatomic , copy) locationBlock block;

@end

@implementation HJLLocationManager

+ (instancetype)sharedManager
{
    static HJLLocationManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[HJLLocationManager alloc] init];
    });
    
    return _manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _locManager = [[CLLocationManager alloc] init];
        [_locManager setDesiredAccuracy:kCLLocationAccuracyBest];
        _locManager.distanceFilter = 100;
        _locManager.delegate = self;
        
        if (![CLLocationManager locationServicesEnabled]) {
            NSLog(@"没有开启定位功能");
        } else {
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusNotDetermined) {
                [_locManager requestWhenInUseAuthorization];
            }
        }
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    CLLocationCoordinate2D coor = newLocation.coordinate;
    
    NSString *lat = [NSString stringWithFormat:@"%@" , @(coor.latitude)];
    NSString *lon = [NSString stringWithFormat:@"%@" , @(coor.longitude)];
    
    [HJLLocationManager sharedManager].lat = lat;
    [HJLLocationManager sharedManager].lon = lon;
    
    self.block(lat , lon);
    
    [self.locManager stopUpdatingLocation];
}


- (void)getGps:(locationBlock)block
{
    self.block = block;
    //开始定位
    [self.locManager startUpdatingLocation];
}

@end
