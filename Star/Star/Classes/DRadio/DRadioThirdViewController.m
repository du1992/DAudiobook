//
//  DRadioThirdViewController.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/8.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import "DRadioThirdViewController.h"
#import "RadioMusicView.h"
#import "Macro.h"

@interface DRadioThirdViewController ()
@property (nonatomic,strong) RadioMusicView *musicView;

@property (nonatomic,strong) DRadioSecondListModel *dataModel;
@property (nonatomic,copy) NSString *uname;
@property (nonatomic,strong) UIButton *backBtn;
@end

@implementation DRadioThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.musicView];
    __weak DRadioThirdViewController *weakSelf = self;
    [self.musicView passRadioMessage:self.dataModel andName:self.uname];
    self.musicView.playerLoading= ^(BOOL loading){
        if (loading) {
            weakSelf.title=@"数据加载中.....";
        }else {
            weakSelf.title=@"音乐正在播放";
        }
    };
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(didClickedBack:)];
    
    
    
    
}
-(void)didClickedBack:(UIBarButtonItem *)item{
    if ([self.uname isEqualToString:@""]) {
         [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
   
    
}

- (RadioMusicView *)musicView
{
    if (!_musicView) {
        _musicView = [[RadioMusicView alloc] initWithFrame:CGRectMake(0, 64,WIDTH,HEIGHT * 7)];
    }
    return _musicView;
}

- (void)passModel:(DRadioSecondListModel *)model andName:(NSString *)name
{
    self.dataModel = model;
    self.uname = name;
}


- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
