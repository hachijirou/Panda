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

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        _contentsTitle = [decoder decodeObjectForKey:@"contentsTitle"];
        _contentsUrl = [decoder decodeObjectForKey:@"contentsUrl"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_contentsTitle forKey:@"contentsTitle"];
    [encoder encodeObject:_contentsUrl forKey:@"contentsUrl"];
}

- (void)dealloc
{
    _contentsTitle = nil;
    _contentsUrl = nil;
}

@end
