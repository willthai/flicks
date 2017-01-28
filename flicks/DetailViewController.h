//
//  DetailViewController.h
//  flicks
//
//  Created by William Thai on 1/25/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\willthai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UITextView *movieDesc;
@property (weak, nonatomic) IBOutlet UIScrollView *descScrollView;
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property NSString *mTitle;
@property NSURL *imageUrl;
@property NSURL *placeholderImage;
@property NSString *mDesc;
@end
