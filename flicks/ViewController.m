//
//  ViewController.m
//  flicks
//
//  Created by William Thai on 1/23/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\willthai. All rights reserved.
//

#import "ViewController.h"
#import "MovieTableViewCell.h"
#import "MovieModel.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "DetailViewController.h"
#import "MovieCollectionViewCell.h"
#import "DetailsSegue.h"

@interface ViewController () <UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *topratedTableView;
@property (nonatomic, strong) NSArray<MovieModel *> *movies;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segViewControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.topratedTableView.dataSource = self;
    
    [self configureCollectionView];
}
- (void)configureCollectionView {
    self.edgesForExtendedLayout = UIRectEdgeNone;

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat screenWidth = CGRectGetWidth(self.view.bounds);
    CGFloat itemHeight = 150;
    CGFloat itemWidth = screenWidth / 3;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 50;
    layout.minimumInteritemSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectInset(self.view.bounds, 0, 0) collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor magentaColor];
    collectionView.hidden = YES;
    [collectionView registerClass:[MovieCollectionViewCell class] forCellWithReuseIdentifier:@"MoviePosterCollectionViewCell"];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"count: %lu", self.movies.count);
    return self.movies.count;
}

- (NSInteger)topratedTableView:(UITableView *)topratedTableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"top rated count: %lu", self.movies.count);
    return self.movies.count;
}

- (void)viewWillAppear:(BOOL)animated {
    [self fetchData];
    NSLog(@"rest id:%@", self.restorationIdentifier);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MovieTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MovieTableViewCell" forIndexPath:indexPath];
    MovieModel *model = [self.movies objectAtIndex:indexPath.row];
//    NSLog(@"title: %@", model.title);

    cell.movieLabel.text = model.title;
    cell.movieDesc.text = model.movieDesc;
    cell.posterImage.contentMode = UIViewContentModeScaleAspectFit;
    [cell.posterImage setImageWithURL:model.posterUrl];
//    [cell.textLabel setText: [NSString stringWithFormat:@"%@", model.title]];
//    [cell.textLabel setText: [NSString stringWithFormat:@"%@", model.movieDesc]];
//    NSLog(@"row number = %ld", indexPath.row);
    return cell;
}

- (void)fetchData {
    NSString *apiKey = @"a07e22bc18f5cb106bfe4cc1f83ad8ed";
    NSString *restorationId = self.restorationIdentifier;
    NSString *path = [restorationId isEqualToString:@"topratedView"] ? @"top_rated" : @"now_playing";
    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%1@?api_key=%2@", path, apiKey];
    NSLog(@"url:%@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                if (!error) {
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
//                                                    NSLog(@"Response: %@", responseDictionary);
                                                    NSArray *results = responseDictionary[@"results"];
                                                    NSMutableArray *models = [NSMutableArray array];
                                                    for (NSDictionary *result in results) {
                                                        MovieModel *model = [[MovieModel alloc] initWithDictionary:result];
                                                        [models addObject:model]; // add a object into the array
//                                                        NSLog(@"Model - %@", model);
                                                    }
                                                    self.movies = models;
                                                    [self.tableView reloadData];
                                                    [self.topratedTableView reloadData];
                                                    [self.collectionView reloadData];
                                                } else {
                                                    NSLog(@"An error occurred: %@", error.description);
                                                }
                                            }];
    
    [task resume];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITableView *tv;
    NSInteger index;

    if ([segue.identifier isEqualToString:@"movieItemClicked"]) {
        NSInteger selSegIndex = self.segViewControl.selectedSegmentIndex;
        if (selSegIndex == 1) {
            NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
            index = [[indexPaths objectAtIndex:0] row];
        } else {
            tv = self.tableView;
            index = tv.indexPathForSelectedRow.row;
        }
    } else if ([segue.identifier isEqualToString:@"topViewClicked"]) {
        NSInteger selSegIndex = self.segViewControl.selectedSegmentIndex;
        if (selSegIndex == 1) {
            NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
            index = [[indexPaths objectAtIndex:0] row];
        } else {
            tv = self.topratedTableView;
            index = tv.indexPathForSelectedRow.row;
        }
    } else if ([segue.identifier isEqualToString:@"MoviePosterClicked"]) {
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        index = [[indexPaths objectAtIndex:0] row];
//        NSIndexPath *indexPath = indexPaths[0];
//        index = indexPath.item;
    }
    
    DetailViewController *d = (DetailViewController *)segue.destinationViewController;
    MovieModel *movieModel = [self.movies objectAtIndex:index];
    NSLog(@"movie title:%@", movieModel.title);
    d.mTitle = movieModel.title;
    d.placeholderImage = movieModel.posterUrl;
    d.imageUrl = movieModel.hiresPosterUrl;
    d.mDesc = movieModel.movieDesc;
    NSLog(@"movie title:%@", movieModel.title);
}

- (IBAction)onSegValueChange:(id)sender {
    NSLog(@"seg change: %ld", self.segViewControl.selectedSegmentIndex);
    NSInteger selectedIndex = self.segViewControl.selectedSegmentIndex;
    
    if (selectedIndex == 0) {
        self.collectionView.hidden = YES;
        self.tableView.hidden = NO;
    } else {
        self.collectionView.hidden = NO;
        self.tableView.hidden = YES;
    }
    
}

#pragma mark - UICollectionViewDataSource
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *d = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewID"];
    //instantiate a new segue
//    DetailsSegue *seg = [[DetailsSegue alloc] initWithIdentifier:@"MoviePosterClicked" source:self destination:d];
//    [self prepareForSegue:seg sender:nil];
//    [seg perform];
    NSString *selectedTitle = self.navigationController.tabBarItem.title;
    
    NSString *id = [selectedTitle isEqualToString:(@"Most Viewed")] ? @"movieItemClicked" : @"topViewClicked";
    NSLog(@"seg id:%@", id);
    [self performSegueWithIdentifier:id sender: nil];
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MoviePosterCollectionViewCell" forIndexPath:indexPath];
    NSLog(@"id:::::%@", cell.reuseIdentifier);
    //    NSLog(@"title: %@", model.title);
    MovieModel *model = [self.movies objectAtIndex:indexPath.item];
    NSLog(@"collection movie title: %@", model.title);
    cell.model = model;
    [cell reloadData];
    return cell;
}

@end
