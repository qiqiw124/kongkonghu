//
//  ThirtyModel.m
//  WQAppForKongKongHu
//
//  Created by 王祺祺 on 2016/10/27.
//  Copyright © 2016年 wangqiqi. All rights reserved.
//

#import "ThirtyModel.h"
#import "WNetRequest.h"
#import "WQBaseNet.h"
@implementation ThirtyModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
+(void)loadDataWithPage:(NSNumber *)pageNumber typeId:(NSNumber *)contentType viewWith:(UIView *)backView arrayBlock:(ContentArrayBlock)block
{
    NSMutableArray * totalArray = [[NSMutableArray alloc]init];
    NSDictionary * Indict = @{@"id":contentType,@"pageNum":pageNumber,@"version":@"2.3.0"};
    [WNetRequest requestWithPostTypeWithUrl:WSpecial textDict:Indict didBlock:^(NSDictionary *dict, NSError *error) {
        if(error == nil)
        {
            
            NSArray * listArray = [dict[@"data"] objectAtIndex:0][@"list"];
            for(NSDictionary * onlyDict in listArray)
            {
                NSDictionary * productDict = onlyDict[@"data"][@"product"];
                ThirtyModel * model = [[ThirtyModel alloc]init];
                model.brand = productDict[@"brand"];
                model.category = productDict[@"category"];
                model.cover = productDict[@"cover"];
                model.currentPrice = productDict[@"currentPrice"];
                model.favorites = productDict[@"favorites"];
                [totalArray addObject:model];
            }
            block(totalArray);
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [WNetRequest showMbProgressText:[NSString stringWithFormat:@"请求失败code-%ld",(long)error.code] WithTime:1 WithView:backView];
            });
            block(nil);
        }
    }];
}


+(void)loadSpecialDataWithPage:(NSNumber *)pageNumber typeId:(NSNumber *)contentType viewWith:(UIView *)backView arrayBlock:(ContentArrayBlock)block
{
    NSMutableArray * totalArray = [[NSMutableArray alloc]init];
    NSDictionary * Indict = @{@"id":contentType,@"pageNum":pageNumber,@"version":@"2.3.0"};
    [WNetRequest requestWithPostTypeWithUrl:WSpecial textDict:Indict didBlock:^(NSDictionary *dict, NSError *error) {
        if(error == nil)
        {
            
            NSArray * listArray = [dict[@"data"] objectAtIndex:0][@"list"];
            for(NSDictionary * onlyDict in listArray)
            {
                NSDictionary * productDict = onlyDict[@"data"][@"product"];
                ThirtyModel * model = [[ThirtyModel alloc]init];
                model.brand = productDict[@"brand"];
                model.category = productDict[@"category"];
                model.cover = productDict[@"cover"];
                model.currentPrice = productDict[@"currentPrice"];
                model.favorites = productDict[@"favorites"];
                model.originalPrice = productDict[@"originalPrice"];
                model.productTags = productDict[@"productTags"];
                model.size = productDict[@"size"];
                model.productImages = onlyDict[@"data"][@"productImages"];
                model.headpic =onlyDict[@"data"][@"user"][@"headpic"];
                model.nickname =onlyDict[@"data"][@"user"][@"nickname"];
                model.clothDetail = productDict[@"description"];
                [totalArray addObject:model];
            }
            block(totalArray);
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [WNetRequest showMbProgressText:[NSString stringWithFormat:@"请求失败code-%ld",(long)error.code] WithTime:1 WithView:backView];
            });
            block(nil);
        }
    }];

}
@end
