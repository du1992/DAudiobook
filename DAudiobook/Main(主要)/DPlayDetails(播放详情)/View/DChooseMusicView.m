//
//  DChooseMusicView.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/28.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DChooseMusicView.h"
#import "DSongModel.h"
#import "DAlbumViewCell.h"

@implementation DChooseMusicView

-(void)setLayout{
    self.backgroundColor=AppAlphaColor(0, 0, 0, 0.3);
    self.hidden=YES;
    
    
    self.bottomView.frame=CGRectMake(0,kScreenHeight,kScreenWidth,200);

    
   
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomView.mas_left).offset(0);
        make.right.mas_equalTo(self.bottomView.mas_right).offset(0);
        make.top.mas_equalTo(self.bottomView.mas_top).offset(0);
        make.height.mas_equalTo(50);
    }];
    
   
    
  
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomView.mas_left).offset(0);
        make.right.mas_equalTo(self.bottomView.mas_right).offset(0);
        make.bottom.mas_equalTo(self.bottomView.mas_bottom).offset(0);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
    }];
    
    
    
    UIButton*button=[[UIButton alloc]init];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.bottom.mas_equalTo(self.bottomView.mas_top).offset(0);
    }];
}
-(UIView*)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.userInteractionEnabled=YES;
        _bottomView.layer.cornerRadius=5;
        _bottomView.clipsToBounds = YES;
        [self addSubview:_bottomView];
    }
    return _bottomView;
}
-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
         _titleLabel.font = AppFont(18);
        _titleLabel.textColor=UIColorFromRGBValue(0x4e4d4d);
        _titleLabel.text  =@"选择音乐";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.bottomView addSubview:_titleLabel];
    }
    return _titleLabel;
}
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]init];
        _tableView.backgroundColor=[UIColor whiteColor];
        _tableView.userInteractionEnabled=YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.bottomView addSubview:_tableView];
    }
    return _tableView;
}





/**
 *  点击按钮弹出
 */
-(void)show{
    self.hidden=NO;
    
    self.listArray=[DPlayerManager defaultManager].musicArray;
    [self.tableView reloadData];
    [UIView animateWithDuration: 0.35 animations: ^{
        self.bottomView.frame=CGRectMake(0,kScreenHeight-330,kScreenWidth,330);
    } completion:^(BOOL finished) {
        
    }];
}
/**
 *  点击半透明部分或者取消按钮，弹出视图消失
 */
-(void)dismiss{
    [UIView animateWithDuration: 0.35 animations: ^{
        self.bottomView.frame=CGRectMake(0,kScreenHeight,kScreenWidth,330);
        
    } completion:^(BOOL finished) {
        self.hidden=YES;
    }];
    
}

-(void)timeTypeAction:(UIButton*)button{
    [self dismiss];
}

#pragma mark  - UITableViewDelegate-回调
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.listArray.count;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DAlbumViewCell *cell =      [DAlbumViewCell cellWithTableView:tableView];
    DSongModel *model      =    self.listArray[indexPath.row];
    [cell setData:model];
    if (indexPath.row==[DPlayerManager defaultManager].index) {
        cell.titleLabel.textColor=[UIColor blueColor];
        cell.desLabel.textColor=[UIColor blueColor];
    }else{
        cell.titleLabel.textColor=AppColor(140, 146, 156);
        cell.desLabel.textColor=AppColor(116, 120, 126);
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
  
    [[DPlayerManager defaultManager] reloadDataWithIndex:indexPath.row];
    [self.tableView reloadData];
    if (self.chooseMusicUpdateTata) {
        self.chooseMusicUpdateTata(indexPath.row);
    }
}


@end
