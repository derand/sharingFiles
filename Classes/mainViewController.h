//
//  mainViewController.h
//
//  Created by maliy on 7/15/10.
//  Copyright 2010 interMobile. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface mainViewController : UIViewController <UITextFieldDelegate,
									UITableViewDelegate, UITableViewDataSource>
{
	UITableView *tv;
	NSArray *files;
}

@end
