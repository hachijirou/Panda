//
//  PandaUrlGroup.m
//  Panda
//
//  Created by usr10049697 on 2014/07/29.
//  Copyright (c) 2014年 hachijirou. All rights reserved.
//

#import "PandaUrlGroup.h"

@implementation PandaUrlGroup

- (id)copyWithZone:(NSZone *)zone
{
    PandaUrlGroup *copiedObject = [[[self class] allocWithZone:zone] init];
    if (copiedObject) {
        copiedObject->_title = [_title copyWithZone:zone];
        copiedObject->_note = [_note copyWithZone:zone];
        copiedObject->_updateDate = [_updateDate copyWithZone:zone];
        copiedObject->_urlGroupList = [_urlGroupList copyWithZone:zone];
    }
    return copiedObject;
}
@end
