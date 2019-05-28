//
//  DVideoPlayerViewController.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/22.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DVideoPlayerViewController.h"
#import "DVideoCell.h"
#import "DVideoModel.h"
#import "DVideoPlayer.h"

@interface DVideoPlayerViewController ()

/** 播放器 */
@property (strong, nonatomic) DVideoPlayer  *player;

@end

@implementation DVideoPlayerViewController
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_player destroyPlayer];
    _player=nil;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"视频";
    [self addBackItem];
    [self onHeaderRefreshing];
}

#pragma mark - 共享方法
//数据处理
-(void)dataProcessingIsRemove:(BOOL)isRemove input:(id)input{
    if (isRemove) {
        [self.listArray removeAllObjects];
    }
    [self.listArray addObjectsFromArray:[DVideoModel mj_objectArrayWithKeyValuesArray:input]];
    [self.tableView  reloadData];
    
}
//获取URL
-(NSString *)getURL{
    return VideoUrl;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 200;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DVideoCell *cell = [DVideoCell cellWithTableView:tableView];
    DVideoModel *model   = self.listArray[indexPath.row];
    [cell setData:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_player destroyPlayer];
    _player=nil;
    
    DVideoCell *cell     = [tableView cellForRowAtIndexPath:indexPath];
    DVideoModel *model   = self.listArray[indexPath.row];
    [cell.contentView addSubview:self.player];
    
     [self.player playerBindTableView:self.tableView currentIndexPath:indexPath];
     self.player.videoUrl = model.mp4_url;
     self.player.frame =cell.videoImageView.bounds;

    
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.tableView]) {
        [_player playerScrollIsSupportSmallWindowPlay:YES];
    }
}

- (DVideoPlayer *)player {
    if (!_player) {
        _player = [[DVideoPlayer alloc] init];
        _player.completedPlayingBlock = ^(DVideoPlayer *player) {
            [player destroyPlayer];
            player=nil;
        };
    }
    return _player;
}


@end
