[![GitHub platform](https://img.shields.io/badge/platform-ios-lightgrey.svg)]() 
[![GitHub language](https://img.shields.io/badge/language-objective--c-6BAEE4.svg)]()
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/tezpark/AlternateIconName-objC/master/LICENSE)

# TezAlertView
Custom singleton alertView with block completion.

* Simple custom alertView.
* Using completion block and singleton.
* Next commit is auto dismiss alert.

![ios simulator screen shot 2015 5 31 9 27 40](https://cloud.githubusercontent.com/assets/389004/7901926/2855f8be-07dc-11e5-9123-20f1d1034987.png)
![ios simulator screen shot 2015 5 31 9 28 16](https://cloud.githubusercontent.com/assets/389004/7901927/2856dd60-07dc-11e5-944a-a39ee470715d.png)

#Usage
```objective-c
[[TezAlertView sharedInstance] showAlertViewWithTitle:@"This is Title!"
                                   dismissButtonTitle:@"Ok"
                                         dismissBlock:^{
                                             NSLog(@"Dismiss Block!");
                                         }];
                                         
[[TezAlertView sharedInstance] showAlertViewWithMessage:@"I am a message"
                                     dismissButtonTitle:@"Ok"
                                           dismissBlock:^{
                                             NSLog(@"Dismiss Block!");
                                         }];

[[TezAlertView sharedInstance] showAlertViewWithTitle:nil
                                              message:@"I am a message"
                                   dismissButtonTitle:@"Ok"
                                         dismissBlock:^{
                                             NSLog(@"Dismiss Block!");
                                         }];

[[TezAlertView sharedInstance] showAlertViewWithTitle:@"This is Title!"
                                              message:@"I am a message"
                                   dismissButtonTitle:@"Ok"
                                    cancelButtonTitle:@"Close"
                                         dismissBlock:^{
                                             NSLog(@"Dismiss Block!");
                                         } cancelBlock:^{
                                             NSLog(@"Cancel Block!");
                                         }];

[[TezAlertView sharedInstance] showAlertViewWithTitle:@"This is Title!"
                                   dismissButtonTitle:@"Ok"
                                    cancelButtonTitle:@"Close"
                                         dismissBlock:^{
                                             NSLog(@"Dismiss Block!");
                                         } cancelBlock:^{
                                             NSLog(@"Cancel Block!");
                                         }];

[[TezAlertView sharedInstance] showAlertViewWithMessage:@"I am a message"
                                   dismissButtonTitle:@"Ok"
                                    cancelButtonTitle:@"Close"
                                         dismissBlock:^{
                                             NSLog(@"Dismiss Block!");
                                         } cancelBlock:^{
                                             NSLog(@"Cancel Block!");
                                         }];
```


#License
The MIT License (MIT)

Copyright (c) 2015 Taesun Park

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
