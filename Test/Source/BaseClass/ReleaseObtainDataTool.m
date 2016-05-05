//
//  ReleaseObtainDataTool.m
//  Test
//
//  Created by jang on 16/3/3.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "ReleaseObtainDataTool.h"
static ReleaseObtainDataTool *rd;
@implementation ReleaseObtainDataTool

//单例初始化工具类
+(ReleaseObtainDataTool *)shareReleaseData
{
    static dispatch_once_t once_token;
    if (rd == nil) {
        dispatch_once(&once_token, ^{
            rd = [[ReleaseObtainDataTool alloc]init];
        });
    }
    return rd;
}

//发布车源
-(BOOL)podShareOption:(Options *)aOptions
{
    AVObject *postOption = [AVObject objectWithClassName:@"Option"];
    
    [postOption setObject:aOptions.username forKey:@"driverID"];
    [postOption setObject:aOptions.origin forKey:@"origin"];
    [postOption setObject:aOptions.destination forKey:@"destination"];
    [postOption setObject:aOptions.truckType forKey:@"truckType"];
    [postOption setObject:aOptions.length forKey:@"length"];
    [postOption setObject:aOptions.number forKey:@"number"];
    [postOption setObject:aOptions.load forKey:@"load"];
    [postOption setObject:aOptions.volume forKey:@"volume"];
    [postOption setObject:aOptions.time forKey:@"time"];
    [postOption setObject:aOptions.note forKey:@"note"];
    [postOption setObject:aOptions.sendTime forKey:@"sendTime"];
    [postOption setObject:@"未预约" forKey:@"carState"];
    
    NSError *error = [[NSError alloc]init];
    if ([postOption save:&error]) {
        return YES;
    }else{
        return NO;
    }
    
}

//获取货源
-(void)getShareCargoInfo:(NSString *)location PassValue:(ReleaseObtainPassValue)passValue
{
    NSMutableArray *tempArr = [NSMutableArray array];
    

    
    
    AVQuery *locationQuery = [AVQuery queryWithClassName:@"CargoInfo"];
    [locationQuery whereKey:@"origin" equalTo:location];
    
    AVQuery *stateQuery = [AVQuery queryWithClassName:@"CargoInfo"];
    [stateQuery whereKey:@"orderState" equalTo:@"未接单"];
    
    AVQuery *query = [AVQuery andQueryWithSubqueries:[NSArray arrayWithObjects:locationQuery,stateQuery,nil]];

    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // 检索成功
            for (AVQuery *q in objects) {
                CargoInfo *aCargoInfo = [[CargoInfo alloc]init];
                aCargoInfo.username = [q valueForKey:@"username"];
                aCargoInfo.origin = [q valueForKey:@"origin"];
                aCargoInfo.destination = [q valueForKey:@"destination"];
                aCargoInfo.note = [q valueForKey:@"note"];
                aCargoInfo.truckType = [q valueForKey:@"truckType"];
                aCargoInfo.length = [q valueForKey:@"length"];
                aCargoInfo.number = [q valueForKey:@"number"];
                aCargoInfo.load = [q valueForKey:@"load"];
                aCargoInfo.volume = [q valueForKey:@"volume"];
                aCargoInfo.price = [q valueForKey:@"price"];
                aCargoInfo.phoneNumber = [q valueForKey:@"phoneNumber"];
                aCargoInfo.sendTime = [q valueForKey:@"sendTime"];
                aCargoInfo.objectId = [q valueForKey:@"objectId"];
                aCargoInfo.orderState = [q valueForKey:@"orderState"];
                [tempArr addObject:aCargoInfo];
            }
            passValue(tempArr);
        } else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(void)getShareCargoInfoWithOrigin:(NSString *)origin Destination:(NSString *)destination PassValue:(ReleaseObtainPassValue)passValue
{
    NSMutableArray *tempArr = [NSMutableArray array];
    
    
    AVQuery *priorityQuery = [AVQuery queryWithClassName:@"CargoInfo"];
    [priorityQuery whereKey:@"origin" equalTo:origin];
    
    AVQuery *statusQuery = [AVQuery queryWithClassName:@"CargoInfo"];
    [statusQuery whereKey:@"destination" equalTo:destination];
    
    AVQuery *stateQuery = [AVQuery queryWithClassName:@"CargoInfo"];
    [stateQuery whereKey:@"orderState" equalTo:@"未接单"];
    
    AVQuery *query = [AVQuery andQueryWithSubqueries:[NSArray arrayWithObjects:statusQuery,priorityQuery,stateQuery,nil]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // 检索成功
            for (AVQuery *q in objects) {
                CargoInfo *aCargoInfo = [[CargoInfo alloc]init];
                aCargoInfo.username = [q valueForKey:@"username"];
                aCargoInfo.origin = [q valueForKey:@"origin"];
                aCargoInfo.destination = [q valueForKey:@"destination"];
                aCargoInfo.note = [q valueForKey:@"note"];
                aCargoInfo.truckType = [q valueForKey:@"truckType"];
                aCargoInfo.length = [q valueForKey:@"length"];
                aCargoInfo.number = [q valueForKey:@"number"];
                aCargoInfo.load = [q valueForKey:@"load"];
                aCargoInfo.volume = [q valueForKey:@"volume"];
                aCargoInfo.price = [q valueForKey:@"price"];
                aCargoInfo.phoneNumber = [q valueForKey:@"phoneNumber"];
                aCargoInfo.sendTime = [q valueForKey:@"sendTime"];
                aCargoInfo.objectId = [q valueForKey:@"objectId"];
                [tempArr addObject:aCargoInfo];
            }
            passValue(tempArr);
        } else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end
