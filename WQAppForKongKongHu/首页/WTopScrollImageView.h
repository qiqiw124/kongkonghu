//
//  WTopScrollImageView.h
//  WQAppForKongKongHu
//
//  Created by 王祺祺 on 2016/10/20.
//  Copyright © 2016年 wangqiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^nameBlcok)(NSString * str);
@protocol WTopScrollImageDelegate <NSObject>

/**
 imageScrollDelegate

 @param urlStr 传过去点击图片的url
 */
@optional
-(void)pushWithUrl:(NSString *)urlStr;

/**
 typeBtnDelegate

 @param typeId 传过去点击类型的id
 */
@optional
-(void)typeChangeContentUrl:(NSNumber *)typeId;

@end
@interface WTopScrollImageView : UIView
@property(nonatomic,assign)id<WTopScrollImageDelegate>delegate;
@property(nonatomic,strong)NSTimer * scrollTime;


/**
 精选类型

 @param frame    大小
 @param color 颜色 只是为了跟系统的区分开

 @return self
 */
-(instancetype)initWithFrame:(CGRect)frame withColor:(UIColor*)color;



@end
