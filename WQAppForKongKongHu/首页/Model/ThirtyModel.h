//
//  ThirtyModel.h
//  WQAppForKongKongHu
//
//  Created by 王祺祺 on 2016/10/27.
//  Copyright © 2016年 wangqiqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^ContentArrayBlock)(NSMutableArray * contentArray);
@interface ThirtyModel : NSObject
@property(nonatomic,copy)NSString * brand;//名字
@property(nonatomic,copy)NSString * category;//类型
@property(nonatomic,copy)NSString * cover;//图片
@property(nonatomic,strong)NSNumber * currentPrice;//价格
@property(nonatomic,strong)NSNumber * favorites;//点赞数

/**
 请求数据
 
 @param pageNumber  页码
 @param contentType 类型
 @param backView    父视图
 @param block       返回数组
 */
+(void)loadDataWithPage:(NSNumber *)pageNumber typeId:(NSNumber *)contentType viewWith:(UIView *)backView arrayBlock:(ContentArrayBlock)block;

@end
