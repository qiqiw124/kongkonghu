//
//  ThirtyModel.h
//  WQAppForKongKongHu
//
//  Created by 王祺祺 on 2016/10/27.
//  Copyright © 2016年 wangqiqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//30和全新
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

//精选和母婴
@property(nonatomic,copy)NSString * clothDetail;
@property(nonatomic,strong)NSArray * productTags;
@property(nonatomic,copy)NSString * tagName;
@property(nonatomic,strong)NSNumber * originalPrice;
@property(nonatomic,copy)NSString * size;
@property(nonatomic,strong)NSArray * productImages;
@property(nonatomic,copy)NSString * headpic;
@property(nonatomic,copy)NSString * nickname;

/**
 请求精选和母婴数据
 
 @param pageNumber  页码
 @param contentType 类型
 @param backView    父视图
 @param block       返回数组
 */
+(void)loadSpecialDataWithPage:(NSNumber *)pageNumber typeId:(NSNumber *)contentType viewWith:(UIView *)backView arrayBlock:(ContentArrayBlock)block;


@end
