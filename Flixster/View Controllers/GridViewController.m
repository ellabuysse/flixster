//
//  GridViewController.m
//  Flixster
//
//  Created by ellabuysse on 6/16/22.
//

#import "GridViewController.h"
#import "GridMovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

@interface GridViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *moviesCollectionView;
@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@end

@implementation GridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.moviesCollectionView.dataSource = self;
    self.moviesCollectionView.delegate = self;
    
    [self fetchMovies];
    NSLog(@":EB: Grid");
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];

    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.flowLayout.minimumLineSpacing = 10;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
}

- (void)fetchMovies {
    // Do any additional setup after loading the view.
    UIAlertController *networkAlert = [UIAlertController alertControllerWithTitle:@"Cannot Get Movies" message:@"The internet connection appears to be offline." preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self fetchMovies];
            }];
        // Add the tryAgainAction action to the alertController
        [networkAlert addAction:tryAgainAction];

    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=bf0f8a45cc2852450f8126c99ae834f0"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               self.movies = dataDictionary[@"results"];
               [self.moviesCollectionView reloadData];
           }

       }];
    [task resume];
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    GridMovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieGridCell" forIndexPath:indexPath];

    NSDictionary *movie = self.movies[indexPath.row];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *fullPosterUrl = [baseURLString stringByAppendingString:movie[@"poster_path"]];
    NSURL *posterUrl = [NSURL URLWithString:fullPosterUrl];
    [cell.imageView setImageWithURL:posterUrl];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    int totalwidth = self.moviesCollectionView.bounds.size.width;
    int numberOfCellsPerRow = 3;
    int widthDimensions = (CGFloat)(totalwidth / numberOfCellsPerRow);
    int heightDimensions = widthDimensions * 1.5;
    return CGSizeMake(widthDimensions, heightDimensions);
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UICollectionViewCell *cell = sender;
    NSIndexPath *myIndexPath = [self.moviesCollectionView indexPathForCell:cell];

    NSDictionary *data = self.movies[myIndexPath.row];
    DetailsViewController *detailVC = [segue destinationViewController];
    detailVC.movie = data;
    
    NSLog(@":EB: prepared for segue");
}

@end
