//
//  SpecialViewCell.h
//  WQAppForKongKongHu
//
//  Created by 王祺祺 on 2016/10/28.
//  Copyright © 2016年 wangqiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *imageBackView;
@property (weak, nonatomic) IBOutlet UILabel *typeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *clothDetailLabel;
@property (weak, nonatomic) IBOutlet UIView *tagBtnBackView;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property(nonatomic,strong)NSArray * imageArray;
@property(nonatomic,strong)NSArray * tagArray;

-(void)createImageView;
-(void)creatTagBtn;
@end
