//
//  ContentModel.h
//  WQAppForKongKongHu
//
//  Created by 王祺祺 on 2016/10/21.
//  Copyright © 2016年 wangqiqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^ContentArrayBlock)(NSMutableArray * contentArray);
@interface ContentModel : NSObject
@property(nonatomic,copy)NSString * type;//类型
@property(nonatomic,strong)NSNumber * specialId;
@property(nonatomic,copy)NSString * cover;//大图地址
@property(nonatomic,strong)NSNumber * viewCount;//查看数目
@property(nonatomic,copy)NSString * imagedescription;//描述 详情
@property(nonatomic,copy)NSString * subName;//title名字 详情
@property(nonatomic,copy)NSString * clothesName;//衣服名字
@property(nonatomic,copy)NSString * themeCover;//详情图片地址
@property(nonatomic,strong)NSMutableArray * products;//小物品数组

@property(nonatomic,strong)NSNumber *currentPrice;//小物品价格
@property(nonatomic,copy)NSString * littleCover;//小物品图片
@property(nonatomic,copy)NSString * littleName;//小物品名字


@property(nonatomic,copy)NSString * webUrl;
@property(nonatomic,copy)NSString * webImageUrl;
@property(nonatomic,copy)NSString * webName;


/**
 请求数据

 @param pageNumber  页码
 @param contentType 类型
 @param backView    父视图
 @param block       返回数组
 */
+(void)loadDataWithPage:(NSNumber *)pageNumber typeId:(NSNumber *)contentType viewWith:(UIView *)backView arrayBlock:(ContentArrayBlock)block;
@end
