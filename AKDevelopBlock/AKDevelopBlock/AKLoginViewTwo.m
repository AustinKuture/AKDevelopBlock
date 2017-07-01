//
//  AKLoginViewTwo.m
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/5/31.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AKLoginViewTwo.h"
#import "AKLoginTableView.h"
//#import "AKMainTabBarController.h"
//#import "AKSettingController.h"
#import <MessageUI/MessageUI.h>


@interface AKLoginViewTwo ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *logInWithIPButton;
@property (nonatomic, strong) UIButton *forgetPassWordButton;

@property (nonatomic,strong) UITextField *nameInput;
@property (nonatomic,strong) UITextField *passwordInput;
@property (nonatomic,strong) NSUserDefaults *userDefaults;
@property (nonatomic,strong) UIImageView *imgV;
@property (nonatomic,strong) UIButton *loginBtn;

@property (nonatomic,copy) NSString *nameS;
@property (nonatomic,copy) NSString *psswordS;

@property (nonatomic,strong) UILabel *titleL;

//版权信息
@property (nonatomic,strong) UIButton *infoCopy;
@property (nonatomic,strong) UIButton *infoPicture;

//弹窗
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIView *alertView;
@property (nonatomic,strong) UIApplication *aplica;
@property (nonatomic,strong) UIButton *backBtn;

@end
@implementation AKLoginViewTwo

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self){
        
        [self loginViewInitSetting];
        [self loginViewForLogo];
        [self loginViewForTitle];
        [self loginViewForNameInput];
        [self loginViewForPasswordInput];
        [self loginViewForLoginButton];
        [self copyRightInfoMation];
        [self ViewForlogIntWithIP];
        
    }
    return self;
}

#pragma mark ***登陆界面初始化***
- (void)loginViewInitSetting{
    
    self.backgroundColor = COLORS_HEX(0x44a5bd, 1);
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
    
    //弹窗初始化
    _aplica = [UIApplication sharedApplication];
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _backView.backgroundColor = COLORS_BLACK;
    _backView.alpha = 0;
    _backView.userInteractionEnabled = YES;
    
    _alertView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, SCREEN_HEIGHT, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.8)];
    _alertView.backgroundColor = GROUNDCOLOR(244, 247, 252, 1);
    _alertView.layer.cornerRadius = 10;
    _alertView.layer.masksToBounds = YES;
    _alertView.userInteractionEnabled = YES;
    
    [self contectMessageSetting];
    
    //添加退出手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBackAlertView)];
    [_backView addGestureRecognizer:tapGesture];
    
    //返回退出按钮
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _alertView.bounds.size.width, _alertView.bounds.size.height * 0.1)];
    _backBtn.backgroundColor = GROUNDCOLOR(59, 161, 186, 1);
    [_backBtn setImage:[UIImage imageNamed:@"downRows"] forState:UIControlStateNormal];
    [_backBtn setTitle:@" 帮助信息" forState:UIControlStateNormal];
    _backBtn.titleLabel.font = FONT_S(16);
    
    [_alertView addSubview:_backBtn];
    [_backBtn addTarget:self action:@selector(goBackAlertView) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark ***联系信息***
- (void)contectMessageSetting{
    
    //竖线
    UILabel *veriLine = [[UILabel alloc]init];
    veriLine.backgroundColor = GROUNDCOLOR(172, 192, 206, 1);
    [_alertView addSubview:veriLine];
    [veriLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(_alertView.bounds.size.height * 0.6);
        make.width.mas_equalTo(2);
        make.centerX.mas_equalTo(_alertView.mas_centerX);
        make.top.equalTo(_alertView.mas_top).offset(_alertView.bounds.size.height * 0.2 + 10);
    }];
    
    //联系人背景
    UIView *personBack = [[UIView alloc]init];
    personBack.backgroundColor = GROUNDCOLOR(240, 243, 248, 1);
    personBack.layer.cornerRadius = 5;
    personBack.layer.borderWidth = 1;
    personBack.layer.borderColor = GROUNDCOLOR(209, 219, 229, 1).CGColor;
    
    [_alertView addSubview:personBack];
    [personBack mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(_alertView.bounds.size.height * 0.15);
        make.top.equalTo(_alertView.mas_top).offset(_alertView.bounds.size.height * 0.2);
        make.left.equalTo(_alertView.mas_left).offset(10);
        make.right.equalTo(_alertView.mas_right).offset(-10);
    }];
    
    //联系人
    UILabel *person = [[UILabel alloc]init];
    person.text = @"联系人：睿思鸣，TFS";
    person.textAlignment = ALIG_CENTER;
    person.textColor = GROUNDSAME(138, 1);
    person.font = FONT_S(16);
    [personBack addSubview:person];
    [person mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(30);
        make.left.equalTo(personBack.mas_left).offset(10);
        make.right.equalTo(personBack.mas_right).offset(-10);
        make.centerY.equalTo(personBack.mas_centerY);
    }];
    
    //联系电话背景图
    UIView *telBack = [[UIView alloc]init];
    telBack.backgroundColor = GROUNDCOLOR(240, 243, 248, 1);
    telBack.layer.cornerRadius = 5;
    telBack.layer.borderWidth = 1;
    telBack.layer.borderColor = GROUNDCOLOR(201, 219, 229, 1).CGColor;
    
    [_alertView addSubview:telBack];
    [telBack mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(_alertView.bounds.size.height * 0.15);
        make.top.equalTo(_alertView.mas_top).offset(_alertView.bounds.size.height * 0.4);
        make.left.equalTo(_alertView.mas_left).offset(10);
        make.right.equalTo(_alertView.mas_right).offset(-10);
    }];
    
    //联系电话
    UIButton *telNumber = [[UIButton alloc]init];
    [telNumber setTitle:@" 电话：010-0000000" forState:UIControlStateNormal];
    [telNumber setTitleColor:GROUNDSAME(138, 1) forState:UIControlStateNormal];
    [telNumber setImage:[UIImage imageNamed:@"login_tel"] forState:UIControlStateNormal];
    telNumber.titleLabel.font = FONT_S(16);
    telNumber.titleLabel.textAlignment = ALIG_CENTER;
    telNumber.tag = 1;
    
    [telBack addSubview:telNumber];
    [telNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(_alertView.bounds.size.height * 0.15);
        make.left.equalTo(telBack.mas_left);
        make.right.equalTo(telBack.mas_right);
        make.top.equalTo(telBack.mas_top);
    }];
    
    //邮箱背景
    UIView *mailBack = [[UIView alloc]init];
    mailBack.backgroundColor = GROUNDCOLOR(240, 243, 248, 1);
    mailBack.layer.cornerRadius = 5;
    mailBack.layer.borderWidth = 1;
    mailBack.layer.borderColor = GROUNDCOLOR(201, 219, 229, 1).CGColor;
    [_alertView addSubview:mailBack];
    [mailBack mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(_alertView.bounds.size.height * 0.15);
        make.top.equalTo(_alertView.mas_top).offset(_alertView.bounds.size.height * 0.6);
        make.left.equalTo(_alertView.mas_left).offset(10);
        make.right.equalTo(_alertView.mas_right).offset(-10);
    }];
    
    //邮箱
    UIButton *mailB = [[UIButton alloc]init];
    mailB.titleLabel.textAlignment = ALIG_CENTER;
    mailB.titleLabel.font = FONT_S(16);
    mailB.titleLabel.numberOfLines = 0;
    [mailB setTitleColor:GROUNDSAME(138, 1) forState:UIControlStateNormal];
    [mailB setTitle:@" 邮箱：li.yakun@ruisiming.com.cn; \n li.yakun@ruisiming.com.cn" forState:UIControlStateNormal];
    [mailB setImage:[UIImage imageNamed:@"login_mail"] forState:UIControlStateNormal];
    mailB.tag = 2;
    
    [mailBack addSubview:mailB];
    [mailB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(_alertView.bounds.size.height * 0.15);
        make.left.equalTo(mailBack.mas_left);
        make.right.equalTo(mailBack.mas_right);
        make.top.equalTo(mailBack.mas_top);
    }];
    
    //联系地址
    UILabel *locationL = [[UILabel alloc]init];
    locationL.textColor = GROUNDSAME(138, 1);
    locationL.font = FONT_S(13);
    locationL.numberOfLines = 0;
    locationL.textAlignment = ALIG_CENTER;
    locationL.text = @"地址：北京市海淀区知春路豪景大厦B座1901室 ";
    [_alertView addSubview:locationL];
    [locationL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_offset(_alertView.bounds.size.height * 0.15);
        make.left.equalTo(_alertView.mas_left).offset(10);
        make.right.equalTo(_alertView.mas_right).offset(-10);
        make.bottom.equalTo(_alertView.mas_bottom).offset(- 10);
    }];
    
    //横线
    UILabel *locaLine = [[UILabel alloc]init];
    locaLine.backgroundColor = GROUNDCOLOR(201, 219, 229, 1);
    [_alertView addSubview:locaLine];
    [locaLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(1);
        make.left.equalTo(_alertView.mas_left);
        make.right.equalTo(_alertView.mas_right);
        make.top.equalTo(veriLine.mas_bottom);
    }];
    
    [telNumber addTarget:self action:@selector(loginHelpClickFunc:) forControlEvents:UIControlEventTouchUpInside];
    [mailB addTarget:self action:@selector(loginHelpClickFunc:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark ***帮助信息点击方法***
- (void)loginHelpClickFunc:(UIButton *)btn{
    
    if (btn.tag == 1){
        
        [self goBackAlertView];
        if ([_delegate respondsToSelector:@selector(loginDidCallTelphone)]){
            
            [_delegate loginDidCallTelphone];
        }
        
    }else{
        
        if ([MFMailComposeViewController canSendMail]){
            
            [self sendEmailWithMessageUI];
        }else{
            
            NSString *url = @"mailto:leilei@mail.cintcm.ac.cn?cc=kangli@mail.cintcm.ac.cn";
            
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url] options:[NSDictionary new] completionHandler:nil];
        }
    }
}

#pragma mark ***存在账户时弹出邮箱窗口***
- (void)sendEmailWithMessageUI{
    
    [self goBackAlertView];
    
    if ([_delegate respondsToSelector:@selector(loginDidSelectedHelpInfo)]){
        
        [_delegate loginDidSelectedHelpInfo];
    }
}

#pragma mark ***版权信息***
- (void)copyRightInfoMation{
    
    
    //版权信息
    _infoCopy = [[UIButton alloc]init];
    [_infoCopy setTitle:@"Copyright © 2017 北京睿思鸣信息技术有限公司 版权所有 " forState:UIControlStateNormal];
    _infoCopy.titleLabel.font = FONT_S(12);
    _infoCopy.titleLabel.numberOfLines = 0;
    _infoCopy.titleLabel.textAlignment = ALIG_CENTER;
    [_infoCopy setTitleColor:GROUNDSAME(238, 1) forState:UIControlStateNormal];
    [self addSubview:_infoCopy];
    [_infoCopy mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.height.mas_equalTo(30);
    }];
    
    //帮助信息
    _infoPicture = [[UIButton alloc]init];
    [_infoPicture setTitle:@" 帮助中心" forState:UIControlStateNormal];
    [_infoPicture setImage:[UIImage imageNamed:@"infoPic"] forState:UIControlStateNormal];
    _infoPicture.titleLabel.font = FONT_S(16);
    [_infoPicture setTitleColor:GROUNDSAME(238, 1) forState:UIControlStateNormal];
    
    [self addSubview:_infoPicture];
    [_infoPicture mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(150,60));
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-25);
    }];
    
    [_infoPicture addTarget:self action:@selector(contectAlertView) forControlEvents:UIControlEventTouchUpInside];
    //
    //    //英文版权
    //    UILabel *coyRi = [[UILabel alloc]init];
    //    coyRi.text = @"copyright©2017 all right reserved";
    //    coyRi.font = FONT_S(12);
    //    coyRi.textColor = COLORS_WHITE;
    //    coyRi.textAlignment = ALIG_CENTER;
    //    [self addSubview:coyRi];
    //    [coyRi mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.height.mas_equalTo(20);
    //        make.left.equalTo(self.mas_left).offset(10);
    //        make.right.equalTo(self.mas_right).offset(-10);
    //        make.centerX.equalTo(self.mas_centerX);
    //        make.bottom.equalTo(self.mas_bottom).offset(-10);
    //    }];
}

#pragma mark ***联系人弹窗***
- (void)contectAlertView{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _alertView.frame = CGRectMake(SCREEN_WIDTH * 0.1, SCREEN_HEIGHT * 0.1, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.8);
        _backView.alpha = 0.5;
    }];
    
    [_aplica.keyWindow addSubview:_backView];
    [_aplica.keyWindow addSubview:_alertView];
}

#pragma mark ***退出弹窗***
- (void)goBackAlertView{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        //旋转动画
        CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue =  [NSNumber numberWithFloat: M_PI * 0.5];
        animation.duration  = 0.5;
        animation.autoreverses = NO;
        animation.fillMode =kCAFillModeForwards;
        animation.repeatCount = 1;
        
        _alertView.frame = CGRectMake(SCREEN_WIDTH * 0.1, SCREEN_HEIGHT, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.8);
        _backView.alpha = 0;
        
        [_alertView.layer addAnimation:animation forKey:nil];
    }];
}

#pragma mark ***登陆Log***
- (void)loginViewForLogo{
    
    UIImageView *imgV = [[UIImageView alloc]init];
    imgV.image = [UIImage imageNamed:@"iconLogin_uncolor"];
    _imgV = imgV;
    [self addSubview:_imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(120, 120));
        make.top.equalTo(self.mas_top).offset(50);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

#pragma mark ***项目文字***
- (void)loginViewForTitle{
    
    UILabel *titleL = [[UILabel alloc]init];
    titleL.text = @"登陆类视图样式二";
    titleL.font = FONT_S(20);
    titleL.textColor = COLORS_WHITE;
    titleL.textAlignment = ALIG_CENTER;
    _titleL = titleL;
    [self addSubview:_titleL];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(40);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(_imgV.mas_bottom).offset(5);
    }];
}

#pragma mark ***账号输入框***
- (void)loginViewForNameInput{
    _nameInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameInput.placeholder = @" 请输入账号";
    _nameInput.backgroundColor = COLORS_HEX(0xecfafe, 1);
    _nameInput.autocorrectionType = UITextAutocorrectionTypeNo;
    _nameInput.autocapitalizationType = NO;
    _nameInput.layer.cornerRadius = 25;
    _nameInput.alpha = 0.9;
    
    [self addSubview:_nameInput];
    [_nameInput mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(50);
        make.top.equalTo(_titleL.mas_bottom).offset(30);
        make.left.equalTo(self.mas_left).offset(30);
        make.right.equalTo(self.mas_right).offset(-30);
    }];
    
    UIView *passBV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    UIImageView *passLf = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 30, 30)];
    passLf.image = [UIImage imageNamed:@"login_name"];
    [passBV addSubview:passLf];
    _nameInput.leftView = passBV;
    _nameInput.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark ***密码输入框***
- (void)loginViewForPasswordInput{
    
    
    _passwordInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordInput.backgroundColor = COLORS_HEX(0xecfafe, 1);
    _passwordInput.placeholder = @" 请输入密码";
    _passwordInput.secureTextEntry = YES;
    _passwordInput.layer.cornerRadius = 25;
    _passwordInput.alpha = 0.9;
    
    [self addSubview:_passwordInput];
    [_passwordInput mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(50);
        make.top.equalTo(_nameInput.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(30);
        make.right.equalTo(self.mas_right).offset(-30);
    }];
    
    UIView *passBV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    UIImageView *passLf = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 30, 30)];
    passLf.image = [UIImage imageNamed:@"login_secri"];
    [passBV addSubview:passLf];
    _passwordInput.leftView = passBV;
    _passwordInput.leftViewMode = UITextFieldViewModeAlways;
    
}

#pragma mark ***登陆按钮***
- (void)loginViewForLoginButton{
    
    UIButton *loginBtn = [[UIButton alloc]init];
    loginBtn.backgroundColor = COLORS_HEX(0xecfafe, 1);
    loginBtn.showsTouchWhenHighlighted = YES;
    loginBtn.userInteractionEnabled = NO;
    loginBtn.layer.cornerRadius = 25;
    
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn setTitleColor:BLUE_BABY forState:UIControlStateHighlighted];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _loginBtn = loginBtn;
    
    [self addSubview:_loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(50);
        make.top.equalTo(_passwordInput.mas_bottom).offset(25);
        make.left.equalTo(_passwordInput.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH / 2 - 40);
    }];
    
    [_loginBtn addTarget:self action:@selector(changeToMainViewController) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark ***IP登陆按钮***
- (void)ViewForlogIntWithIP {
    _logInWithIPButton = [[UIButton alloc] init];
    _logInWithIPButton.showsTouchWhenHighlighted = YES;
    _logInWithIPButton.backgroundColor = COLORS_HEX(0xecfafe, 1);
    _logInWithIPButton.layer.cornerRadius = 25;
    
    [_logInWithIPButton setTitle:@"IP登录" forState:UIControlStateNormal];
    [_logInWithIPButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_logInWithIPButton setTitleColor:BLUE_BABY forState:UIControlStateHighlighted];
    _logInWithIPButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
//    [_logInWithIPButton addTarget:self action:@selector(loginViewForNetWorkIPLoginVerify) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_logInWithIPButton];
    [_logInWithIPButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(SCREEN_WIDTH / 2 - 40);
        make.top.equalTo(_passwordInput.mas_bottom).offset(25);
        make.right.equalTo(_passwordInput.mas_right);
    }];
}


#pragma mark -- 忘记密码按钮
- (void)loginviewForForgetButton {
    
    _forgetPassWordButton = [[UIButton alloc] init];
    [_forgetPassWordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_forgetPassWordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_forgetPassWordButton setBackgroundColor:[UIColor clearColor]];
    _forgetPassWordButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_forgetPassWordButton];
    [_forgetPassWordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.top.equalTo(_logInWithIPButton.mas_bottom).offset(15);
        make.right.equalTo(self.mas_right).offset(-60);
    }];
}
#pragma mark ***切换控制器***
- (void)changeToMainViewController{
    
    _nameS = _nameInput.text;
    _psswordS = _passwordInput.text;
    [_userDefaults setValue:_nameS forKey:@"loginName"];
    [_userDefaults setValue:_psswordS forKey:@"loginPassword"];
    [_userDefaults synchronize];
//    [self loginViewForNetWorkLoginVerify];
}
//
//#pragma mark ***网络登录验证***
//- (void)loginViewForNetWorkLoginVerify{
//    
//    NSString *url = [NSString stringWithFormat:@"%@",CIN_LOGIN_ACCOUNT];
//    NSMutableDictionary *dicL = [[NSMutableDictionary alloc]init];
//    [dicL setValue:_nameS forKey:@"j_username"];
//    [dicL setValue:_psswordS forKey:@"j_password"];
//    
//#pragma mark ***账号统计***
////    [MobClick profileSignInWithPUID:_nameS];
//    
//    
//    AKNetPackegeAFN *packNet = [AKNetPackegeAFN shareHttpManager];
//    [packNet netWorkType:AKNetWorkPOST Signature:CIN_SIGNATURE API:url Parameters:dicL RequestTimes:CIN_TIMESOUT_ACCOUNT_LOGIN Success:^(id json) {
//        
//        if (json){
//            
//            //MyLog(@"JSONTO==:%@",json);
//            
//            [self loginViewJudgeErrorOrSuccessWithStatus:[NSString stringWithFormat:@"%@",[json objectForKey:@"resultCode"]] Token:[[json objectForKey:@"result"] objectForKey:@"appToken"]  Message:[json objectForKey:@"resultMessage"] UserName:_nameS];
//        }
//        
//    } Fail:^(NSError *error) {
//        
//        if (error.userInfo){
//            
//            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"网络连接异常,异常原因:" message:[error.userInfo objectForKey:@"NSLocalizedDescription"] preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *doneB = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//            [alertC addAction:doneB];
//            
//            AKLoginController *logVC = (AKLoginController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//            [logVC presentViewController:alertC animated:YES completion:nil];
//        }
//    }];
//    
//}
//
//#pragma mark ***IP网络登录验证***
//- (void)loginViewForNetWorkIPLoginVerify{
//    
//    NSString *url = [NSString stringWithFormat:@"%@cintmed/app/user/token/ipLogin.html",CIN_MAININPORT];
//    
//    AKNetPackegeAFN *packNet = [AKNetPackegeAFN shareHttpManager];
//    [packNet netWorkType:AKNetWorkPOST Signature:CIN_SIGNATURE API:url Parameters:nil RequestTimes:CIN_TIMESOUT_IP_LOGIN Success:^(id json) {
//        
//        if (json){
//            
//            [self loginViewJudgeErrorOrSuccessWithStatus:[NSString stringWithFormat:@"%@",[json objectForKey:@"resultCode"]] Token:[[json objectForKey:@"result"] objectForKey:@"appToken"]  Message:[json objectForKey:@"resultMessage"] UserName:@"austin0111Kuture1101"];
//            
//            MyLog(@"%@",json);
//        }
//        
//    } Fail:^(NSError *error) {
//        
//        if (error.userInfo){
//            
//            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"网络连接异常,异常原因:" message:[error.userInfo objectForKey:@"NSLocalizedDescription"] preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *doneB = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//            [alertC addAction:doneB];
//            
//            AKLoginController *logVC = (AKLoginController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//            [logVC presentViewController:alertC animated:YES completion:nil];
//        }
//        
//        NSLog(@"Error:%@",error);
//    }];
//}

#pragma mrak ***登陆判断及弹窗提示***
- (void)loginViewJudgeErrorOrSuccessWithStatus:(NSString *)status Token:(NSString *)token Message:(NSString *)message UserName:(NSString *)userName{
    
    MyLog(@"Status:=====%@",status);
    if ([status isEqualToString:@"1000"]){
        
        [_userDefaults setValue:token forKey:@"LoginToken"];
        [_userDefaults setValue:status forKey:@"LoginStatus"];
        [_userDefaults setValue:userName forKey:@"LoginName"];
        [_userDefaults synchronize];
        
#pragma mark ***发送登陆参数***
        NSMutableDictionary *totalDic = [[NSMutableDictionary alloc]init];
        [totalDic setValue:@"4" forKey:@"type"];
        [totalDic setValue:token forKey:@"token"];
        if (![userName isEqualToString:@"austin0111Kuture1101"]){
            
            [totalDic setValue:userName forKey:@"username"];
        }
        
        AKNetPackegeAFN *netPack = [AKNetPackegeAFN shareHttpManager];
        [netPack netWorkType:AKNetWorkPOST Signature:@"" API:@"http://cintmed.cintcm.com/cintmed/admin/userManager.html?method=addCount" Parameters:totalDic RequestTimes:10 Success:^(id json) {
            
            MyLog(@"====LoginTotal:%@",json);
        } Fail:^(NSError *error) {
            
            MyLog(@"Error:%@",error);
        }];
        
        
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"LOGINSC" object:nil];
        });
        
    }else{
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *doneB = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:doneB];
        
//        AKLoginController *logVC = (AKLoginController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//        [logVC presentViewController:alertC animated:YES completion:nil];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(_nameInput.text.length > 1 & _passwordInput.text.length > 1){
        
        //        _loginBtn.backgroundColor = COLORS_HEX(0xecfafe, 1);
        _loginBtn.userInteractionEnabled = YES;
    }else{
        
        //        _loginBtn.backgroundColor = [UIColor lightGrayColor];
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
