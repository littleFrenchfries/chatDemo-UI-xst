//
//  WeChatViewController.m
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/22.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import "WeChatAddressViewController.h"

@interface WeChatAddressViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)UITableView * tableView;

@property (strong, nonatomic)NSMutableArray * dataSource;

@end

@implementation WeChatAddressViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedStringFromTable(@"Contacts", XTLocalizedString, @"通讯录");
    [self createTableView];
    // Do any additional setup after loading the view.
}

-(void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.view addSubview:self.tableView];
}

-(void)getInfo{
    dispatch_async(global_quque, ^{
        EMError *error = nil;
        NSArray *userlist = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
        if (!error) {
            NSLog(@"获取成功 -- %@",userlist);
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:userlist];
            dispatch_async(main_queue, ^{
                [self.tableView reloadData];
            });
            
        }else{
            NSLog(@"error == %@",error.errorDescription);
        }

    });
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section==1) {
        cell.imageView.image =[UIImage imageNamed:@"12"];
        NSDictionary * dict = self.dataSource[indexPath.row];
        
        cell.textLabel.text = dict[@"name"];
    }else{
        switch (indexPath.row) {
            case 0:{
                cell.imageView.image = [UIImage imageNamed:@"plugins_FriendNotify"];
                cell.textLabel.text = @"新的朋友";
                break;
            }
            case 1:{
                cell.imageView.image = [UIImage imageNamed:@"add_friend_icon_addgroup"];
                cell.textLabel.text = @"群聊";
                break;
            }
            case 2:{
                cell.imageView.image = [UIImage imageNamed:@"Contact_icon_ContactTag"];
                cell.textLabel.text = @"标签";
                break;
            }
            case 3:{
                cell.imageView.image = [UIImage imageNamed:@"add_friend_icon_offical"];
                cell.textLabel.text = @"公众号";
                break;
            }
            default:
                break;
        }
    }
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else{
       return self.dataSource.count;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
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
