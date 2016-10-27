//
//  WQFirstViewController.m
//  WQAppForKongKongHu
//
//  Created by 王祺祺 on 2016/10/20.
//  Copyright © 2016年 wangqiqi. All rights reserved.
//

#import "WQFirstViewController.h"
#import "UIImageView+WebCache.h"
#import "WTopScrollImageView.h"//头部滚动图片
#import "WQBaseNet.h"//接口
#import "WQWebViewController.h"//显示web页面
#import "MJRefresh.h"
#import "ContentModel.h"//model
#import "WcontentViewCell.h"
#import "WwebViewCell.h"
@interface WQFirstViewController ()<WTopScrollImageDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)WTopScrollImageView * wscrollView;
@property(nonatomic,strong)NSNumber * typeId;//类型ID
@property(nonatomic,assign)NSInteger pageNumber;//页数
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)WTopScrollImageView * typeVc;
@property(nonatomic,strong)UIView * backView;
@property(nonatomic,strong)UICollectionView * collectView;

@end

@implementation WQFirstViewController
-(NSMutableArray *)dataArray
{
    if(_dataArray == nil)
    {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNumber = 1;
    [self creatCollectView];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_wscrollView.scrollTime setFireDate:[NSDate distantPast]];
   
}
-(void)viewDidDisappear:(BOOL)animated
{
    [_wscrollView.scrollTime setFireDate:[NSDate distantFuture]];
}
-(void)creatCollectView
{
    self.hidesBottomBarWhenPushed = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, ViewWidth, ViewHight-106) collectionViewLayout:flowLayout];
    flowLayout.headerReferenceSize = CGSizeMake(ViewWidth, 250);
    _collectView.delegate = self;
    _collectView.dataSource = self;
    _collectView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [_collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    [self.view addSubview:_collectView];
    [self.collectView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [_collectView registerNib:[UINib nibWithNibName:@"WcontentViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [_collectView registerNib:[UINib nibWithNibName:@"WwebViewCell" bundle:nil] forCellWithReuseIdentifier:@"webCell"];
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, 250)];
    
    
    //headView
    self.wscrollView = [[WTopScrollImageView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, 200)];
    self.wscrollView.delegate = self;
    [self.backView addSubview:self.wscrollView];
    self.typeVc = [[WTopScrollImageView alloc]initWithFrame:CGRectMake(0, 205, ViewWidth, 40) withColor:[UIColor whiteColor]];
    self.typeVc.delegate = self;
    [self.backView addSubview:self.typeVc];
}
//注册头视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
   UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
    [headerView addSubview:self.backView];
    return  headerView;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *autocell;
   
    ContentModel * model = self.dataArray[indexPath.row];
    if( ![model.type  isEqual: @"KKActivityEntity"])
    {
        WcontentViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        [cell.bigImageView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
        cell.scanLabel.text = [NSString stringWithFormat:@"%@",model.viewCount];
        for(int i =0;i <model.products.count;i ++)
        {
            ContentModel * smallModel = model.products[i];
            if(i==0)
            {
                [cell.firstImageView sd_setImageWithURL:[NSURL URLWithString:smallModel.littleCover]];
                cell.firstmonyLabel.text = [NSString stringWithFormat:@"¥%@",smallModel.currentPrice];
                cell.firstNameLabel.text = smallModel.littleName;
            }
            else if (i==1)
            {
                [cell.twoImageView sd_setImageWithURL:[NSURL URLWithString:smallModel.littleCover]];
                cell.twomoneyLabel.text = [NSString stringWithFormat:@"¥%@",smallModel.currentPrice];
                cell.twoNameLabel.text = smallModel.littleName;
            }
            else
            {
                [cell.threeImageView sd_setImageWithURL:[NSURL URLWithString:smallModel.littleCover]];
                cell.threemoneyLabel.text = [NSString stringWithFormat:@"¥%@",smallModel.currentPrice];
                cell.threeNameLabe.text = smallModel.littleName;
            }
        }
        autocell = cell;

    }
    else
    {
        WwebViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"webCell" forIndexPath:indexPath];
        [cell.backImageVIew sd_setImageWithURL:[NSURL URLWithString:model.webImageUrl]];
        autocell = cell;
    }
    
    return autocell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ContentModel * model = self.dataArray[indexPath.item];
    if([model.type isEqualToString:@"KKActivityEntity"])
    {
        return CGSizeMake(ViewWidth, 200);
    }
    return CGSizeMake(ViewWidth, 370);
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if(self.collectView.contentOffset.y >= 205)
    {
        [self.typeVc removeFromSuperview];
        self.typeVc.frame = CGRectMake(0, 64, ViewWidth, 40);
        [self.navigationController.view addSubview:self.typeVc];
    }
    else
    {
        [self.typeVc removeFromSuperview];
        self.typeVc.frame = CGRectMake(0, 205, ViewWidth, 40);
        [self.backView addSubview:self.typeVc];
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ContentModel * model = self.dataArray[indexPath.row];
    if([model.type isEqualToString:@"KKActivityEntity"] && model.webUrl.length>0)
    {
        WQWebViewController * webC = [[WQWebViewController alloc]init];
        webC.requestWebUrl = model.webUrl;
        UINavigationController * navc = [[UINavigationController alloc]initWithRootViewController:webC];
        [self presentViewController:navc animated:NO completion:nil];

    }
}

/**
 下载数据
 */
-(void)loadDataForType
{
        [ContentModel loadDataWithPage:@(self.pageNumber) typeId:self.typeId viewWith:self.view arrayBlock:^(NSMutableArray *contentArray) {
            if(self.dataArray.count >0)
            {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:contentArray];
            
            dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectView reloadData];
            
            });
        }];
 
    
}





#pragma mark WTopScrollImageDelegate
/**
 WTopScrollImageDelegate

 @param urlStr 请求的网页url
 */
-(void)pushWithUrl:(NSString *)urlStr
{
    WQWebViewController * webVc = [[WQWebViewController alloc]init];
    webVc.requestWebUrl = urlStr;
    UINavigationController * navc = [[UINavigationController alloc]initWithRootViewController:webVc];
    [self.navigationController presentViewController:navc animated:NO completion:nil];
    
}

/**
 选择不同的类型 请获取不同的id

 @param typeId 类型id
 */
-(void)typeChangeContentUrl:(NSNumber *)typeId
{
    self.typeId = typeId;
    [self loadDataForType];
    
}
-(void)dealloc
{
    [self.collectView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
