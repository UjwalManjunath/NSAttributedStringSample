//
//  AttriburedStringViewController.m
//  NSAttributedStringSample
//
//  Created by Ujwal Manjunath on 2/7/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "AttriburedStringViewController.h"

@interface AttriburedStringViewController ()
@property (weak, nonatomic) IBOutlet UIStepper *wordStepper;
@property (weak, nonatomic) IBOutlet UILabel *selectedWordlabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation AttriburedStringViewController

-(void)addLabelAttribures:(NSDictionary *)attributes range:(NSRange)range
{
    if(range.location != NSNotFound)
    {
        NSMutableAttributedString *mutableAttributedString = [self.contentLabel.attributedText mutableCopy];
        [mutableAttributedString addAttributes:attributes range:range];
        self.contentLabel.attributedText = mutableAttributedString;
    }

}
-(void) addSelectedLabelAttribute:(NSDictionary *)attributes
{
    
    NSRange range = [[self.contentLabel.attributedText string]rangeOfString:[self selectedWord]];
     [self addLabelAttribures:attributes range:range];
}
- (IBAction)updateColor:(UIButton *)sender
{
    [self addSelectedLabelAttribute:@{NSForegroundColorAttributeName:[sender backgroundColor]}];
}

- (IBAction)underline
{
    [self addSelectedLabelAttribute:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}];
    
}
- (IBAction)updateFont:(UIButton *)sender
{
    CGFloat fontSize = [UIFont systemFontSize];
    NSDictionary *attribute = [self.contentLabel.attributedText attributesAtIndex:0 effectiveRange:NULL];
    UIFont *existingFont = attribute[NSFontAttributeName] ;
        if(existingFont) fontSize = existingFont.pointSize;
    UIFont *font = [sender.titleLabel.font fontWithSize:fontSize ];
                            
                            
                            [self addSelectedLabelAttribute:@{ NSFontAttributeName  :font}];
    
    
}

- (IBAction)noUnderline
{
    [self addSelectedLabelAttribute:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)}];
}


-(NSArray *)wordList
{
    NSArray *wordList = [[self.contentLabel.attributedText string]componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([wordList count])
        return wordList;
    else
        return @[@""];
}
- (IBAction)updateSelectedWord
{
     self.wordStepper.maximumValue = [[self wordList]count]-1;
    self.selectedWordlabel.text = [self selectedWord];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self updateSelectedWord];
}


-(NSString *)selectedWord
{
    return [[self wordList] objectAtIndexedSubscript:(int)self.wordStepper.value];
}


@end
