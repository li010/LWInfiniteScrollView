//
//  LWImageModel.h
//  LWInfiniteScrollView
//
//  Created by li010 on 2017/8/7.
//  Copyright © 2017年 li010. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWImageModel : NSObject

@property (nonatomic ,copy) NSString *imageName;
@property (nonatomic ,copy) NSString *pushURL;

- (instancetype)initWithImageNamge:(NSString *)imageName pushURL:(NSString *)pushURL;

@end
