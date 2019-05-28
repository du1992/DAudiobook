//
//  DJokesModel.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/15.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DJokesModel.h"

@implementation DJokesModel

/**获取高度**/
-(void)calculateHeight{
    //文字高度
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(kScreenWidth-50, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    self.cellHeight=size.height+50;
    self.R = (arc4random() % 256) ;
    self.G = (arc4random() % 256) ;
    self.B = (arc4random() % 256) ;
    
}



@end
