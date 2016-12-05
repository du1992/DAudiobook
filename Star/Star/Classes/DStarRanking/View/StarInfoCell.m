//
//  StarInfoCell.m
//  Star
//
//  Created by JUNE_EN on 15/6/2.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "StarInfoCell.h"
#import "UIImageView+WebCache.h"
@implementation StarInfoCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID=@"starInfoCell";
    StarInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (nil ==cell) {
      cell=[[StarInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(void)setStarInfo:(StarInfo *)starInfo{
    if (_starInfo !=starInfo) {
        _starInfo=starInfo;
        if (_starInfo.imgUrl !=nil) {
            NSURL *url=[NSURL URLWithString:_starInfo.imgUrl];
            [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }else{
            self.imageView.image=nil;
        }
        if (_starInfo.detail !=nil) {
            self.detailTextLabel.text=_starInfo.detail;
            self.detailTextLabel.numberOfLines=0;
            self.detailTextLabel.font=[UIFont systemFontOfSize:12];
        }else{
            self.detailTextLabel.text=nil;
        }
        self.textLabel.font=[UIFont systemFontOfSize:14];
        self.textLabel.text=_starInfo.title;
    }
    
}
@end
