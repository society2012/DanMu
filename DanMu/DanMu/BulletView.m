//
//  BulletView.m
//  弹幕
//
//  Created by hupeng on 2017/7/18.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

#import "BulletView.h"

#define Padding 10

@interface BulletView ()

@property(nonatomic,strong)UILabel *lbComment;


@end

@implementation BulletView



// MARK:-dddd


-(instancetype)initWithComment:(NSString *)comment{
    if(self == [super init]){
        self.backgroundColor = [UIColor redColor];
        
        NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        
        CGFloat width = [comment sizeWithAttributes:dic].width;
        
        self.bounds = CGRectMake(0, 0, width + 2*Padding, 30);
        
        self.lbComment.text = comment;
        
        self.lbComment.frame = CGRectMake(Padding, 0, width, 30);
        
    }
    return  self;
}

// MARK:-开始动画

-(void)startAnimation{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 4;
    CGFloat wholeWidth = screenW + CGRectGetWidth(self.bounds);
    
    if(self.moveStatusBlock){
        self.moveStatusBlock(Start);
    }
    
    CGFloat speed = wholeWidth/duration;
    CGFloat enterDuration = CGRectGetWidth(self.bounds)/speed;
    
    
    [self performSelector:@selector(EnterScreen) withObject:nil afterDelay:enterDuration];
    
    
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    __block CGRect frame = self.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x -= wholeWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if(self.moveStatusBlock){
            self.moveStatusBlock(End);
        }
    }];
    
    
    
}


-(void)EnterScreen{
    if(self.moveStatusBlock){
        self.moveStatusBlock(Enter);
    }
}

-(void)stopAnimaiton{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}


-(UILabel *)lbComment{
    if(!_lbComment){
        _lbComment = [[UILabel alloc] initWithFrame:CGRectZero];
        _lbComment.font = [UIFont systemFontOfSize:14];
        _lbComment.textColor = [UIColor whiteColor];
        _lbComment.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbComment];
        
    }
    return  _lbComment;
}

@end
