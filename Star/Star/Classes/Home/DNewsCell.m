//  Created by DUCHENGWEN on 2016/12/3.
//  Copyright © 2016年 beijing. All rights reserved.


#import "DNewsCell.h"
#import "UIImageView+WebCache.h"
#import "UIColor+ZN.h"
#import "Macro.h"

@interface DNewsCell ()
@property (nonatomic,strong)IBOutlet UILabel *titleLabel;
@property (nonatomic,strong)IBOutlet UILabel *datelabel;
@property (nonatomic,strong)IBOutlet UILabel *aboutStarLabel;
@property (nonatomic,strong)IBOutlet UILabel *descripLabel;
@property (nonatomic,strong)IBOutlet UIImageView *imgView;
@end
@implementation DNewsCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID=@"newsCell";
    DNewsCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    return cell;
}

-(void)setNews:(DNews *)news{
    if (_news != news) {
        _news=news;
        if (_news.imgUrl==nil) {
            self.imgView.image=[UIImage imageNamed:@"HotsPlaceHoder"];
        }else{
            NSURL *imgUrl=[NSURL URLWithString:_news.imgUrl];
//            [self.imgView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"HotsPlaceHoder"]];
            
            __unsafe_unretained typeof(self) selfVC=self;
            [self.imgView sd_setImageWithURL:imgUrl placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                UIImageView *tempImageView=[[UIImageView alloc] initWithImage:image];
                 UIColor *imgColor=[UIColor getPixelColorAtLocation:[tempImageView center] inImage:image];
                
                UIColor* sampleColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f)
                                                        blue:(255/255.0f) alpha:(255/255.0f)];
                //比较
                if (CGColorEqualToColor(imgColor.CGColor, sampleColor.CGColor)) {
                    selfVC.imgView.image=[UIImage imageNamed:@"HotsPlaceHoder"];
                }
            }];
        }
        _imgView.layer.cornerRadius=8;
        _imgView.layer.masksToBounds=YES;
        _imgView.clipsToBounds = YES;
        _imgView.layer.borderWidth =0.1;
        _imgView.layer.borderColor = RGB(81, 41, 23).CGColor;
        _imgView.contentMode = UIViewContentModeScaleToFill;
        
        self.titleLabel.text=_news.title;
        self.datelabel.text=_news.date;
        self.aboutStarLabel.text=_news.aboutStar;
        self.descripLabel.text=_news.descrip;
    }
    
}


@end
