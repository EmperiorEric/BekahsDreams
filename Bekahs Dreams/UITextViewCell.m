//
//  UITextViewCell.m
//  Bekahs Dreams
//
//  Created by Ryan Poolos on 2/27/13.
//  Copyright (c) 2013 Frozen Fire Studios. All rights reserved.
//

#import "UITextViewCell.h"

@interface UITextViewCell () <UITextViewDelegate>

@end

@implementation UITextViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textView = [[UITextView alloc] initWithFrame:CGRectInset(self.contentView.bounds, 8.0, 8.0)];
        [self.textView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [self.textView setFont:[UIFont boldSystemFontOfSize:18.0]];
        [self.textView setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.textView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - TextView Delegate

- (void)textViewDidChange:(UITextView *)textView
{
    UITableView *tableView = (UITableView *)self.superview;
    
    [textView setFrame:(CGRect){tableView.frame.origin,tableView.contentSize}];
    
    [tableView beginUpdates];
    [tableView endUpdates];
    
    [self.contentView setFrame:CGRectMake(0.0, 0.0, self.contentView.bounds.size.width, textView.contentSize.height)];
    
//    textView.contentSize
//    CGRect frame = self.frame;
//    frame.size.height = [textView.text sizeWithFont:textView.font constrainedToSize:CGSizeMake(textView.frame.size.width, CGFLOAT_MAX)].height;
//    self.frame = frame;
    
}

@end
