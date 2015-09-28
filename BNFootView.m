//
//  BNFootView.m
//  Resh
//
//  Created by wo on 15/9/26.
//  Copyright (c) 2015年 wo. All rights reserved.
//

#import "BNFootView.h"

@interface BNFootView ()

@property(nonatomic,assign)UIScrollView * scrollView;

@property(nonatomic,weak)   UIView *footView;

@property (nonatomic,strong) UILabel *labelTitle;

@end


@implementation BNFootView


+(id)footView{
    return [[self alloc]init];
}


- (void)setScrollView:(UIScrollView *)scrollView
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    _scrollView = scrollView;
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if(self.status == BNFootViewStatusLoading) return;
    
    [self willMoveToSuperview:self.scrollView];
    
    
    if (self.scrollView.isDragging){
        
        CGFloat maxY  = 60;
        
        if (_scrollView.contentOffset.y <0)
        {
            [self setStatus:BNFootViewStatusBeginDrag];
        }
        else if(_scrollView.contentOffset.y > maxY )
        {
            if (self.status == BNFootViewStatusDragging)
            {
                [self setStatus:BNFootViewStatusLoading];
                _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:1.0 animations:^{
                        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                    }];
                    self.status = BNFootViewStatusDragging;
                    _footResh();
                });
            }
                   }
    }
    else
    {
        [self setStatus:BNFootViewStatusDragging];
    }
}

-(UIView *)footView{
    if (_footView ==nil) {
    
        UIView *footView = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:footView];
        _footView = footView;
        
        UILabel * label = [[UILabel alloc]initWithFrame:footView.bounds];
        [footView addSubview:label];
        label.text = @"正在加载更多";
        label.frame = footView.bounds;
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        _labelTitle = label;
        
        UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [footView addSubview:activity];
        activity.frame = CGRectMake(50, 20, 40, 40);
        [activity startAnimating];
    }
    
    return _footView;
}

-(void)setStatus:(BNFootViewStatus)status{
    _status = status;
    
    switch (status) {
            
        case BNFootViewStatusBeginDrag:
            self.labelTitle.text= @"拖拽读取更多";
            self.footView;
            break;
        case BNFootViewStatusDragging:
            self.labelTitle.text = @"松开读取更多";
            self.footView;
            break;
        case BNFootViewStatusLoading:
            self.footView;
            break;
            
        default:
            break;
    }
}


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    UITableView * tableView = (UITableView *)newSuperview;
    
    CGFloat selfX = 0;
    CGFloat selfY = tableView.contentSize.height;
    CGFloat selfW = tableView.frame.size.width;
    CGFloat selfH = 60;
    
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);

    self.backgroundColor = [UIColor yellowColor];
}

- (void)didMoveToSuperview
{
    self.scrollView = self.superview;
}


@end
