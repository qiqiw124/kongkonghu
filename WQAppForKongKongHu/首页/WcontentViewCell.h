//
//  WcontentViewCell.h
//  WQAppForKongKongHu
//
//  Created by 王祺祺 on 2016/10/26.
//  Copyright © 2016年 wangqiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WcontentViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UILabel *scanLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstmonyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *twoImageView;
@property (weak, nonatomic) IBOutlet UILabel *twoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *twomoneyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *threeImageView;
@property (weak, nonatomic) IBOutlet UILabel *threeNameLabe;
@property (weak, nonatomic) IBOutlet UILabel *threemoneyLabel;

@end
