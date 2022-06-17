//
//  MovieViewController.m
//  Flixster
//
//  Created by ellabuysse on 6/16/22.
//

#import "MovieViewController.h"
#import "MovieCellTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface MovieViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *myArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.activityIndicator startAnimating];
    
    self.tableView.rowHeight = 200;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self fetchMovies];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)fetchMovies {
    
    UIAlertController *networkAlert = [UIAlertController
                                       alertControllerWithTitle:@"Cannot Get Movies" message:@"The internet connection appears to be offline." preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self fetchMovies];
    }];
    // add the tryAgainAction action to the alertController
    [networkAlert addAction:tryAgainAction];

    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=bf0f8a45cc2852450f8126c99ae834f0"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               [self presentViewController:networkAlert animated:YES completion:^{
                   // optional code for what happens after the alert controller has finished presenting
               }];
               
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               NSLog(@"%@", dataDictionary);
               
               self.myArray = dataDictionary[@"results"];
               

               for(NSDictionary *movie in self.myArray) {
                   NSLog(@"%@", movie[@"title"]);
               }
               
               [self.tableView reloadData];
           }
        [self.refreshControl endRefreshing];
        [self.activityIndicator stopAnimating];
        
    }];
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCellTableViewCell" forIndexPath:indexPath];
    MovieCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movie = self.myArray[indexPath.row];
    
    cell.MovieTitle.text = movie[@"title"];
    cell.MovieSynopsis.text = movie[@"overview"];
    
    NSString *posterUrl = @"/6JjfSchsU6daXk2AKX8EEBjO3Fm.jpg";

    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *fullPosterUrl = [baseURLString stringByAppendingString:posterUrl];
        
    NSURL *posterURLString = [NSURL URLWithString:fullPosterUrl];
    
    [cell.ImageView setImageWithURL:posterURLString];

    return  cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return self.myArray.count;
    return 10;
}

@end
