//
//  SpecialViewCell.m
//  WQAppForKongKongHu
//
//  Created by 王祺祺 on 2016/10/28.
//  Copyright © 2016年 wangqiqi. All rights reserved.
//

#import "SpecialViewCell.h"
#import "UIImageView+WebCache.h"
@implementation SpecialViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    [self creatTagBtn];
    [self.collectionBtn setImageEdgeInsets:UIEdgeInsetsMake(3, 0, 3, 25)];
    [self.collectionBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 0)];
    [self.commentBtn setImageEdgeInsets:UIEdgeInsetsMake(3, 0, 3, 25)];
    [self.commentBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 0)];
    [self.favoriteBtn setImageEdgeInsets:UIEdgeInsetsMake(3, 0, 3, 25)];
    [self.favoriteBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    self.userImage.layer.cornerRadius = 20;
    self.userImage.layer.masksToBounds = YES;
}
/**
 创建标签button
 */
-(void)creatTagBtn
{
    NSArray * array = self.tagBtnBackView.subviews;
    for(UIButton * btn in array)
    {//先移除上个cell的btn
        [btn removeFromSuperview];
    }
    if(self.tagArray.count>0)
    {
        self.tagBtnBackView.hidden = NO;
        for(int i=0;i <self.tagArray.count;i++)
        {
            UIButton * tagBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*(60+5), 0, 60, 30)];
            [tagBtn setTitle:self.tagArray[i][@"name"] forState:UIControlStateNormal];
            tagBtn.backgroundColor = [UIColor lightGrayColor];
            [tagBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            tagBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            tagBtn.layer.cornerRadius = 15;
            tagBtn.layer.masksToBounds = YES;
            tagBtn.backgroundColor =[UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
            [self.tagBtnBackView addSubview:tagBtn];
        }
    }
    else
    {
        self.tagBtnBackView.hidden = YES;
        
    }
}
//创建imageView
-(void)createImageView
{
    NSArray * array = self.imageBackView.subviews;
    if(array)
    {
        for(UIImageView * image in array)
        {//先移除上个cell的imageView
            [image removeFromSuperview];
        }
    }
    
    if(self.imageArray.count == 1)
    {
        UIImageView * imageVc = [[UIImageView alloc]initWithFrame:CGRectMake((self.imageBackView.frame.size.width - self.imageBackView.frame.size.height)/2, 0, self.imageBackView.frame.size.height, self.imageBackView.frame.size.height)];
        [imageVc sd_setImageWithURL:[NSURL URLWithString:self.imageArray[0]]];
        [self.imageBackView addSubview:imageVc];
    }
    else if(self.imageArray.count == 2)
    {
        for(int i=0;i<self.imageArray.count;i ++)
        {
            UIImageView * imageVc = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.imageBackView.frame.size.width/2, 0, self.imageBackView.frame.size.width/2, self.imageBackView.frame.size.height)];
            [imageVc sd_setImageWithURL:[NSURL URLWithString:self.imageArray[i]]];
            [self.imageBackView addSubview:imageVc];
        }
    }
    else if (self.imageArray.count>=3)
    {
        UIImageView * bigImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 2*(self.imageBackView.frame.size.width/3), self.imageBackView.frame.size.height)];
        [bigImage sd_setImageWithURL:[NSURL URLWithString:self.imageArray[0]]];
        [self.imageBackView addSubview:bigImage];
        
        UIImageView * twoImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bigImage.frame)+3, 0, self.imageBackView.frame.size.width-(CGRectGetMaxX(bigImage.frame)+3), (self.imageBackView.frame.size.height - 3)/2)];
        [twoImage sd_setImageWithURL:[NSURL URLWithString:self.imageArray[1]]];
        [self.imageBackView addSubview:twoImage];
        
        UIImageView * threeImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bigImage.frame)+3, CGRectGetMaxY(twoImage.frame)+3, CGRectGetWidth(twoImage.frame), CGRectGetHeight(twoImage.frame))];
        [threeImage sd_setImageWithURL:[NSURL URLWithString:self.imageArray[2]]];
        [self.imageBackView addSubview:threeImage];
        if(self.imageArray.count>3)
        {
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(self.imageBackView.frame.size.width-50, self.imageBackView.frame.size.height-50, 50, 50)];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [NSString stringWithFormat:@"3/%lu",(unsigned long)self.imageArray.count];
            label.textColor = [UIColor whiteColor];
            [self.imageBackView addSubview:label];
        }
        
    }

}
@end
