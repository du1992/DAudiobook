//
//  DPictureModel.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/19.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DPictureModel.h"

@implementation DPictureModel

/**获取高度**/
-(void)calculateHeight:(UIImage *)image{
    float proportion=image.size.height/image.size.width;
    if (proportion>1) {
        //长方形
        self.imageHeight=(kScreenWidth-30);
        self.imageWidth =(kScreenWidth-30)/proportion;
    }else if (proportion==1){
        //正方形
        self.imageHeight=(kScreenWidth-100);
        self.imageWidth =(kScreenWidth-100);
    }else{
        //长方形
        self.imageHeight=(kScreenWidth-30)*proportion;
        self.imageWidth =(kScreenWidth-30);
    }
    
    
    self.cellHeight=self.imageHeight+60;
   
    
}


@end
