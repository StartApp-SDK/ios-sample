[StartApp][] iOS InApp SDK Example Project
======================================

*Updated to InApp SDK version 3.6.0*

This iOS application project provides an example of the [StartApp][] InApp SDK integration.

The example application contains the following ads:
* Interstitial ad which is pre-loaded in viewDidAppear for later use.  
This ad is displayed when clicking the 'Show Ad' button.  
Note that loading an ad takes a while, so it is possible that no ad will be displayed when clicking the 'Show Ad' button.
* Interstitial ad which is loaded and displayed when clicking the 'Load & Show' button.
Note that loading an ad takes a while, so there is a delay between clicking the button and the actual appearance of the ad.  
This ad is loaded upon clicking the 'Load & Show' button, and displayed when the ad was successfully loaded, from within the didLoadAd method of the STADelegateProtocol.
* Splash ad which is displayed right after the splash image
* Return ad when returning to the application after a certain period of time of it being in the background.
* Banner with an automatic positioning at the bottom of the screen.
* Banner with a fixed position and size.
* Native ad example.

When integrating the SDK with your application, please make sure to use the latest SDK version, which can be downloaded from our [developers portal](https://developers.startapp.com).  
Please also follow the integration manual which comes with the SDK.  

Don't forget to use your application id when initializing the SDK.  

For any questions or assistance, please contact us at support@startapp.com.

[StartApp]: http://www.startapp.com
