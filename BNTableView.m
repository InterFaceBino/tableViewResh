//
//  BNTableView.m
//  Resh
//
//  Created by wo on 15/9/26.
//  Copyright (c) 2015年 wo. All rights reserved.
//

#import "BNTableView.h"
#import "BNHeadView.h"
#import "BNFootView.h"

@interface BNTableView () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) BNHeadView * headView;

@property(nonatomic,weak) BNFootView *footView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation BNTableView




+(id)contentView{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}


- (void)awakeFromNib
{
    
     _dataArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    
    
    
    BNHeadView *headView = [BNHeadView headView];
    
    [self.tableView addSubview:headView];
    
    _headView = headView;
    
    headView.headResh = ^(void){
        [_dataArray addObject:@"新加的"];
        [self.tableView reloadData];
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    };

    BNFootView *footView = [BNFootView footView];
    [self.tableView addSubview:footView];
    _footView = footView;
    footView.footResh = ^(void){
        [_dataArray addObject:@"新加的"];
        [self.tableView reloadData];
        [self.tableView  scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    };
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    
    cell.textLabel.text =_dataArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


@end
