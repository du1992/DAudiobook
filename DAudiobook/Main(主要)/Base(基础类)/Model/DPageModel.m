//
//  DPageModel.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/24.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DPageModel.h"

@implementation DPageModel


@end



@implementation DPageModel (TC)

- (NSDictionary *)pageOutput{
   return @{@"pageSize":iString(self.count),@"currentPage":iString(self.page)};
}

@end
