//
//  PandaUrl.m
//  Panda
//
//  Created by usr10049697 on 2014/07/29.
//  Copyright (c) 2014年 hachijirou. All rights reserved.
//

#import "PandaUrl.h"

@implementation PandaUrl

- (id)copyWithZone:(NSZone *)zone
{
    PandaUrl *copiedObject = [[[self class] allocWithZone:zone] init];
    if (copiedObject) {
        copiedObject->_contentsTitle = [_contentsTitle copyWithZone:zone];
        copiedObject->_contentsUrl = [_contentsUrl copyWithZone:zone];
        copiedObject->_isEditing = NO;
    }
    return copiedObject;
}
@end
