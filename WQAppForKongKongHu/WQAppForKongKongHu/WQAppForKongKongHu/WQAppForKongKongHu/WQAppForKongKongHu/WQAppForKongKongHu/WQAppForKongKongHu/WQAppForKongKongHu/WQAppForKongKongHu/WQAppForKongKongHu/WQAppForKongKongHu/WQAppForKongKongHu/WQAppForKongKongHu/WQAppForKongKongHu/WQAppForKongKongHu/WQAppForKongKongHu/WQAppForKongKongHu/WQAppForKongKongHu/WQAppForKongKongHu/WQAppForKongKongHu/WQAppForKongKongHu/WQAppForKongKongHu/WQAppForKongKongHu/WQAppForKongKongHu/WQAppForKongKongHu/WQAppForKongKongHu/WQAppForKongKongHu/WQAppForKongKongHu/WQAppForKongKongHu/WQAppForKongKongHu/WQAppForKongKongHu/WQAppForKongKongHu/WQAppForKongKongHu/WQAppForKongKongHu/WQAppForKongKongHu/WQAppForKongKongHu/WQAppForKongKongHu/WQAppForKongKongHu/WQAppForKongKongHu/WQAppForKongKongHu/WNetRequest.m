//
//  WNetRequest.m
//  WQAppForKongKongHu
//
//  Created by 王祺祺 on 2016/10/20.
//  Copyright © 2016年 wangqiqi. All rights reserved.
//

#import "WNetRequest.h"

@implementation WNetRequest

+(void)requestWithGetTypeWithUrl:(NSString *)questUrl textDict:(NSDictionary *)paramerDict didBlock:(DataDictBlock)block
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:questUrl parameters:paramerDict success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary * dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            block(dataDict,nil);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            block(nil,error);
        }];
    });
}

+(void)showMbProgressText:(NSString *)hudText WithTime:(NSTimeInterval)time WithView:(UIView *)BackView
{
    MBProgressHUD * hud = [[MBProgressHUD alloc]init];
    [BackView addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    [hud show:YES];
    hud.labelText = hudText;
    [hud hide:YES afterDelay:time];
}
@end
