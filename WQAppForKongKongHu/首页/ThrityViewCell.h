//
//  ThrityViewCell.h
//  WQAppForKongKongHu
//
//  Created by 王祺祺 on 2016/10/27.
//  Copyright © 2016年 wangqiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThrityViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;

@end
