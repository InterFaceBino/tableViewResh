//
//  TableController.m
//  Resh
//
//  Created by wo on 15/9/26.
//  Copyright (c) 2015年 wo. All rights reserved.
//

#import "TableController.h"
#import "BNTableView.h"

@interface TableController ()



@end

@implementation TableController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    BNTableView *table = [BNTableView contentView];
    [self.view addSubview:table];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
