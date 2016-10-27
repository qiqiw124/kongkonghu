//
//  ImageModel.h
//  WQAppForKongKongHu
//
//  Created by 王祺祺 on 2016/10/20.
//  Copyright © 2016年 wangqiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject
//图片model
@property(nonatomic,copy)NSString * linkUrl;
@property(nonatomic,copy)NSString * imageUrl;
@property(nonatomic,strong)NSNumber *bizId;


//类型model
@property(nonatomic,copy)NSString * showName;//类型名字
@property(nonatomic,strong)NSNumber * showStyleID;//类型id
@end
