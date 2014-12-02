//
//  DataViewController.m
//  ExtKitDemo
//
//  Created by YDJ on 14/11/30.
//  Copyright (c) 2014年 ydj. All rights reserved.
//

#import "DataViewController.h"
#import "ExtKit.h"
@interface DataViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"hello 你好";
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    _tableView.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSDictionary * viewDictionary=@{@"tableView":_tableView};
    NSArray *h=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|" options:0 metrics:nil views:viewDictionary];
    NSArray *v=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tableView]-0-|" options:0 metrics:nil views:viewDictionary];
    
    [self.view addConstraints:h];
    [self.view addConstraints:v];
    
    
    
    
    
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellIndentifier=@"cell";
    
    
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier];
    }
    
    
    NSString *text=self.title;
    NSString * titleString=nil;
    NSString * detailString=nil;
    
    switch (indexPath.row) {
        case 0:
        {
            titleString=@"MD5";
            detailString=[text md5DHexDigestString_Ext];
            break;
        }
        case 1:
        {
            titleString=@"SHA1";
            detailString=[text sha1String_Ext];
            break;
        }
        case 2:
        {
            titleString=@"Pinyin";
            detailString=[text pinyinString_Ext];
            
            break;
        }
        case 3:
        {
            titleString=@"URL编码";
            detailString=[text urlEncodeAllRecode:kCFStringEncodingUTF8];
            break;
        }
        case 4:
        {
            titleString=@"base64";
            detailString=[text base64Encoded_Ext];
            break;
        }
        case 5:{
            titleString=@"hex";
            detailString=[text hexEncode_Ext];
            break;
        }
        default:
            break;
    }
    
    cell.textLabel.text=titleString;
    cell.detailTextLabel.text=detailString;
    cell.detailTextLabel.textColor=[UIColor grayColor];
    
    
    
    return cell;
    
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
