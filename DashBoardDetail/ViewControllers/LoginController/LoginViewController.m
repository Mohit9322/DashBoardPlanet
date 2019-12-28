//
//  LoginViewController.m
//  dashBoardDetail
//
//  Created by Planet on 2/17/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import "LoginViewController.h"
#import <AFNetworking.h>
#import "UIHelper.h"
#import "DashboardDetailViewController.h"
#import "ModelManager.h"
#import <MoEngage.h>
#import "BasicDetailVC.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    UIView *baseView;
    UIImageView *icsLogoImageView;
    UILabel *loginLabel;
    UITextField *mobileNumberTextFld;
    UITextField *passwordTextFld;
    UIButton *loginButton;
    
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[MoEngage sharedInstance] setUserUniqueID:@"mohittyagics@gmail.com"];
    [[MoEngage sharedInstance] setUserName:@"John Doe"];
    [[MoEngage sharedInstance] setUserLastName:@"Doe"];
    [[MoEngage sharedInstance] setUserFirstName:@"John"];
    [[MoEngage sharedInstance] setUserUniqueID:@"John@gmail.com"];
    [[MoEngage sharedInstance] setUserEmailID:@"John@gmail.com"];
    [[MoEngage sharedInstance] setUserMobileNo:@"9879879879"];
    [[MoEngage sharedInstance] setUserGender:MALE]; // Use UserGender enumerator for this
    [[MoEngage sharedInstance] setUserDateOfBirth:[NSDate date]];
    [[MoEngage sharedInstance] setUserLocationLatitude:72.90909 andLongitude:12.34567];
    
    [self uidesign];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            [self adjustViewForAllDeviceAndOrientation:2];
            
        }else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            [self adjustViewForAllDeviceAndOrientation:2];
        }
        
        
    }else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            [self adjustViewForAllDeviceAndOrientation:3];
        }else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            [self adjustViewForAllDeviceAndOrientation:2];
        }
        
        
    }

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationPortrait]forKey:@"orientation"];
}

- (BOOL)shouldAutorotate{
    return NO;
}
- (void) orientationChanged:(NSNotification *)note
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        NSLog(@"Landscape");
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            [self adjustViewForAllDeviceAndOrientation:2];
            
        }else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            
            [self adjustViewForAllDeviceAndOrientation:2];
        }
    }else {
        NSLog(@"Portrait");
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            [self adjustViewForAllDeviceAndOrientation:2.4];
            
            
        }else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            [self adjustViewForAllDeviceAndOrientation:2];
        }
    }
}
-(void)adjustViewForAllDeviceAndOrientation:(int)baseViewHeghtConstant{
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    baseView.frame =  CGRectMake(screenWidth *0.013, screenWidth *0.03, (screenWidth - (2*screenWidth *0.013)) , screenHeight/baseViewHeghtConstant);
    int heightofObjects = baseView.frame.size.height/8;
    
    icsLogoImageView.frame = CGRectMake((baseView.frame.size.width - (baseView.frame.size.width *0.160))/2, 0, baseView.frame.size.width *0.2, heightofObjects - 8);
    loginLabel.frame = CGRectMake(0,icsLogoImageView.frame.size.height+icsLogoImageView.frame.origin.y +10 , baseView.frame.size.width,heightofObjects );
    mobileNumberTextFld.frame = CGRectMake(3,loginLabel.frame.size.height +loginLabel.frame.origin.y + 1.25*heightofObjects , (baseView.frame.size.width -6), heightofObjects);
    passwordTextFld.frame = CGRectMake(3, mobileNumberTextFld.frame.size.height + mobileNumberTextFld.frame.origin.y + heightofObjects*0.5,(baseView.frame.size.width -6) , heightofObjects);
    loginButton.frame = CGRectMake(0, passwordTextFld.frame.origin.y + passwordTextFld.frame.size.height + heightofObjects*0.75, baseView.frame.size.width, heightofObjects);
}

-(void)uidesign
{
    
    baseView = [[UIView alloc]init];
    baseView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:baseView];
    
    
    icsLogoImageView = [[UIImageView alloc]init];
    [icsLogoImageView setImage:[UIImage imageNamed:@"icanstyLogo"]];
    [baseView addSubview:icsLogoImageView];
    
    loginLabel = [[UILabel alloc]init];
    loginLabel.text = @"Login";
    loginLabel.textColor = [UIColor whiteColor];
    loginLabel.font = [UIFont systemFontOfSize:35];
    loginLabel.textAlignment = NSTextAlignmentCenter;
    loginLabel.backgroundColor = [UIHelper colorWithHexString:@"#001D3D"];
    [baseView addSubview:loginLabel];
    
    mobileNumberTextFld = [[UITextField alloc]init];
    mobileNumberTextFld.placeholder = @" User Name";
    mobileNumberTextFld.delegate = self;
    mobileNumberTextFld.layer.borderWidth = 0.3;
    mobileNumberTextFld.layer.masksToBounds=YES;
    mobileNumberTextFld.layer.cornerRadius = 4.0;
    /************** Hard Coded User Name *****************/
    mobileNumberTextFld.text = @"9810110274";
    /************** Hard Coded User Name *****************/
    
    mobileNumberTextFld.borderStyle = UITextBorderStyleRoundedRect;
    mobileNumberTextFld.layer.borderColor = [[UIHelper colorWithHexString:@"#BD9854"] CGColor];
    mobileNumberTextFld.keyboardType = UIKeyboardTypeNumberPad;
    mobileNumberTextFld.returnKeyType = UIReturnKeyDone;
    mobileNumberTextFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    mobileNumberTextFld.font = [UIFont systemFontOfSize:20.0];
    [mobileNumberTextFld setValue:[UIHelper colorWithHexString:@"#BD9854"] forKeyPath:@"_placeholderLabel.textColor"];
    [baseView addSubview:mobileNumberTextFld];
    
    passwordTextFld = [[UITextField alloc]init];
    passwordTextFld.placeholder = @" Password";
    passwordTextFld.layer.borderWidth = 0.3;
    passwordTextFld.delegate = self;
    passwordTextFld.layer.masksToBounds=YES;
    passwordTextFld.layer.cornerRadius = 4.0;
    passwordTextFld.keyboardType = UIKeyboardTypeDefault;
    passwordTextFld.returnKeyType = UIReturnKeyDone;
    passwordTextFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextFld.secureTextEntry = YES;
    /************** Hard Coded PassWord *****************/
    passwordTextFld.text = @"planet009";
    /************** Hard Coded Password *****************/
    passwordTextFld.layer.borderColor = [[UIHelper colorWithHexString:@"#BD9854"] CGColor];
    passwordTextFld.font = [UIFont systemFontOfSize:20.0];
    [passwordTextFld setValue:[UIHelper colorWithHexString:@"#BD9854"] forKeyPath:@"_placeholderLabel.textColor"];
    [baseView addSubview:passwordTextFld];
    
    loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    loginButton.backgroundColor = [UIHelper colorWithHexString:@"#BD9854"];
    loginButton.layer.cornerRadius = 5.0;
    loginButton.font = [UIFont systemFontOfSize:30];
    [baseView addSubview:loginButton];
    
}
-(void)loginButtonPressed:(id)sender
{

    BasicDetailVC *basicDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"BasicDetailVC"];;
    [self presentViewController:basicDetail animated:YES completion:nil];
  //  [storyboard instantiateViewControllerWithIdentifier:@"viewControllerIdentifier"];
    
//    DashboardDetailViewController *dashboardController = [[DashboardDetailViewController alloc]init];
//    [self presentViewController:dashboardController animated:YES completion:nil];

    
//     /************* Login Api *******************/
////    www.icanstay.com/api/Loginapi/Login?userName=&password=
//  NSString *apiURLLive = @"http://www.icanstay.com/api/Loginapi/Login?userName=9810110274&password=pecs@2017";
////    NSString *apiURL = @"http://dev.icanstay.com/api/Loginapi/Login?userName=icanstay&password=ics@2016";
//     [UIHelper showSpinnerWithMessage:kTitlePleaseWait];
//    
//    
//    [[ModelManager modelManager] loginApiWithoutParameters:apiURLLive success:^(Status iStatus,id  _Nullable responseObject ) {
//        
//        if(iStatus == StatusSuccess){
//            
//            [UIHelper hideSpinner];
//            NSLog(@"Success");
//            NSMutableDictionary *responsedict = responseObject;
//            NSLog(@"%@", responsedict);
//            NSString *statusStr =  [responsedict valueForKey:@"status"];
//            if ([statusStr isEqualToString:@"SUCCESS"]) {
//                NSLog(@"%@", statusStr);
//                
//                NSMutableDictionary *purchaseDict = [NSMutableDictionary dictionaryWithDictionary:@{@"Mobile":@"7055833210",@"Email":@"tester@gmail.com", @"Name": @"Mohit",@"Location":@"PeeraGarhi"}];
//                
//                
//                [[MoEngage sharedInstance]trackEvent:@"Admin IOS" andPayload:purchaseDict];
//                /************* Detail Dashboard Controller *******************/
//                DashboardDetailViewController *dashboardController = [[DashboardDetailViewController alloc]init];
//                [self presentViewController:dashboardController animated:YES completion:nil];
//                /************* Detail Dashboard Controller *******************/
//                 [UIHelper hideSpinner];
//            }else{
//                NSLog(@"Not Valid User");
//                 [UIHelper hideSpinner];
//                 [UIHelper showNotificationWithType:UINotificationAlertTypeError message:@"User credentials are incorrect!" duration:2.0];
//            }
//        }
//    } failure:^(Status iStatus, NSString *errorMessage) {
//        [UIHelper hideSpinner];
//        [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
