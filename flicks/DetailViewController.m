//
//  DetailViewController.m
//  flicks
//
//  Created by William Thai on 1/25/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\willthai. All rights reserved.
//

#import "DetailViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface DetailViewController ()
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.movieTitle.text = self.mTitle;
    [self.movieImage setImageWithURL:self.placeholderImage];
    [self.movieImage setImageWithURLRequest:[NSURLRequest requestWithURL:self.imageUrl]
                placeholderImage:nil
                success:^(NSURLRequest *request , NSHTTPURLResponse *response , UIImage *image ){
                    NSLog(@"Loaded successfully: %d", [response statusCode]);
                    self.movieImage.image = image;
                }
                failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                    NSLog(@"failed loading: %@", error);
                }];
     self.movieDesc.text = self.mDesc;
    
    [self setupCards];
}

- (void) setupCards {
    CGFloat xMargin = 24;
    CGFloat cardHeight = 290; // arbitrary value
    CGFloat bottomPadding = 64;
    CGFloat cardOffset = cardHeight * 0.75;
    self.descScrollView.frame = CGRectMake(xMargin, // x
                                           CGRectGetHeight(self.view.bounds) - cardHeight - bottomPadding, // y
                                           CGRectGetWidth(self.view.bounds) - 2 * xMargin, // width
                                           cardHeight); // height
    
    self.cardView.frame = CGRectMake(0, cardOffset, CGRectGetWidth(self.descScrollView.bounds), cardHeight);
    
    // content height is the height of the card plus the offset we want
    CGFloat contentHeight =  cardHeight + cardOffset;
    self.descScrollView.contentSize = CGSizeMake(self.descScrollView.bounds.size.width, contentHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
