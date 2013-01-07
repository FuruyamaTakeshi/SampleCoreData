//
//  RCDataFormat.h
//  SampleCoreData
//
//  Created by 古山 健司 on 12/12/24.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RCFormat <NSObject>

@end

@interface RCDataFormat : NSObject
@property (nonatomic, retain) id content;
- (NSData*)createFormatData;
@end
