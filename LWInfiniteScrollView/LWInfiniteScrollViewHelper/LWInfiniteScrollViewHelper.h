//
//  LWInfiniteScrollViewHelper.h
//  LWInfiniteScrollView
//
//  Created by li010 on 2017/8/7.
//  Copyright © 2017年 li010. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapActionBlock)(id model);

@interface LWInfiniteScrollViewHelper : UIView

@property (nonatomic ,strong) NSArray *imageArr;
@property (nonatomic ,weak) UIPageControl *pageControl;
@property (nonatomic ,assign ,getter=isScrollDirectionPortrait) BOOL scrollDirectionPortrait;
@property (nonatomic ,copy) tapActionBlock tapActionBlock;
@end
