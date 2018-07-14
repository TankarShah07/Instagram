//
//  AuthorListViewController.m
//  Instagram
//
//  Created by Tankar Shah on 14/07/18.
//  Copyright © 2018 Tankar Shah. All rights reserved.
//

#import "AuthorListViewController.h"

@interface AuthorListViewController ()

@end

@implementation AuthorListViewController

#pragma mark - Void Methods

-(void)initialSetup{
    ConnectionService *service = [[ConnectionService alloc] init];
    service.delegate = self;
    [service getAuthorsDataService];
    [self.spinner setHidden:NO];
}

#pragma mark - UITableview Delegate & Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrAuthorsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AuthorListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AuthorListCell"];
    
    
    ModelClass *cModel = [self.arrAuthorsData objectAtIndex:indexPath.row];
    cell.imgBanner.image = [UIImage imageNamed:@"placeholder"];
    cell.lblAuthor.text = [NSString stringWithFormat:@"Author : %@",cModel.author];
    cell.lblUrl.text = [NSString stringWithFormat:@"URL : %@",cModel.post_url];
    
    if ([ImageLoader checkForImageAlreadyDownloaded:cModel.filename]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imgBanner.image = [ImageLoader getDownloadedImage:cModel.filename];
        });
    } else {
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://picsum.photos/%@/%@?image=%@",cModel.width,cModel.height,cModel.id]];
        
        cell.imgBanner.image = [UIImage imageNamed:@"placeholder"];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [self downloadImageWithURL:url andImageName:cModel.filename andIndexPath:indexPath completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imgBanner.image = image;
                });
            }
        }];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ModelClass *cModel = [self.arrAuthorsData objectAtIndex:indexPath.row];
    
    CGFloat imgHt = [cModel.height floatValue];
    CGFloat imgW = [cModel.width floatValue];
    
    CGFloat totalWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat totalHeight = (totalWidth * imgHt) / imgW;
    
    return totalHeight;
}

#pragma mark - NetworkLayer Delegate

-(void)completeFetchData:(NSArray *)arrAuthorsData
{
    self.arrAuthorsData = [[NSMutableArray alloc] initWithArray:arrAuthorsData];
    if ([self.arrAuthorsData count]) {
        [self.imgSearch setHidden:YES];
        [self.lblSearch setHidden:YES];
        [self.tblAuthors reloadData];
    }else {
        [self.imgSearch setHidden:NO];
        [self.lblSearch setHidden:NO];
    }
    [self.spinner setHidden:YES];
}

- (void)downloadImageWithURL:(NSURL *)url andImageName:(NSString*)imgName andIndexPath:(NSIndexPath *)indexPath completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock{
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * data, NSURLResponse * response, NSError * error)
                              {
                                  if (!error && data) {
                                      UIImage *image = [UIImage imageWithData:data];
                                      NSData *tempData = UIImageJPEGRepresentation(image, 0.3);
                                      [ImageLoader saveDownloadedImageForReuse:tempData withName:imgName];
                                      
                                      if (image) {
                                          dispatch_async(dispatch_get_main_queue(),
                                                         ^{
                                                             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                                             AuthorListCell *cell = (id)[self.tblAuthors cellForRowAtIndexPath:indexPath];
                                                             if (cell)
                                                                 cell.imgBanner.image = image;
                                                         });
                                      }
                                  } else {
                                  }
                              }];
    [task resume];
}

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetup];
}

#pragma mark - Memory Management Methods

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
