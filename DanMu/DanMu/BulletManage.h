//
//  BulletManage.h
//  弹幕
//
//  Created by hupeng on 2017/7/18.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BulletView;

@interface BulletManage : NSObject


@property(nonatomic,copy)void(^generateViewBlock)(BulletView *view);

-(void)start;
-(void)stop;

@end
