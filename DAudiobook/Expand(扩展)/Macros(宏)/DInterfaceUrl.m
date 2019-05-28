//
//  DInterfaceUrl.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/23.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DInterfaceUrl.h"
#import "LEEAlert.h"
#import "FCUUID.h"
#import <BmobSDK/Bmob.h>

@interface DInterfaceUrl ()
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIImageView *userLogoImgView;
@property (nonatomic, strong) UILabel     *userNameLabel;
@property (nonatomic, strong) NSString    *userLogo;
@end

@implementation DInterfaceUrl
#pragma mark - 获取单例
+ (instancetype)sharedInstance {
    static DInterfaceUrl* instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [[DInterfaceUrl alloc] init];
    });
    return instance;
}
//用户信息
+(void)userPopupWindow{
    UIColor *blueColor          =  AppAlphaColor(90, 154, 239,1);
    NSString*userLogo           =  [DInterfaceUrl getUserLogoString];
    NSString*userName           =  [DInterfaceUrl getNameString];
    
    UIImageView*userLogoImgView =  [[UIImageView alloc]init];
    userLogoImgView.layer.cornerRadius=5;
    userLogoImgView.clipsToBounds = YES;
    [DInterfaceUrl sharedInstance].userLogoImgView=userLogoImgView;
    
    UILabel*userNameLabel       =  [[UILabel alloc]init];
    userNameLabel.textColor     =  [UIColor whiteColor];
    userNameLabel.textAlignment = NSTextAlignmentCenter;
    [DInterfaceUrl sharedInstance].userNameLabel=userNameLabel;
    [DInterfaceUrl sharedInstance].userLogo     =userLogo;
    
   [LEEAlert alert].config
    .LeeAddTitle(^(UILabel *label) {
        label.text = @"随机用户";
        label.textColor = [UIColor whiteColor];
    })
    .LeeAddContent(^(UILabel *label) {
        label.text = @"随机获取自己的头像和昵称，以便于讨论交流";
        label.textColor = [UIColor whiteColor];
    })
    
    .LeeAddCustomView(^(LEECustomView *custom) {
        
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 150)];
        
        userLogoImgView.frame=CGRectMake(kScreenWidth/2-40, 10, 80, 80);
        [userLogoImgView sd_setImageWithURL:[NSURL URLWithString:[DInterfaceUrl getImgString:userLogo]] placeholderImage:[UIImage imageNamed:@"小熊明星资讯"]];
        
        userNameLabel.frame=CGRectMake(kScreenWidth/2-40, 110, 80, 20);
        userNameLabel.text=userName;
        
        [view addSubview:userLogoImgView];
        [view addSubview:userNameLabel];
        
        custom.view = view;
        custom.positionType = LEECustomViewPositionTypeCenter;
        
    })
    //       .LeeItemInsets(UIEdgeInsetsMake(40, 0, 0, 0))
    
    .LeeAddAction(^(LEEAction *action) {
        
        action.type = LEEActionTypeDefault;
        action.isClickNotClose=YES;
        action.title = @"重选";
        action.titleColor = blueColor;
        action.backgroundColor = [UIColor whiteColor];
        action.clickBlock = ^{
            NSString*userLogo           =  [DInterfaceUrl getUserLogoString];
            NSString*userName           =  [DInterfaceUrl getNameString];
            
            [[DInterfaceUrl sharedInstance].userLogoImgView sd_setImageWithURL:[NSURL URLWithString:[DInterfaceUrl getImgString:userLogo]] placeholderImage:[UIImage imageNamed:@"小熊明星资讯"]];
            [DInterfaceUrl sharedInstance].userNameLabel.text=userName;
            [DInterfaceUrl sharedInstance].userLogo          =userLogo;
        };
    })
    .LeeAddAction(^(LEEAction *action) {
        
        action.type = LEEActionTypeDefault;
        
        action.title = @"确定";
        
        action.titleColor = blueColor;
        
        action.backgroundColor = [UIColor whiteColor];
        
        action.clickBlock = ^{
            [DInterfaceUrl registeredUser];
            
        };
    })
    
    .LeeHeaderColor(blueColor)
    .LeeShow();
}
#pragma mark - 用户注册
+(void)registeredUser{
    BmobUser *bUser = [[BmobUser alloc] init];
    NSString *strName = [FCUUID uuid];
    NSString *nickName = [DInterfaceUrl sharedInstance].userNameLabel.text;
    NSString *userLogo = [DInterfaceUrl sharedInstance].userLogo ;
    
    
    [bUser setUsername:strName];
    [bUser setPassword:@"00000000"];
    [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        if (isSuccessful){
            [bUser setObject:nickName forKey:@"nickName"];
            [bUser setObject:userLogo forKey:@"userLogo"];
            [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {}];
            
        } else {
            NSLog(@"%@",error);
        }
    }];
    
}
//获取随机名字
+(NSString*)getNameString{
    
    NSArray*nameArray=
    @[@"齐御风",@"无崖子",@"程灵素",@"袁紫衣",
      
      @"苏星河",@"丁春秋",@"任盈盈",@"岳灵珊",
      
      @"阮星竹",@"鸠摩智",@"仪琳",@"曲非烟",
      
      @"邓百川",@"公冶乾",@"苗若兰",@"小龙女",
      
      @"包不同",@"风波恶",@"陆无双",@"李莫愁",
      
      @"吴长风",@"白世镜",@"王语嫣",@"木婉清",
      
      @"马大元",@"全冠清",@"刀白凤",@"秦红棉",
      
      @"王重阳",@"周伯通",@"甘宝宝",@"阿朱",
      
      @"丘处机",@"孙不二",@"阿紫",@"李秋水",
      
      @"黄药师",@"欧阳锋",@"黄蓉",@"穆念慈",
      ];
    
    
    int textInt = arc4random() % 39;
    return  nameArray[textInt];
    
}

//获取随机头像
+(NSString*)getUserLogoString{
    
    NSArray*imgArray=
    @[@"2018/03/13/3363a4ad4af427f0",
      @"2018/03/13/222490c377a35860",
      
      @"2018/03/11/bcf4295f7cad7252",
      @"2018/03/11/b9d60eadd4d0aba1",
      
      @"2018/03/13/f01516c27dd92dfe",
      @"2018/03/13/fbb7cad30d8a027f",
      
      @"2018/03/11/dfefacf94b8d7b2c",
      @"2018/03/11/75bbde7c8cac2d2e",
      
      
      @"2018/03/13/37e8da908b6e1a00",
      @"2018/03/13/4bc4471d12eb49c5",
      
      @"2018/03/11/bcf4295f7cad7252",
      @"2018/03/11/a0a5def8fc4d4377",
      
      @"2018/03/13/60c54ef5d58e358c",
      @"2018/03/13/1a86eb1325a1db6c",
      
      @"2018/03/11/4f3687b67cd91877",
      @"2018/03/11/6c0ee5aacf392745",
      
      
      @"2018/03/10/cda1898852d63320",
      @"2018/03/10/e5c4d29fe60da63e",
      
      @"2018/03/11/b0f923cb4b436bab",
      @"2018/03/11/219ef1aa7681ceb2",
      
      @"2018/03/08/cfc26fb2c53a53ee",
      @"2018/03/08/2dd93cb689c90023",
      
      @"2018/03/11/025f7a0c8544d989",
      @"2018/03/11/9601f07169b40818",
      
      @"2018/03/11/067c671436279aba",
      @"2018/03/08/8ad82a98e49a6649",
      
      @"2018/03/11/067c671436279aba",
      @"2018/03/11/cb7f1ede2995fe12",
      
      @"2018/03/08/62af01905686c8e6",
      @"2018/03/08/1cfe0644ace95555",
      
      @"2018/03/11/d974cb17d0a82c4f",
      @"2018/03/11/c4369b1489e0e431",
      
      @"2018/03/08/709279000ba3dc34",
      @"2018/03/08/f2418948c2fc630c",
      ];
    
    
    int textInt = arc4random() % 33;
    NSString*imgId=imgArray[textInt];
    
    return  imgId;
}

+(NSString*)getImgString:(NSString*)imgId{
    return  [NSString stringWithFormat:@"http://img2.woyaogexing.com/%@!400x400_big.jpg",imgId];
}

@end
