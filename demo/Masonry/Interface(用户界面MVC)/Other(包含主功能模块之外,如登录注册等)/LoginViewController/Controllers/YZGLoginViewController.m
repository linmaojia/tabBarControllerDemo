//
//  ViewController.m
//  Masonry
//
//  Created by LXY on 16/7/20.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGLoginViewController.h"
#import "JKTextField.h"
#import "YZGPhoneTableView.h"

#define PHONE_LIST @"PHONE_LIST"
static float const TEXT_HEIGHT = 50;  /**< 文本框高度 */
@interface YZGLoginViewController ()
@property(nonatomic, strong) JKTextField *searchBar;   /** 文本框 左边图片  */
@property (nonatomic, strong) UIButton *deleBtn;             /**<  系统按钮 */

@property(nonatomic, strong) YZGPhoneTableView *phoneTableView;


@end

@implementation YZGLoginViewController
#pragma mark ************** 懒加载
- (UIButton *)deleBtn {
    if (!_deleBtn) {
        _deleBtn=[[UIButton alloc]init];
        [_deleBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _deleBtn.backgroundColor = [UIColor grayColor];
        _deleBtn.titleLabel.font = systemFont(14);//标题文字大小
        _deleBtn.layer.borderWidth = 0.5;
        _deleBtn.layer.borderColor = RGB(227, 229, 230).CGColor;
        _deleBtn.layer.cornerRadius = 3;
        _deleBtn.layer.masksToBounds = YES;
        [_deleBtn addTarget:self action:@selector(deleBtnClick:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _deleBtn;
}
- (JKTextField *)searchBar
{
    if(!_searchBar)
    {
        _searchBar = [[JKTextField alloc]init];
        _searchBar.backgroundColor = [UIColor grayColor];
        _searchBar.borderStyle=UITextBorderStyleRoundedRect;
        _searchBar.placeholder = @"手机号码:";
        _searchBar.font = [UIFont systemFontOfSize:14];
        //左侧图片
        UIButton *searchImage = [UIButton buttonWithType:UIButtonTypeCustom];
        searchImage.frame = CGRectMake(0, 0, 18, 18);
        [searchImage setImage:[UIImage imageNamed:@"login_id"] forState:0];
        _searchBar.leftView = searchImage;
        _searchBar.leftViewMode = UITextFieldViewModeAlways;
        //右侧图片
        UIButton *Image = [UIButton buttonWithType:UIButtonTypeCustom];
        Image.frame = CGRectMake(0, 0, 18, 18);
        [Image setImage:[UIImage imageNamed:@"Tao- login page-drop-down"] forState:0];
        [Image addTarget:self action:@selector(showClick:) forControlEvents:UIControlEventTouchDown];
        _searchBar.rightView = Image;
        _searchBar.rightViewMode = UITextFieldViewModeAlways;
        
    }
    return _searchBar;
}
- (void)viewWillAppear:(BOOL)animated
{
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
  
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];

}

#pragma mark ************** 按钮被点击
- (void)showClick:(UIButton *)sender{
    
    if([self.view.subviews containsObject:_phoneTableView])
    {
        [_phoneTableView hideDropDown];
    }
    else
    {
        NSMutableArray *phoneListArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:PHONE_LIST]];
        
        if(!phoneListArray)
        {
            phoneListArray = [NSMutableArray new];
        }
        
        _phoneTableView = [[YZGPhoneTableView alloc]initWithView:self.searchBar titleArray:phoneListArray];
        [self.view addSubview: _phoneTableView];
        [_phoneTableView showDropDow];
        ESWeakSelf;
        _phoneTableView.showBlock = ^(NSString *text){
            
            __weakSelf.searchBar.text = text;
        };
    }
    
    
 
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if([self.view.subviews containsObject:_phoneTableView])
    {
       [_phoneTableView hideDropDown];
    }
}
#pragma mark ************** 按钮被点击
- (void)deleBtnClick:(UIButton *)sender{
    
    NSLog(@"xxx")
    
    
    
    
    [self savePhoneNum];
}
#pragma mark **************** 保存电话号
- (void)savePhoneNum
{
    NSMutableArray *phoneListArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:PHONE_LIST]];
    
    if(!phoneListArray)
    {
        phoneListArray = [NSMutableArray new];
    }
    if ([phoneListArray containsObject:self.searchBar.text]) {
        [phoneListArray removeObject:self.searchBar.text];
        [phoneListArray insertObject:self.searchBar.text atIndex:0];
    } else {
        [phoneListArray insertObject:self.searchBar.text atIndex:0];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:phoneListArray forKey:PHONE_LIST];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.deleBtn];

    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.view).offset(60);
        make.height.equalTo(@(TEXT_HEIGHT));
        
    }];
    
    [_deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_searchBar.bottom).offset(20);
        make.left.right.height.equalTo(_searchBar);
       
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
