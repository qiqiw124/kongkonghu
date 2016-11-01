//
//  ImageViewController.m
//  FFCBW-2016
//
//  Created by 王祺祺 on 16/5/10.
//  Copyright © 2016年 com.audionew.sdr. All rights reserved.
//

#import "ImageViewController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "WQBaseNet.h"
#import "AFNetworking.h"
#import "PreviewImageCell.h"
@interface ImageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic,copy)NSString * urlString;
@property(nonatomic,strong)UIImage * imageShow;
@property(nonatomic,strong)UICollectionView * collectView;
@property(nonatomic,strong)UIImageView * loadImage;
@property(nonatomic,strong)UIPageControl * pageControl;
@end
@implementation ImageViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.loadImage = [[UIImageView alloc]init];
    self.view.bounds = [UIScreen mainScreen].bounds;
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(missView)];
    [self.imageView addGestureRecognizer:tap];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.imageView.frame.size.height) collectionViewLayout:flowLayout];
    _collectView.delegate = self;
    _collectView.dataSource = self;
    _collectView.pagingEnabled = YES;
    _collectView.backgroundColor = [UIColor clearColor];
    [self.imageView addSubview:_collectView];
    [_collectView registerNib:[UINib nibWithNibName:@"PreviewImageCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    _pageControl.numberOfPages = self.netimageArray.count;
    [self.view addSubview:_pageControl];
}

-(void)missView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.netimageArray = nil;
    _collectView.contentOffset = CGPointMake(0, 0);
}

/**
 *  //点击网络图片进来
 *
 *  @param strUrl 当前被点击进来的网络图片地址
 *  @param ID     图片id
 *  @param inde   图片在数组里的位置
 */
-(void)loadImageWithUrl:(NSString *)strUrl imageId:(NSString *)ID indexOfArray:(NSNumber *)inde
{
    self.urlString = strUrl;
    
}

#pragma mark collectionviewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.netimageArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PreviewImageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.preImageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.scrollView.zoomScale = 1.0;
    if(indexPath.item < self.netimageArray.count)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.preImageView sd_setImageWithURL:[NSURL URLWithString:self.netimageArray[indexPath.item]] placeholderImage:[UIImage imageNamed:@"加载失败"]];
        });
        
    }
return cell;
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectView.frame.size.width , self.collectView.frame.size.height);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageControl.currentPage = self.collectView.contentOffset.x/self.collectView.frame.size.width;
}
@end
