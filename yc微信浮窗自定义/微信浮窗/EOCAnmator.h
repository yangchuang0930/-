//
//  EOCAnmator.h
//  yc微信浮窗自定义
//
//  Created by 杨闯 on 2018/10/10.
//  Copyright © 2018年 杨闯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EOCAnmator : NSObject<UIViewControllerAnimatedTransitioning>
@property(nonatomic,assign)CGRect rectFrame;
@end
