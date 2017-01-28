//
//  MovieModel.m
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

@implementation MovieModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        NSString *urlstring = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w90%@",dictionary[@"poster_path"]];
        NSString *hiresUrlString = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w1000%@",dictionary[@"poster_path"]];
        self.title = dictionary[@"original_title"];
        self.movieDesc = dictionary[@"overview"];
        self.posterUrl = [NSURL URLWithString:urlstring];
        self.hiresPosterUrl = [ NSURL URLWithString:hiresUrlString];
    }
    return self;
};

@end
