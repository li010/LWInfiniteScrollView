//
//  LWImageModel.m
//  LWInfiniteScrollView
//
//  Created by li010 on 2017/8/7.
//  Copyright © 2017年 li010. All rights reserved.
//

#import "LWImageModel.h"

@implementation LWImageModel

- (instancetype)initWithImageNamge:(NSString *)imageName pushURL:(NSString *)pushURL {
    self = [super init];
    if (self) {
        self.imageName = imageName;
        self.pushURL = pushURL;
    }
    return self;
}

@end
