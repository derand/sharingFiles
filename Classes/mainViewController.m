    //
//  mainViewController.m
//
//  Created by maliy on 7/15/10.
//  Copyright 2010 interMobile. All rights reserved.
//

#import "mainViewController.h"

@interface  mainViewController ()
@property (nonatomic, readonly) NSString *documentsDirectory;
@property (nonatomic, retain) NSArray *files;

- (void) getFiles;
@end



@implementation mainViewController
@synthesize files;

#pragma mark lifeCycle

- (id) init
{
	if (self = [super init])
	{
		BOOL success;
		NSError *error;
		
		NSString *writablePath = [self.documentsDirectory stringByAppendingPathComponent:@"icon.png"];

		NSFileManager *fileManager = [NSFileManager defaultManager];
		success = [fileManager fileExistsAtPath:writablePath];
		if (!success)
		{
			NSString *defaultPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"icon.png"];
			success = [fileManager copyItemAtPath:defaultPath toPath:writablePath error:&error];
			if (!success)
			{
				// file copy error
			}
		}
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}

#pragma mark -

- (NSString *) documentsDirectory
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];   
}

- (void) getFiles
{
	NSError *error;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	self.files = [fileManager contentsOfDirectoryAtPath:self.documentsDirectory error:&error];
	[tv reloadData];
}

#pragma mark tableView delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return [files count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	UITableViewCell *rv = nil;
	NSString *cellID = @"FILES_CELL_ID";
	rv = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
	if (!rv)
	{
		rv = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
	}
	rv.textLabel.text = [files objectAtIndex:indexPath.row];

	return rv;
}

- (void) deselect:(UITableView *) tableView
{
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self performSelector:@selector(deselect:) withObject:tableView afterDelay:0.5];
	
}



#pragma mark -

- (void) viewDidAppear:(BOOL) animated
{
}

- (void) viewDidDisappear:(BOOL) animated
{
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation
{
	return YES;
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
	[super loadView];
	
	self.navigationItem.title = NSLocalizedString(@"sharing files", @"");
	
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	
	UIView *contentView = [[UIView alloc] initWithFrame:screenRect];
	contentView.autoresizesSubviews = YES;
	contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	contentView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
	
	self.view = contentView;
	[contentView release];

	UITableView *_tv = [[UITableView alloc] initWithFrame:self.view.bounds
													style:UITableViewStylePlain];
	_tv.delegate = self;
	_tv.dataSource = self;
	_tv.autoresizesSubviews = YES;
	_tv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	tv = [_tv retain];
	[self.view addSubview:tv];
	[_tv release];

	UIBarButtonItem *reloadBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Reload", @"")
																  style:UIBarButtonItemStylePlain
																 target:self action:@selector(getFiles)];
	self.navigationItem.rightBarButtonItem = reloadBtn;
	[reloadBtn release];

	[self getFiles];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	[tv release];
}



@end
