//
//  WeChatHomeViewController.m
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/22.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import "WeChatHomeViewController.h"
#import "CreateGroupChatViewController.h"
#import "CustomChatEaseMessageViewController.h"
@interface WeChatHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)UITableView * tableView;

@property (strong, nonatomic)NSMutableArray * dataSource;

@end

@implementation WeChatHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = NSLocalizedStringFromTable(@"Chats", XTLocalizedString, @"微信");

    [self createUI];
   
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    list<EMGroup>
    EMError *error = nil;
    NSArray *myGroups = [[EMClient sharedClient].groupManager getMyGroupsFromServerWithError:&error];
    if (!error) {
        [self.dataSource removeAllObjects];
        DLog(@"获取成功 -- %@",myGroups);
        [self.dataSource addObjectsFromArray:myGroups];
        [self.tableView reloadData];
    }
}

-(void)createUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64) style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    
    [self.view addSubview:self.tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    EMGroup * model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.subject;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EMGroup * model = self.dataSource[indexPath.row];
    CustomChatEaseMessageViewController *chatController = [[CustomChatEaseMessageViewController alloc] initWithConversationChatter:model.groupId conversationType:EMConversationTypeGroupChat];
    chatController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatController animated:YES];
}


-(void)dealloc{
//    //移除群组回调
//    [[EMClient sharedClient].groupManager removeDelegate:self];
}

-(void)setNavigationBar{
    [super setNavigationBar];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addClick:)];
}
-(void)addClick:(UIBarButtonItem *)item{
    CreateGroupChatViewController * creGroupVC = [[CreateGroupChatViewController alloc]init];
    [self.navigationController pushViewController:creGroupVC animated:YES];
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
