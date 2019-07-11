//
//  DPostModel.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/25.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DPostModel.h"

@implementation DPostModel

/**获取高度**/
-(void)calculateHeight{
    //文字高度
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    CGSize size = [self.content boundingRectWithSize:CGSizeMake(kScreenWidth-60, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    self.cellHeight=size.height+60;

    
}

/**数据处理**/
-(void)modelDealWith:(BmobObject *)obj{
    
    self.content        = [obj objectForKey:@"content"];
    self.authorID       = [obj objectForKey:@"authorID"];
    self.nickName       = [obj objectForKey:@"nickName"];
    self.userLogo       = [obj objectForKey:@"userLogo"];
    self.isAnonymous    = [obj objectForKey:@"isAnonymous"];
    
}
@end
