//
//  BNFootView.h
//  Resh
//
//  Created by wo on 15/9/26.
//  Copyright (c) 2015年 wo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNFootView;

enum BNFootViewStatus
{
    BNFootViewStatusBeginDrag, //拖拽读取更多
    BNFootViewStatusDragging,  //松开读取更多
    BNFootViewStatusLoading,   //正在读取
    
};

typedef enum BNFootViewStatus BNFootViewStatus;

@interface BNFootView : UIView

@property (nonatomic,assign) BNFootViewStatus status;

@property (copy,nonatomic) void (^footResh) (void);

+(id)footView;

@end
