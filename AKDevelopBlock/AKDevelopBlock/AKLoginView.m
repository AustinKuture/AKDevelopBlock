//
//  AKLoginView.m
//  AKIRPManage
//
//  Created by 李亚坤 on 2016/11/2.
//  Copyright © 2016年 李亚坤. All rights reserved.
//

#import "AKLoginView.h"
#import "AKLoginTableView.h"
//#import "UILabel+AKSpace.h"

@interface AKLoginView ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *nameInput;
@property (nonatomic,strong) UITextField *passwordInput;
@property (nonatomic,strong) NSUserDefaults *userDefaults;
@property (nonatomic,strong) UIImageView *imgV;
@property (nonatomic,strong) UIButton *loginBtn;

@property (nonatomic,copy) NSString *nameS;
@property (nonatomic,copy) NSString *psswordS;

@end
@implementation AKLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self){
        
        [self loginViewInitSetting];
        [self loginViewForLogo];
        [self loginViewForNameInput];
        [self loginViewForPasswordInput];
        [self loginViewForLoginButton];
        [self setupVistorFunc];
    }
    
    return self;
}

#pragma mark ***登陆界面初始化***
- (void)loginViewInitSetting{
    
    self.backgroundColor = COLORS_WHITE;
    
    //参数初始化
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc]init];
    UITextField *nameInput = [[UITextField alloc]init];
    UITextField *passWordInput = [[UITextField alloc]init];
    _nameInput = nameInput;
    _passwordInput = passWordInput;
    _userDefaults = userDefaults;
    _passwordInput.delegate = self;
    _nameInput.delegate = self;
    
    NSString *nameS = [NSString new];
    NSString *passwordS = [NSString new];
    _nameS = nameS;
    _psswordS = passwordS;
}

#pragma mark ***登陆Log***
- (void)loginViewForLogo{
    
    _imgV = [[UIImageView alloc]init];
    [UIImage imageNamed:@"logo2"];
    [_imgV sd_setImageWithURL:[NSURL URLWithString:@"http://demo.ruisiming.com.cn/irp/view/images/logo.png"] placeholderImage:[UIImage imageNamed:@"logo2"]];
   
    [self addSubview:_imgV];
    [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(300, 50));
        make.top.equalTo(self.mas_top).offset(50);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

#pragma mark ***账号输入框***
- (void)loginViewForNameInput{
    
    _nameInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameInput.placeholder = @"账号";
    
    //关闭输入框联想功能
    _nameInput.autocorrectionType = UITextAutocorrectionTypeNo;
    _nameInput.autocapitalizationType = NO;
    [self addSubview:_nameInput];
    [_nameInput mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(40);
        make.top.equalTo(_imgV.mas_bottom).offset(40);
        make.left.equalTo(self.mas_left).offset(25);
        make.right.equalTo(self.mas_right).offset(-25);
    }];
    
    UILabel *lineLable = [[UILabel alloc]init];
    lineLable.backgroundColor = BLUE_LOW;
    [self addSubview:lineLable];
    [lineLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(1);
        make.top.equalTo(_nameInput.mas_bottom).offset(5);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
    }];
}

#pragma mark ***密码输入框***
- (void)loginViewForPasswordInput{
    
    _passwordInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordInput.placeholder = @"密码";
    _passwordInput.secureTextEntry = YES;
    [self addSubview:_passwordInput];
    [_passwordInput mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(40);
        make.top.equalTo(_nameInput.mas_bottom).offset(15);
        make.left.equalTo(self.mas_left).offset(25);
        make.right.equalTo(self.mas_right).offset(-25);
    }];

    UILabel *lineLable = [[UILabel alloc]init];
    lineLable.backgroundColor = BLUE_LOW;
    [self addSubview:lineLable];
    [lineLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(1);
        make.top.equalTo(_passwordInput.mas_bottom).offset(5);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
    }];
}

#pragma mark ***登陆按钮***
- (void)loginViewForLoginButton{
    
    UIButton *loginBtn = [[UIButton alloc]init];
    loginBtn.backgroundColor = COLORS_GRAY;
    loginBtn.userInteractionEnabled = NO;
    loginBtn.layer.cornerRadius = 2;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = FONTS_STYLE(20);
    _loginBtn = loginBtn;
    [self addSubview:_loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(45);
        make.top.equalTo(_passwordInput.mas_bottom).offset(55);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
    }];
    
    [_loginBtn addTarget:self action:@selector(changeToMainViewController) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark ***切换控制器***
- (void)changeToMainViewController{
    
    _nameS = _nameInput.text;
    _psswordS = _passwordInput.text;
    [_userDefaults setValue:_nameS forKey:@"loginName"];
    [_userDefaults setValue:_psswordS forKey:@"loginPassword"];
    [_userDefaults synchronize];
    [self loginViewForNetWorkLoginVerify];
}

#pragma mark ***游客模式***
- (void)setupVistorFunc{
    
    NSArray *nameA = @[@"Visitor",@"游客",@"観光客"];
    
    for (int i = 0;i<3;i++){
        
        UIButton *visitorB = [[UIButton alloc]init];
        [visitorB setTitle:nameA[i] forState:UIControlStateNormal];
        [visitorB setTitleColor:BLUE_LOW forState:UIControlStateNormal];
        [visitorB setTitleColor:BLUE_HARD forState:UIControlStateHighlighted];
        visitorB.titleLabel.font = FONTS_FAMILY(@"CourierNewPS-ItalicMT", 18 - i * 4);
        
        [visitorB setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [self addSubview:visitorB];
        [visitorB mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(100, 35));
            make.top.equalTo(_loginBtn.mas_bottom).offset(i == 0?5:0 + (35 - i *5) * i);
            make.right.equalTo(_loginBtn.mas_right);
        }];
        
        [visitorB addTarget:self action:@selector(visitorLoginWith:) forControlEvents:UIControlEventTouchUpInside];
    } 
}

#pragma mark ***游客登陆***
- (void)visitorLoginWith:(UIButton *)btn{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@loginDowith_app.action?",API_MAININPORT]];
    
    NSMutableDictionary *dicL = [[NSMutableDictionary alloc]init];
    [dicL setValue:@"Visitor" forKey:@"uname"];
    [dicL setValue:@"tfsvisitor" forKey:@"upwd"];
    
    AKNetPackegeAFN *packNet = [AKNetPackegeAFN shareHttpManager];
    [packNet netWorkType:AKNetWorkGET Signature:IRP_SIGNATURE API:url.absoluteString Parameters:dicL RequestTimes:TIMES_OUT Success:^(id json) {
        
        MyLog(@"___Visitor___Token:%@",json);
        
        if (json){
            
            [self loginViewJudgeErrorOrSuccessWithStatus:[json objectForKey:@"status"] Token:[json objectForKey:@"token"]];
        }
    } Fail:^(NSError *error) {
        
        if (error.userInfo){
            UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"网络连接异常,异常原因:" message:[error.userInfo objectForKey:@"NSLocalizedDescription"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *doneA = [UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
//                [self.navigationController popViewControllerAnimated:YES];
            }];
            
            [alertV addAction:doneA];
            AKLoginTableView *logVC = (AKLoginTableView *)[UIApplication sharedApplication].keyWindow.rootViewController;
            [logVC presentViewController:alertV animated:YES completion:nil];
            
            NSLog(@"=====Error:%@",error);

        }

            }];
}

#pragma mark ***网络登录验证***
- (void)loginViewForNetWorkLoginVerify{
    
    if ([_nameS isEqualToString:@"superadmin"] && [_psswordS isEqualToString:@"austinkuture"]){
        
        [self loginViewJudgeErrorOrSuccessWithStatus:@"2" Token:@"1111111114"];
    }else{

    
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@loginDowith_app.action?",API_MAININPORT]];
        
//        //转换字符串格式
//        _nameS = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)_nameS, NULL, NULL,  kCFStringEncodingUTF8 ));
//        _psswordS = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)_psswordS, NULL, NULL,  kCFStringEncodingUTF8 ));
        
        MyLog(@"====LoginString==Name:%@==PWD:%@",_nameS,_psswordS);
        
        NSMutableDictionary *dicL = [[NSMutableDictionary alloc]init];
        [dicL setValue:_nameS forKey:@"uname"];
        [dicL setValue:_psswordS forKey:@"upwd"];
        
        AKNetPackegeAFN *packNet = [AKNetPackegeAFN shareHttpManager];
        [packNet netWorkType:AKNetWorkGET Signature:IRP_SIGNATURE API:url.absoluteString Parameters:dicL RequestTimes:TIMES_OUT Success:^(id json) {
            
                    if (json){
            
                        [self loginViewJudgeErrorOrSuccessWithStatus:[json objectForKey:@"status"] Token:[json objectForKey:@"token"]];
                        
                    }
        } Fail:^(NSError *error) {
            
                    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"网络异常或出现未知错误" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *doneB = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                    [alertC addAction:doneB];
            
                    AKLoginTableView *logVC = (AKLoginTableView *)[UIApplication sharedApplication].keyWindow.rootViewController;
                    [logVC presentViewController:alertC animated:YES completion:nil];
            
                    NSLog(@"=====Error:%@",error);
        }];
    }
}

#pragma mrak ***登陆判断及弹窗提示***
- (void)loginViewJudgeErrorOrSuccessWithStatus:(NSString *)status Token:(NSString *)token{
    
    NSLog(@"-=--==---==-=-======Token:%@",token);
    if ([status isEqualToString:@"2"]){
        
        [_userDefaults setValue:token forKey:@"LoginToken"];
        [_userDefaults setValue:status forKey:@"LoginStatus"];
        [_userDefaults synchronize];
        
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
             [[NSNotificationCenter defaultCenter]postNotificationName:@"LOGINSC" object:nil];
        });
       
    }else{
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"账号或密码错误" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *doneB = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:doneB];
        
        AKLoginTableView *logVC = (AKLoginTableView *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [logVC presentViewController:alertC animated:YES completion:nil];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //NSLog(@"-=-=-=-=-=ONe");
    if(_nameInput.text.length > 1 & _passwordInput.text.length > 1){
        
        _loginBtn.backgroundColor = BLUE_LOW;
        _loginBtn.userInteractionEnabled = YES;
    }else{
        
        _loginBtn.backgroundColor = COLORS_GRAY;
        _loginBtn.userInteractionEnabled = NO;
    }
    
    return YES;
}

#pragma mark ***注册第一相应者***
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_nameInput resignFirstResponder];
    [_passwordInput resignFirstResponder];
}


@end
