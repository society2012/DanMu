//
//  BulletManage.m
//  弹幕
//
//  Created by hupeng on 2017/7/18.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

#import "BulletManage.h"

#import "BulletView.h"


@interface BulletManage()

    //数据源
@property(nonatomic,strong)NSMutableArray *datasource;

@property(nonatomic,strong)NSMutableArray *bulletComments;

@property(nonatomic,strong)NSMutableArray *bulletViews;

@property(nonatomic,assign)BOOL bStopAnimaiton;

@end

@implementation BulletManage


-(instancetype)init{
    if(self = [super init]){
        self.bStopAnimaiton = YES;
    }
    return  self;
}
-(NSMutableArray *)datasource{
    if(!_datasource){
        _datasource = [NSMutableArray arrayWithArray:@[@"弹幕1-------",
                                                       @"弹幕2---",
                                                       @"弹幕3-------&&&&&&",
                                                       @"弹幕4-------",
                                                       @"弹幕5---",
                                                       @"弹幕6-------&&&&&&",
                                                       @"弹幕7-------",
                                                       @"弹幕8---",
                                                       @"弹幕9-------&&&&&&",
                                                       @"弹幕10-------",
                                                       @"弹幕11---",
                                                       @"弹幕12-------&&&&&&"
                                                       ]];
    }
    return _datasource;
}
-(NSMutableArray *)bulletComments{
    if(!_bulletComments){
        _bulletComments = [NSMutableArray array];
    }
    return _bulletComments;
}
-(NSMutableArray *)bulletViews{
    if(!_bulletViews){
        _bulletViews = [NSMutableArray array];
    }
    return _bulletViews;
}

-(void)start{
    if(!self.bStopAnimaiton){
        return;
    }
    self.bStopAnimaiton = NO;
    [self.bulletComments removeAllObjects];
    [self.bulletComments addObjectsFromArray:self.datasource];
    [self initBulletComment];
}

-(void)initBulletComment{
    NSMutableArray *trajectorys = [NSMutableArray arrayWithObjects:@(0),@(1),@(2), nil];
    
    for (int i=0; i<3; i++) {
        
        if(self.bulletComments.count>0){
            NSInteger index = arc4random()%trajectorys.count;
            int trajectory = [[trajectorys objectAtIndex:index] intValue];
            [trajectorys removeObjectAtIndex:index];
            
            
            NSString *comment = [self.bulletComments firstObject];
            [self.bulletComments removeObjectAtIndex:0];
            
            
            [self creatBulletView:comment trajectory:trajectory];
        }
        
        
    }
    
}



-(void)creatBulletView:(NSString *)comment trajectory:(int)trajectory{
    
    
    NSLog(@"%@",comment);
    
    if(self.bStopAnimaiton){
        return;
    }
    BulletView *view = [[BulletView alloc] initWithComment:comment];
    view.trajectory = trajectory;
    [self.bulletViews addObject:view];
    __weak typeof(view) weakView = view;
    __weak typeof(self) weakself= self;
    view.moveStatusBlock = ^(MoveStatus statue){
        if(self.bStopAnimaiton){
            return;
        }
        
        switch (statue) {
            case Start:
            {
                //弹幕开始进入屏幕
            
            [weakself.bulletViews addObject:weakView];
            
               break;
            }
                
                case Enter:
            {
                //进入屏幕
            
            NSString *comment = [weakself nextComment];
            if(comment){
                [weakself creatBulletView:comment trajectory:trajectory];
            }
            
                break;
            }
                
                case End:
            {
            if([weakself.bulletViews containsObject:weakView]){
                [weakView stopAnimaiton];
                [weakself.bulletViews removeObject:weakView];
            }
            if(weakself.bulletViews.count == 0){
                self.bStopAnimaiton = YES;
                [weakself start];
            }
                break;
            }
                
            default:
                break;
        }
        
      
    };
    if(self.generateViewBlock){
        self.generateViewBlock(view);
    }
}


-(NSString *)nextComment{
    if(self.bulletComments.count == 0){
        return  nil;
    }
   NSString *comment = [self.bulletComments firstObject];
    if(comment){
        [self.bulletComments removeObjectAtIndex:0];
    }
    return comment;
}


-(void)stop{
    
    if(self.bStopAnimaiton){
        return;
    }
    self.bStopAnimaiton = YES;
    [self.bulletViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BulletView *view = obj;
        [view stopAnimaiton];
        view = nil;
        
    }];
    [self.bulletViews removeAllObjects];
}

@end
