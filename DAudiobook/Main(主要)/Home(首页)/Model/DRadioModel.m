//
//  DRadioModel.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/23.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DRadioModel.h"

@implementation DRadioModel

-(DRadioModel*)isEqualRadioModel:(NSMutableArray*)array{
    for (DRadioModel *obj in array) {
        if (obj.albumId==self.albumId) {
            return obj;
            
        }
    }
    
    return nil;
}


-(DRadioModel*)deleteRadioModel:(NSMutableArray*)array{
    for (DRadioModel *obj in array) {
        if (obj.albumId==self.albumId) {
            return obj;
            
        }
    }
    
    return nil;
    
    
}


@end
