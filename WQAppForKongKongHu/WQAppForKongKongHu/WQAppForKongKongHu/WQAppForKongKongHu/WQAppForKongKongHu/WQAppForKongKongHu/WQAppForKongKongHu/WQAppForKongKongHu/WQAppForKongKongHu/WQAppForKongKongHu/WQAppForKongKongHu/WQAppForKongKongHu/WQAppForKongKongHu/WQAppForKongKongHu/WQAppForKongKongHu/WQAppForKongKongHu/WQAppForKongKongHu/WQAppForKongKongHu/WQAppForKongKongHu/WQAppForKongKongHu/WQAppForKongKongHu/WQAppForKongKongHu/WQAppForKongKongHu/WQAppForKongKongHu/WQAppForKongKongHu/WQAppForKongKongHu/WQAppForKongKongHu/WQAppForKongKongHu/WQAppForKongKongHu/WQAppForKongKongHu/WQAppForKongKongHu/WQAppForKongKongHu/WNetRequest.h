//
//  WNetRequest.h
//  WQAppForKongKongHu
//
//  Created by 王祺祺 on 2016/10/20.
//  Copyright © 2016年 wangqiqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MBProgressHUD.h"

typedef void(^DataDictBlock)(NSDictionary * dict,NSError * error);
@interface WNetRequest : NSObject

/**
 get数据请求

 @param questUrl    请求的url
 @param paramerDict 需要传递的参数字典
 @param block       返回的数据block
 */
+(void)requestWithGetTypeWithUrl:(NSString *)questUrl textDict:(NSDictionary *)paramerDict didBlock:(DataDictBlock)block;

+(void)showMbProgressText:(NSString *)hudText WithTime:(NSTimeInterval)time WithView:(UIView *)BackView;

@end
