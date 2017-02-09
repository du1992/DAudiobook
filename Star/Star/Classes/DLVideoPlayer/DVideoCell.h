//
//  XLVideoCell.h
//  XLVideoPlayer
//


#import <UIKit/UIKit.h>
@class DVideoItem;

@interface DVideoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;

@property (nonatomic, strong) DVideoItem *videoItem;

+ (DVideoCell *)videoCellWithTableView:(UITableView *)tableview;

@end
