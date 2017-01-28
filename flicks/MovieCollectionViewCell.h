//
//  MovieCollectionViewCell.h
//  flicks
//
//  Created by William Thai on 1/26/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\willthai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"
@interface MovieCollectionViewCell : UICollectionViewCell
@property (strong,nonatomic) MovieModel *model;

- (void)reloadData;
@end
