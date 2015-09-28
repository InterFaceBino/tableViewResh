//
//  BNHeadView.m
//  Resh
//
//  Created by wo on 15/9/26.
//  Copyright (c) 2015年 wo. All rights reserved.
//

#import "BNHeadView.h"

@interface BNHeadView ()

@property(nonatomic,assign)UIScrollView * scrollView;

@property(nonatomic,weak)UIView * headView;

@property (nonatomic,strong) UILabel *labelTitle;

@end


@implementation BNHeadView


-(void)setScrollView:(UIScrollView *)scrollView{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    _scrollView =scrollView;
    [self.scrollView addSubview:self];
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didMoveToSuperview
{
    self.scrollView = self.superview;

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    
    [self willMoveToSuperview:_scrollView];
    
    if (self.status == BNHeadViewStatusLoading) return;
    
    
    if (self.scrollView.isDragging) {
        
        [self setStatus:BNHeadViewStatusBeginDrag];
        CGFloat maxY  = -60;
        if (_scrollView.contentOffset.y >0 )
        {
            
            [self setStatus:BNHeadViewStatusBeginDrag];
        }
        else if(_scrollView.contentOffset.y < maxY )
        {
            [self setStatus:BNHeadViewStatusLoading];
            _scrollView.contentInset = UIEdgeInsetsMake(-maxY, 0, 00, 0);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:1.0 animations:^{
                    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                }];
                [self setStatus:BNHeadViewStatusBeginDrag];
                _headResh();
            });
        }
    }
    else{
        [self setStatus:BNHeadViewStatusDragging];
    }
//    NSLog(@"%f",_scrollView.contentOffset.y);
}



- (UIView *)headView
{
    if (_headView == nil && _labelTitle ==nil)
    {
        UIView * headView = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:headView];
        _headView = headView;
        
        UILabel  *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 100, 40)];
        [headView addSubview:label];
        label.text = @"正在读取";
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        _labelTitle = label;
        
        UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [headView addSubview:activity];
        activity.frame = CGRectMake(50, 20, 40, 40);
        [activity startAnimating];
    }
    
    return _headView;
}


+ (id)headView
{
    return [[self alloc] init];
}

-(void)setStatus:(BNHeadViewStatus)status{
    
    _status = status;
    
    switch (status) {
            
        case BNHeadViewStatusBeginDrag:
            self.labelTitle.text= @"拖拽读取更多";
            self.headView;
            break;
        case BNHeadViewStatusDragging:
            self.labelTitle.text = @"松开读取更多";
            break;
        case BNHeadViewStatusLoading:
            self.headView;
            break;
            
        default:
            break;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    UITableView * tableView = (UITableView *)newSuperview;

    CGFloat selfX = 0;
    CGFloat selfY = -60;
    CGFloat selfW = tableView.frame.size.width;
    CGFloat selfH = 60;
    
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    
    
    self.backgroundColor = [UIColor yellowColor];
    
}



@end
