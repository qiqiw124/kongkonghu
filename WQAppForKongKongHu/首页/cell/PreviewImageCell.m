//
//  PreviewImageCell.m
//  FFCBW-2016
//
//  Created by 王祺祺 on 16/5/28.
//  Copyright © 2016年 com.audionew.sdr. All rights reserved.
//

#import "PreviewImageCell.h"
@interface PreviewImageCell ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIView *imageContainerView;

@end
@implementation PreviewImageCell
-(void)createScroll
{
    self.backgroundColor = [UIColor blackColor];
    _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    _scrollView.bouncesZoom = YES;
    _scrollView.maximumZoomScale = 2.5;
    _scrollView.minimumZoomScale = 1.0;
    
    _scrollView.multipleTouchEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.scrollsToTop = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_scrollView];
    _imageContainerView = [[UIView alloc] initWithFrame:CGRectMake(10, -20, [UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.height - 70)];
    _imageContainerView.userInteractionEnabled = YES;
    [_scrollView addSubview:_imageContainerView];
    _preImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _imageContainerView.frame.size.width, _imageContainerView.frame.size.height)];
    [_imageContainerView addSubview:self.preImageView];

}


#pragma mark - UIScrollViewDelegate

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageContainerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.frame.size.width > scrollView.contentSize.width) ? (scrollView.frame.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.frame.size.height > scrollView.contentSize.height) ? (scrollView.frame.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imageContainerView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY - 20);
}



- (void)awakeFromNib {
    [super awakeFromNib];
    [self createScroll];
}

@end
