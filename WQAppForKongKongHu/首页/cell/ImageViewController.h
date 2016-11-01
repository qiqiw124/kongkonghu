//
//  ImageViewController.h
//  FFCBW-2016
//
//  Created by 王祺祺 on 16/5/10.
//  Copyright © 2016年 com.audionew.sdr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController
@property(nonatomic,strong)NSArray * netimageArray;//网络图片预览
-(void)loadImageWithUrl:(NSString *)strUrl imageId:(NSString *)ID indexOfArray:(NSNumber *)inde;
@end
