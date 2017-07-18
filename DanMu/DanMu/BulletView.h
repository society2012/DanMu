//
//  BulletView.h
//  弹幕
//
//  Created by hupeng on 2017/7/18.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MoveStatus){

    Start,
    Enter,
    End
};


@interface BulletView : UIView

@property(nonatomic,assign)int trajectory;

@property(nonatomic,copy) void (^moveStatusBlock)(MoveStatus status);


-(instancetype)initWithComment:(NSString *)comment;

-(void)startAnimation;

-(void)stopAnimaiton;

@end
