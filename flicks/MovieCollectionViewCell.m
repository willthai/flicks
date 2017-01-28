//
//  MovieCollectionViewCell.m
//  flicks
//
//  Created by William Thai on 1/26/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\willthai. All rights reserved.
//

#import "MovieCollectionViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface MovieCollectionViewCell()
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation MovieCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView = imageView;
    }
    return self;
}

- (void)reloadData {
    [self.imageView setImageWithURL:self.model.posterUrl];
    [self setNeedsLayout];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}
@end
