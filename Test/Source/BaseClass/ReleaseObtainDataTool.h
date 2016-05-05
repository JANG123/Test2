//
//  ReleaseObtainDataTool.h
//  Test
//
//  Created by jang on 16/3/3.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ReleaseObtainPassValue)(NSArray *array);

@interface ReleaseObtainDataTool : NSObject

//单例初始化工具类
+(ReleaseObtainDataTool *)shareReleaseData;

//发布车源
-(BOOL)podShareOption:(Options *)aOptions;

//获取货源
-(void)getShareCargoInfo:(NSString *)location PassValue:(ReleaseObtainPassValue)passValue;

//查询货源
-(void)getShareCargoInfoWithOrigin:(NSString *)origin Destination:(NSString *)destination PassValue:(ReleaseObtainPassValue)passValue;

@end
