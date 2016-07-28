//
//  CreateGroupChatViewController.m
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/27.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import "CreateGroupChatViewController.h"

@interface CreateGroupChatViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)UITableView * tableView;

@property (strong, nonatomic)NSMutableArray * listArray;

@property (strong, nonatomic)UIScrollView * scrollView;

@property (strong, nonatomic)NSMutableArray * didSelectedMan;
@end

@implementation CreateGroupChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择联系人";
    [self getFriendsList];
    [self createScrollView];
    [self createUI];
    
    // Do any additional setup after loading the view.
}
-(void)setNavigationBar{
    [super setNavigationBar];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick:)];
    
}

-(void)rightBarClick:(UIBarButtonItem *)item{
    dispatch_async(global_quque, ^{
        
        EMError *error = nil;
        EMGroupOptions *setting = [[EMGroupOptions alloc] init];
        setting.maxUsersCount = 500;
        setting.style = EMGroupStylePrivateMemberCanInvite;// 创建不同类型的群组，这里需要才传入不同的类型
        EMGroup *group = [[EMClient sharedClient].groupManager createGroupWithSubject:[NSString stringWithFormat:@"群聊(%ld)",self.didSelectedMan.count] description:@"空" invitees:self.didSelectedMan message:@"邀请您加入群组" setting:setting error:&error];
        
        dispatch_async(main_queue, ^{
            if(!error){
                DLog(@"创建成功 -- %@",group);
                [self showHint:@"创建成功!"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                DLog(@"error == %@",error.errorDescription);
                [self showHint:@"创建失败!"];
            }
        });
    });
}

-(void)getFriendsList{
    dispatch_async(global_quque, ^{
        
        EMError *error = nil;
        NSArray *userlist = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
        if (!error) {
            DLog(@"获取成功 -- %@",userlist);
            [self.listArray removeAllObjects];
            [self.listArray addObjectsFromArray:userlist];
            dispatch_async(main_queue, ^{
                [self.tableView reloadData];
            });
        }else{
            DLog(@"error == %@",error.errorDescription);
        }
    });
}


-(void)createUI{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.listArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (int i = 0; i<self.didSelectedMan.count; i++) {
        if ([self.didSelectedMan[i]isEqualToString:self.listArray[indexPath.row]]) {
            [self.didSelectedMan removeObject:self.didSelectedMan[i]];
            [self createScrollView];
            return;
        }
    }
    [self.didSelectedMan addObject:self.listArray[indexPath.row]];
    [self createScrollView];
}

-(void)createScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, CELLHEIGHT)];
    CGFloat maxWith = 0.0;
    for (NSString * str in self.didSelectedMan) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(maxWith, 0, [UILabel widthForString:str fontSize:TITLEFOND andheight:CELLHEIGHT], CELLHEIGHT)];
        label.text = str;
        label.textColor = [UIColor hex_getColor:TITLECOLOR];
        label.font = [UIFont systemFontOfSize:TITLEFOND];
        [self.scrollView addSubview:label];
        maxWith = maxWith + [UILabel widthForString:str fontSize:TITLEFOND andheight:CELLHEIGHT];
        
    }
    self.scrollView.contentSize = CGSizeMake(maxWith, CELLHEIGHT);
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.tableView.tableHeaderView = self.scrollView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)listArray{
    if (!_listArray) {
        
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
}

-(NSMutableArray *)didSelectedMan{
    if (!_didSelectedMan) {
        
        _didSelectedMan = [[NSMutableArray alloc]init];
    }
    return _didSelectedMan;
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
