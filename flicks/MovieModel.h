//
//  MovieModel.h
//  flicks
//
//  Created by William Thai on 1/23/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\willthai. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface MovieModel : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *movieDesc;
@property (nonatomic, strong) NSURL *posterUrl;
@property (nonatomic, strong) NSURL *hiresPosterUrl;
@end
