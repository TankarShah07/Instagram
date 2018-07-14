//
//  AuthorListViewController.h
//  Instagram
//
//  Created by Tankar Shah on 14/07/18.
//  Copyright © 2018 Tankar Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthorListCell.h"
#import "ModelClass.h"
#import "ConnectionService.h"
#import "ImageLoader.h"

@interface AuthorListViewController : UIViewController<ConnectionServiceDelegates>

@property(strong, nonatomic) NSMutableArray *arrAuthorsData;
@property(weak, nonatomic) IBOutlet UITableView *tblAuthors;
@property (weak, nonatomic) IBOutlet UIImageView *imgSearch;
@property (weak, nonatomic) IBOutlet UILabel *lblSearch;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

