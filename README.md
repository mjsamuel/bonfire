# Bonfire: Cloudflare™ Server Monitor
Helps prevent DDoS attacks from bad hosts and IPs. 
Acts as a free alternative to help reduce server load and cost for origin servers and serverless environments. 
<p align="center">
  <a href="https://bonfire.jwrc.me" rel="noopener">
 <img src="Bonfire/Assets.xcassets/main_logo.imageset/bonfire_main_logo.png" alt="Project logo"></a>
</p>
<h3 align="center">Bonfire for iOS</h3>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)](https://github.com/rmit-S2-2020-iPhone/a1-s3718036_s3656070_s3663139_s3717393)
[![GitHub Issues](https://img.shields.io/github/issues/jameswrc/CloudFlare_DDoS_Mitigation.svg)](https://github.com/rmit-S2-2020-iPhone/a1-s3718036_s3656070_s3663139_s3717393/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/JamesWRC/CloudFlare_DDoS_Mitigation.svg)](https://github.com/rmit-S2-2020-iPhone/a1-s3718036_s3656070_s3663139_s3717393/pulls)

</div>

<br/>

## 📝 Table of Contents

- 🎁 [Features](#features)
- 🛠 [Prerequisites](#prerequisites)
- 🎛 [Configuration](#configuration)
- 📲 [Install](#install)
- 📋 [Acknowledgments](#acknowledgments)

<br/>

## Introduction <a name = "introduction"></a>
This utilizes the ability to create a Cloudflare™ Firewall rule and monitor activity. 
This works on any account tier, especially free. Features will be developed slowly, this is mainly here to benefit hobby sites. We will added more user friendly interfaces and easier to use tools. 

<a href="https://bonfire.jwrc.me">🔗 View the app site</a>

<br/>

**iOS App Created By:**
- 🙎🏼‍♂️Dylan Sbogar (s3718036)
- 🙎🏼‍♂️James Cockshott (s3656070)
- 🙎🏼‍♂️Kurt Invernon (s366319)
- 🙎🏼‍♂️Matthew Samuel (s3717393)

<br/>

## 🎁 Features <a name = "features"></a>
We have designed this tool to help reduce the impact and costs involved when someone tries to knock your services offline or make you rack up huge serverless costs.
Hopefully some people find this usefully when designing their own sites and applications, so that this can help protect their applications from attacks. We have tried to design this to be light weight and easy to use. 

#### 📊 Analytics
This app allows you to easily view your sites analytics.
You can view how many views per month you have go, how many threats Cloudflare™ has blocked, data cache analytics and even geographical analytics of the top countries who have visited your site

#### 💰 Cost monitor
You can also view costs associated from Cloudflare™! If you are on a higher tier then free or you pay for Cloudflare™ workers, then you can see exactly how much you will be charged! This is a perfect feature for those who are financially savvy.

#### 📖 DNS Records
You can view, add, manage your CNAME Records on the go! Bonfire provides you with the ability to manage and add CNAME records to your site in app.

#### 🛡 DDoS Mitigation
This project helps mitigate flood based attacks from different addresses, that aim to use up server compute time and rack up server costs. Cloudflare™ does a great job of protecting sites, however there is often a little bit of a lag between an incoming attack and Cloudflare™ stopping it. This is due to the unpredictable nature of attacks, so Cloudflare™ does not want to block legit requests and ruining the experience of users. 

This tool enables you to fine tune and help block possible attacks a little more aggressively, to reduce the impact of an attack, and give you more manual control over the amount of requests your site should accept before actions are taken to help mitigate an attack.


#### 🚫 Rate Limiter
Not only can this project help mitigate DDoS/Flood attacks, it can also act as a manual rate limiter for you site and resources. This can be very useful when your applications cost you money per request, or an API request is computationally expensive. Especially if you are utilizing Cloudflare™ workers where you are being billed each request, each KV action, each gigabyte of storage...

<br/>

## 🛠 Prerequisites <a name = "prerequisites"></a>
- You must have your site or web resource proxied by Cloudflare™.

<br/>

##  🎛 Configuration <a name = "configuration"></a>
### Cloudflare™
You will need to add some firewall settings on your zone.

1. Create a new firewall rule in your zone.
2. Give the rule any name. For example you can name it 'Activity Logging'
3. Click 'Edit expression' and paste the code bellow into the text field. (This simply just logs any and all requests to your site.)
```(http.request.method eq "GET") or (http.request.method eq "POST") or (http.request.method eq "PURGE") or (http.request.method eq "PUT") or (http.request.method eq "HEAD") or (http.request.method eq "OPTIONS") or (http.request.method eq "DELETE") or (http.request.method eq "PATCH")```
3. Finally chose the action, set this to 'Allow'.
4. Click 'Deploy'
5. Done!

What the above does simply enables Cloudflare™ to log all activity to your site / web resources. This app then queries these logs and provides analytics to you!


### ⚙️ Setup
To use this app, you will need to login with providing the following in login / initial setup:
- Cloudflare™ API key
- Cloudflare™ email account
- If you are testing or marking this app, please check example_creds.txt for the example credentials to log in and use the app.
- **Tip:** When viewing requests in app, if you visit <a href="https://bonfire.jwrc.me">🔗 the app site</a> you can view your own IP Address, and test taking actions against your IP address!


### 📲 Install <a name = "install"></a>
- You will need to first download and compile the xCode project code into a useable app, which you will have to self sign. 
- If you are testing or marking this app, please check ```example_creds.txt``` for the example credentials to log in and use the app. 
- **Note:** Apple only allows self signed certified apps to run for 7 days, then you will need to re-sign the app.
- **Note:** Credentials provided will be rolled and become **invalid** after the assignment has been marked. 


<br/>

## 📋 Acknowledgments <a name = "acknowledgments"></a>

* [Cloudflare™ documentation](https://api.Cloudflare.com/)
* [Cloudflare™ GraphQL API for firewall events](https://developers.cloudflare.com/analytics/graphql-api/tutorials/querying-firewall-events)

<br/>

## 💡 Powered by <a name = "powered_by"></a>

* [xCode v10.3](https://apps.apple.com/au/app/xcode/id497799835) - The IDE used
* [Swift v4](https://swift.org/download/) - Language used
* [Cloudflare™](https://www.Cloudflare.com) - Main web proxy service.
