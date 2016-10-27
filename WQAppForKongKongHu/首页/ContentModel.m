//
//  ContentModel.m
//  WQAppForKongKongHu
//
//  Created by 王祺祺 on 2016/10/21.
//  Copyright © 2016年 wangqiqi. All rights reserved.
//

#import "ContentModel.h"
#import "WNetRequest.h"
#import "WQBaseNet.h"
@implementation ContentModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(void)loadDataWithPage:(NSNumber *)pageNumber typeId:(NSNumber *)contentType viewWith:(UIView *)backView arrayBlock:(ContentArrayBlock)block
{
    NSMutableArray * totalArray = [[NSMutableArray alloc]init];
    NSDictionary * dict = @{@"id":contentType,@"pageNum":pageNumber,@"version":@"2.3.0"};
    [WNetRequest requestWithPostTypeWithUrl:WSpecial textDict:dict didBlock:^(NSDictionary *dict, NSError *error) {
        if(error == nil)
        {
            NSArray * dataArray = dict[@"data"];
            for(NSDictionary * lisDict in dataArray)
            {
                NSArray * inArray = lisDict[@"list"];
                NSDictionary * dataDict = inArray[0][@"data"];
                if([lisDict[@"style"][@"type"] isEqualToString:@"KKActivityEntity"])
                {
                    ContentModel * model = [[ContentModel alloc]init];
                    model.webUrl = dataDict[@"url"];
                    model.webName = dataDict[@"name"];
                    model.webImageUrl = dataDict[@"pic"];
                    model.type = @"KKActivityEntity";
                    [totalArray addObject:model];
                }
                else
                {
                    NSDictionary * themeDict = dataDict[@"theme"];
                    ContentModel * model = [[ContentModel alloc]init];
                    model.specialId = themeDict[@"id"];
                    model.cover = themeDict[@"cover"];
                    model.viewCount = themeDict[@"viewCount"];
                    model.imagedescription = themeDict[@"description"];
                    model.subName = themeDict[@"subName"];
                    model.clothesName = themeDict[@"name"];
                    model.themeCover = themeDict[@"themeCover"];
                    model.type = @"KKThemeEntity";
                    NSArray * productArray = dataDict[@"products"];
                    for(NSDictionary * proDict in productArray)
                    {
                        ContentModel * proModel = [[ContentModel alloc]init];
                        proModel.currentPrice = proDict[@"currentPrice"];
                        proModel.littleCover = proDict[@"cover"];
                        proModel.littleName = proDict[@"brand"];
                        [model.products addObject:proModel];
                    }
                    [totalArray addObject:model];
                }
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


-(NSMutableArray *)products
{
    if(_products == nil)
    {
        _products = [[NSMutableArray alloc]init];
    }
    return _products;
}



@end
