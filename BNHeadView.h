//
//  BNHeadView.h
//  Resh
//
//  Created by wo on 15/9/26.
//  Copyright (c) 2015年 wo. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BNHeadView;

enum BNHeadViewStatus
{
    BNHeadViewStatusBeginDrag, //拖拽想要刷新
    BNHeadViewStatusDragging,  //松开准备刷新
    BNHeadViewStatusLoading,   //正在刷新数据
    
};

typedef enum BNHeadViewStatus BNHeadViewStatus;

@interface BNHeadView : UIView


@property(nonatomic,assign) BNHeadViewStatus status;

@property (copy,nonatomic) void (^headResh) (void);

+ (id)headView;

@end
