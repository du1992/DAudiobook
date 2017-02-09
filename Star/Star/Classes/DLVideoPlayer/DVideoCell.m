//
//  XLVideoCell.m
//  XLVideoPlayer
//


#import "DVideoCell.h"
#import "DVideoItem.h"
#import "UIImageView+WebCache.h"

@interface DVideoCell ()

@end

@implementation DVideoCell

+ (DVideoCell *)videoCellWithTableView:(UITableView *)tableview {
    static NSString *ID = @"DVideoCell";
    DVideoCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DVideoCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setVideoItem:(DVideoItem *)videoItem {
    _videoItem = videoItem;
    self.videoTitle.text = videoItem.title;
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:videoItem.cover]];
}


@end
