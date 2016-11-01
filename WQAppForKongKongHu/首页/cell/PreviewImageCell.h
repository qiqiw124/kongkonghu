//
//  PreviewImageCell.h
//  FFCBW-2016
//
//  Created by 王祺祺 on 16/5/28.
//  Copyright © 2016年 com.audionew.sdr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreviewImageCell : UICollectionViewCell
//@property (weak, nonatomic) IBOutlet UIImageView *preImageView;
@property(nonatomic,strong)UIImageView * preImageView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end
