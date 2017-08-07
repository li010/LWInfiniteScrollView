//
//  LWInfiniteScrollViewHelper.m
//  LWInfiniteScrollView
//
//  Created by li010 on 2017/8/7.
//  Copyright © 2017年 li010. All rights reserved.
//

#import "LWInfiniteScrollViewHelper.h"
#import "LWImageView.h"
#import "LWImageModel.h"
static int const kImageViewCount = 3;

@interface LWInfiniteScrollViewHelper ()<UIScrollViewDelegate>

@property (nonatomic ,weak) UIScrollView *scrollView;
@property (nonatomic ,weak) NSTimer *timer;

@end

@implementation LWInfiniteScrollViewHelper
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        _scrollView = scrollView;
        
        for (int i = 0; i < kImageViewCount; i++) {
            LWImageView *imageView = [[LWImageView alloc] init];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [imageView addGestureRecognizer:tap];
            imageView.userInteractionEnabled = YES;
            [scrollView addSubview:imageView];
            
            
        }
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [self addSubview:pageControl];        //不能加在scrollwView上[取子视图时有问题]
        _pageControl = pageControl;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    CGFloat scrollViewW = _scrollView.frame.size.width;
    CGFloat scrollViewH = _scrollView.frame.size.height;
    if (self.isScrollDirectionPortrait) {
        self.scrollView.contentSize = CGSizeMake(0,kImageViewCount * scrollViewH);
    } else {
        self.scrollView.contentSize = CGSizeMake(kImageViewCount *scrollViewW, 0);
    }
    
    for (int i = 0; i < kImageViewCount; i++) {
        LWImageView *imageView = (LWImageView *)_scrollView.subviews[i];
        if (self.isScrollDirectionPortrait) {
            imageView.frame = CGRectMake(0, i * scrollViewH, scrollViewW, scrollViewH);
        } else {
            imageView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
        }
    }
    
    
    CGFloat pageW = 80.f;
    CGFloat pageH = 20.f;
    self.pageControl.frame = CGRectMake(scrollViewW - pageW, scrollViewH - pageH, pageW, pageH);
    [self updateContent];
}

- (void)setImageArr:(NSArray *)imageArr {
    _imageArr = imageArr;
    
    
    self.pageControl.numberOfPages = imageArr.count;
    self.pageControl.currentPage = 0;
    
    [self updateContent];
    
    [self startTimer];
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    LWImageView *imageView = (LWImageView *)tap.view;
    self.tapActionBlock(imageView.model);
}

- (void)updateContent {
    for (int i = 0; i<self.scrollView.subviews.count; i++) {
        LWImageView *imageView = self.scrollView.subviews[i];
        NSInteger index = self.pageControl.currentPage;
        if (i == 0) {
            index--;
        } else if (i == 2) {
            index++;
        }
        if (index < 0) {
            index = self.pageControl.numberOfPages - 1;
        } else if (index >= self.pageControl.numberOfPages) {
            index = 0;
        }
        imageView.tag = index;
        LWImageModel *imageM = _imageArr[index];
        imageView.model = imageM;
        imageView.image = [UIImage imageNamed:imageM.imageName];
    }
    
    // 设置偏移量在中间
    if (self.isScrollDirectionPortrait) {
        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.frame.size.height);
    } else {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }
}

- (void)startTimer {
    NSTimer *timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(changeImageViewM) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)changeImageViewM {
    if (self.isScrollDirectionPortrait) {
        [self.scrollView setContentOffset:CGPointMake(0, _scrollView.frame.size.height * 2) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * 2, 0) animated:YES];
    }
}

#pragma mark --UIScrollViewDelegate---

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    for (int i = 0; i<self.scrollView.subviews.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        CGFloat distance = 0;
        if (self.isScrollDirectionPortrait) {
            distance = ABS(imageView.frame.origin.y - scrollView.contentOffset.y);
        } else {
            distance = ABS(imageView.frame.origin.x - scrollView.contentOffset.x);
        }
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;
        }
    }
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateContent];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self updateContent];
}



@end
