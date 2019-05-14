//
//  DMenuModel.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/22.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DMenuModel.h"

@implementation DMenuModel

+(NSMutableArray*)getMenuModeldataArry{
    NSMutableArray*dataArry=[NSMutableArray array];
    

    DMenuModel*arraymodelA      =[DMenuModel new];
    arraymodelA.title           =@"热门小说";
    arraymodelA.pictureImage    =@"热门";
    arraymodelA.menuType        =kHotNovelType;
    [dataArry addObject:arraymodelA];
    
    DMenuModel*arraymodelB      =[DMenuModel new];
    arraymodelB.title           =@"相声评书";
    arraymodelB.pictureImage    =@"相声";
    arraymodelB.menuType        =kCrosstalkType;
    [dataArry addObject:arraymodelB];
    
    DMenuModel*arraymodelC      =[DMenuModel new];
    arraymodelC.title           =@"玄幻小说";
    arraymodelC.pictureImage    =@"玄幻";
    arraymodelC.menuType        =kFantasyType;
    [dataArry addObject:arraymodelC];
    
    DMenuModel*arraymodelD      =[DMenuModel new];
    arraymodelD.title           =@"都市小说";
    arraymodelD.pictureImage    =@"都市";
    arraymodelD.menuType        =kCityType;
    [dataArry addObject:arraymodelD];
    
    DMenuModel*arraymodelE      =[DMenuModel new];
    arraymodelE.title           =@"恐怖小说";
    arraymodelE.pictureImage    =@"恐怖";
    arraymodelE.menuType        =kTerrorisType;
    [dataArry addObject:arraymodelE];
    
    DMenuModel*arraymodelF      =[DMenuModel new];
    arraymodelF.title           =@"历史小说";
    arraymodelF.pictureImage    =@"历史";
    arraymodelF.menuType        =kHistoryType;
    [dataArry addObject:arraymodelF];
    
    DMenuModel*arraymodelG      =[DMenuModel new];
    arraymodelG.title           =@"武侠小说";
    arraymodelG.pictureImage    =@"武侠";
    arraymodelG.menuType        =kMartiaType;
    [dataArry addObject:arraymodelG];
    
     return dataArry;
    
}




@end
