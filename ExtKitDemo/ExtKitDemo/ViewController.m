//
//  ViewController.m
//  ExtKitDemo
//
//  Created by YDJ on 14/11/23.
//  Copyright (c) 2014年 ydj. All rights reserved.
//

#import "ViewController.h"
#import "DataViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray * dataList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=@"ExtKit";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _dataList=@[@"NSString/NSData",@"NSObject",@"UIColor",@"UIImage",@"UILabel",@"UIView",@"Helper"];
    
    
    
    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text=self.dataList[indexPath.row];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row==0) {
        DataViewController * data=[[DataViewController alloc] init];
        [self.navigationController pushViewController:data animated:YES];
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
