//
//  WQBaseNet.h
//  WQAppForKongKongHu
//
//  Created by 王祺祺 on 2016/10/20.
//  Copyright © 2016年 wangqiqi. All rights reserved.
//

#ifndef WQBaseNet_h
#define WQBaseNet_h

#define ViewWidth self.view.bounds.size.width
#define ViewHight self.view.bounds.size.height
#define WBaseUrl @"http://api.kongkonghu.com/"

#define WTopImageUrl [WBaseUrl stringByAppendingString:@"index/events"]//头图片get
#define WTypeLine [WBaseUrl stringByAppendingString:@"/tab/showTabs"]//类别get
#define WSpecial [WBaseUrl stringByAppendingString:@"tab/showTabContent"]//专题内容 post id=1&pageNum=1&version=2.3.0
#endif /* WQBaseNet_h */
