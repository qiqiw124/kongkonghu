//
//  WTopScrollImageView.m
//  WQAppForKongKongHu
//
//  Created by 王祺祺 on 2016/10/20.
//  Copyright © 2016年 wangqiqi. All rights reserved.
//

#import "WTopScrollImageView.h"
#import "WNetRequest.h"
#import "WQBaseNet.h"
#import "UIImageView+WebCache.h"
#import "ImageModel.h"

@interface WTopScrollImageView()
@property(nonatomic,strong)UIScrollView * imageScrollView;//图片ScrollView
@property(nonatomic,strong)NSMutableArray * imageArray;//图片数组
@property(nonatomic,strong)UIPageControl * pageControl;
@property(nonatomic,strong)UIScrollView * labelScrollView;//类型


/**
 精选
 */
@property(nonatomic,strong)UIScrollView * typeScroll;//类型
@property(nonatomic,strong)NSMutableArray * typeArray;
@property(nonatomic,strong)UILabel * lineLabel;//下划线
@property(nonatomic,strong)UIButton * lastBtn;//上个button

@end


@implementation WTopScrollImageView
-(NSMutableArray *)typeArray
{
    if(_typeArray == nil)
    {
        _typeArray = [[NSMutableArray alloc]init];
        
    }
    return _typeArray;
}
-(NSMutableArray *)imageArray
{
    if(_imageArray == nil)
    {
        _imageArray= [[NSMutableArray alloc]init];
    }
    return _imageArray;
}
//头图片
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        [self analysisDict];
        
    }
    return self;
}

/**
 请求数据
 */
-(void)analysisDict
{
    [WNetRequest requestWithGetTypeWithUrl:WTopImageUrl textDict:nil didBlock:^(NSDictionary *dict, NSError *error) {
        if(error == nil)
        {
            NSMutableArray * modelArray = [[NSMutableArray alloc]init];
            NSArray * dataArray = dict[@"events"];
            for(NSDictionary * onlyDict in dataArray)
            {
                ImageModel * model = [[ImageModel alloc]init];
                model.imageUrl = onlyDict[@"pic"];
                model.linkUrl = onlyDict[@"link"];
                model.bizId = onlyDict[@"bizId"];
                [modelArray addObject:model];
            }
            [self.imageArray addObjectsFromArray:modelArray];
            dispatch_async(dispatch_get_main_queue(), ^{
               [self configImageUI];
            [self createLabelType];
            });
            
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                 [WNetRequest showMbProgressText:[NSString stringWithFormat:@"请求失败 code-%ld",(long)error.code] WithTime:1 WithView:self.superview];
            });
           
        }
    }];
}

/**
 创建界面图片
 */
-(void)configImageUI
{
    self.userInteractionEnabled = YES;
    _imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 75)];
    _imageScrollView.bouncesZoom = NO;
    _imageScrollView.showsHorizontalScrollIndicator = NO;
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageScrollView.frame)-30, self.frame.size.width, 30)];
    _pageControl.numberOfPages = self.imageArray.count;
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPage = 0;
    [self addSubview:_imageScrollView];
    [self addSubview:_pageControl];
    for(int i = 0;i <self.imageArray.count + 1;i ++)
    {
        ImageModel * model = [[ImageModel alloc]init];
        
        UIButton * netImage = [[UIButton alloc]initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        netImage.userInteractionEnabled = YES;
        if(i< self.imageArray.count)
        {
            model = self.imageArray[i];
            netImage.tag = i;
            [netImage addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
        
        }
        else
        {
            model = self.imageArray[0];
            
        }
        NSData * iamgeData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.imageUrl]];
        [netImage setImage:[UIImage imageWithData:iamgeData] forState:UIControlStateNormal];
        [self.imageScrollView addSubview:netImage];
    }
    _imageScrollView.contentSize = CGSizeMake(self.frame.size.width * (self.imageArray.count + 1), 0);
    _scrollTime = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    _imageScrollView.pagingEnabled = YES;
}

/**
 创建类型scroll
 */
-(void)createLabelType
{
    _labelScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageScrollView.frame), self.frame.size.width, 75)];
    _labelScrollView.showsHorizontalScrollIndicator = NO;
    NSArray * nameArray = @[@"衣服",@"包包",@"母婴",@"美肤",@"美鞋",@"配饰"];
    NSArray * imageArray = @[@"classify_icon_clothe",@"classify_icon_bag",@"classify_icon_mab",@"classify_icon_makeup",@"classify_icon_shose",@"classify_icon_Jewelry"];
    for(int i =0 ;i <nameArray.count;i ++)
    {
        UIButton * labelBtn = [[UIButton alloc]initWithFrame:CGRectMake(i * 70, 0, 70, 70)];
        [labelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [labelBtn setTitle:nameArray[i] forState:UIControlStateNormal];
        [labelBtn setTitleEdgeInsets:UIEdgeInsetsMake(5, -45, 5, 5)];
        labelBtn.backgroundColor = [UIColor whiteColor];
        labelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        labelBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        labelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [labelBtn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [labelBtn setImageEdgeInsets:UIEdgeInsetsMake(30, 15, 0, 15)];
        
        [_labelScrollView addSubview:labelBtn];
    }
    _labelScrollView.contentSize = CGSizeMake(70* nameArray.count, 0);
    [self addSubview:_labelScrollView];
}
/**
 点击图片的响应

 @param btn 按钮
 */
-(void)imageClick:(UIButton *)btn
{
    ImageModel * model = self.imageArray[btn.tag];
    if([model.bizId isEqual:@(0)])
    {
        if(model.linkUrl !=(NSString *)[NSNull null])
        {
            if(self.delegate &&[ self.delegate respondsToSelector:@selector(pushWithUrl:)])
            {
                [self.delegate pushWithUrl:model.linkUrl];
            }
            
        }
    }
}

/**
 自动滚动
 */
-(void)autoScroll
{
    CGFloat scrollWith = self.frame.size.width;
    if(self.imageScrollView.contentOffset.x/scrollWith ==self.imageArray.count)
    {
        [_imageScrollView setContentOffset:CGPointZero animated:NO];
    }
    [self.imageScrollView setContentOffset:CGPointMake(scrollWith +self.imageScrollView.contentOffset.x, 0) animated:YES];
    if(self.imageScrollView.contentOffset.x/scrollWith >= self.imageArray.count-1)
    {
        self.pageControl.currentPage = 0;
    }
    else
    {
        self.pageControl.currentPage = self.imageScrollView.contentOffset.x/scrollWith + 1;
    }
    
}


-(instancetype)initWithFrame:(CGRect)frame withColor:(UIColor *)color
{
    if(self == [super initWithFrame:frame])
    {
        self.backgroundColor = color;
        [self loadTypeData];
        
    }
    return self;
}

-(void)loadTypeData
{
    [WNetRequest requestWithGetTypeWithUrl:WTypeLine textDict:nil didBlock:^(NSDictionary *dict, NSError *error) {
       if(error == nil)
       {
           NSDictionary * listDict = dict[@"result"];
           NSArray * listArray = listDict[@"list"];
           NSMutableArray * dataArray = [[NSMutableArray alloc]init];
           for(NSDictionary * onlydict in listArray)
           {
               ImageModel * model = [[ImageModel alloc]init];
               model.showName = onlydict[@"showName"];
               model.showStyleID = onlydict[@"id"];
               [dataArray addObject:model];
           }
           [self.typeArray addObjectsFromArray:dataArray];
           dispatch_async(dispatch_get_main_queue(), ^{
               [self configTYpeUI];
           });
       }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [WNetRequest showMbProgressText:[NSString stringWithFormat:@"请求失败 code-%ld",(long)error.code] WithTime:1 WithView:self.superview];
            });
        }
    }];
}

/**
 精选界面
 */
-(void)configTYpeUI
{
    _typeScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    if(self.typeArray.count <=6)
    {
        NSInteger btnWidth = self.frame.size.width/self.typeArray.count;
        for(int i =0;i <self.typeArray.count;i ++)
        {
            UIButton * typeBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*btnWidth, 0, btnWidth, self.frame.size.height)];
            [typeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            typeBtn.tag = i;
            typeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [typeBtn addTarget:self action:@selector(typeClickL:) forControlEvents:UIControlEventTouchUpInside];
            ImageModel * model = self.typeArray[i];
            [typeBtn setTitle:model.showName forState:UIControlStateNormal];
            [self.typeScroll addSubview:typeBtn];
            _typeScroll.contentSize = CGSizeZero;
        }
        _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 3, btnWidth, 3)];
    }
    else
    {
        NSInteger btnWidth = self.frame.size.width/6;
        for(int i =0;i <self.typeArray.count;i ++)
        {
            UIButton * typeBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*btnWidth, 0, btnWidth, self.frame.size.height)];
            [typeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            typeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            typeBtn.tag = i;
            [typeBtn addTarget:self action:@selector(typeClickL:) forControlEvents:UIControlEventTouchUpInside];
            ImageModel * model = self.typeArray[i];
            [typeBtn setTitle:model.showName forState:UIControlStateNormal];
            [self.typeScroll addSubview:typeBtn];
            _typeScroll.contentSize = CGSizeMake(btnWidth * self.typeArray.count, 0);
        }
        _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 3, btnWidth, 3)];
    }
    _lineLabel.backgroundColor = [UIColor blackColor];
    [self addSubview:_typeScroll];
    [self addSubview:_lineLabel];
    UIButton * firstBtn = (UIButton *)[_typeScroll subviews][0];
    [self typeClickL:firstBtn];
}

/**
 点击不同类型
 */
-(void)typeClickL:(UIButton *)btn
{
   
    if(btn.tag !=4)
    {
        if(!self.lastBtn)
        {
            self.lastBtn = btn;
        }
        else
        {
            if(self.lastBtn != btn)
            {
                [self.lastBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                self.lastBtn = btn;
            }
        }
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            self.lineLabel.frame = CGRectMake(btn.frame.origin.x,self.frame.size.height - 3, btn.frame.size.width, 3);
        }];
        ImageModel * model = self.typeArray[btn.tag];
        if(self.delegate && [self.delegate respondsToSelector:@selector(typeChangeContentUrl:index:)])
        {
            [self.delegate typeChangeContentUrl:model.showStyleID index:btn.tag];
        }
    }
    else
    {
        [WNetRequest showMbProgressText:@"看看其他的..." WithTime:1 WithView:self.superview];
    }
    }
-(void)dealloc
{
    [self.scrollTime invalidate];
    self.scrollTime = nil;
}

@end
