//
//  MockData.swift
//  BonfireUITests
//
//  Created by Matthew Samuel on 10/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import Foundation

struct MockData {
    public let zoneData: Data = """
        {
          "success": true,
          "errors": [],
          "messages": [],
          "result": [
            {
              "id": "023e105f4ecef8ad9ca31a8372d0c353",
              "name": "example.com",
              "development_mode": 7200,
              "original_name_servers": [
                "ns1.originaldnshost.com",
                "ns2.originaldnshost.com"
              ],
              "original_registrar": "GoDaddy",
              "original_dnshost": "NameCheap",
              "created_on": "2014-01-01T05:20:00.12345Z",
              "modified_on": "2014-01-01T05:20:00.12345Z",
              "activated_on": "2014-01-02T00:01:00.12345Z",
              "owner": {
                "id": {},
                "email": {},
                "type": "user"
              },
              "account": {
                "id": "01a7362d577a6c3019a474fd6f485823",
                "name": "Demo Account"
              },
              "permissions": [
                "#zone:read",
                "#zone:edit"
              ],
              "plan": {
                "id": "e592fd9519420ba7405e1307bff33214",
                "name": "Pro Plan",
                "price": 20,
                "currency": "USD",
                "frequency": "monthly",
                "legacy_id": "pro",
                "is_subscribed": true,
                "can_subscribe": true
              },
              "plan_pending": {
                "id": "e592fd9519420ba7405e1307bff33214",
                "name": "Pro Plan",
                "price": 20,
                "currency": "USD",
                "frequency": "monthly",
                "legacy_id": "pro",
                "is_subscribed": true,
                "can_subscribe": true
              },
              "status": "active",
              "paused": false,
              "type": "full",
              "name_servers": [
                "tony.ns.cloudflare.com",
                "woz.ns.cloudflare.com"
              ]
            }
          ]
        }
    """.data(using: .utf8)!
    
    public let analyticsData: Data = """
        {
            "success": true,
            "errors": [],
            "messages": [],
            "result": {
                "totals": {
                    "since": "2015-01-01T12:23:00Z",
                    "until": "2015-01-02T12:23:00Z",
                    "requests": {
                        "all": 2000,
                        "cached": 750,
                        "uncached": 1250,
                        "content_type": {
                            "css": 15343,
                            "html": 1234213,
                            "javascript": 318236,
                            "gif": 23178,
                            "jpeg": 1982048
                        },
                        "country": {
                            "US": 4181364,
                            "AU": 37298,
                            "GB": 293846
                        },
                        "ssl": {
                            "encrypted": 12978361,
                            "unencrypted": 781263
                        },
                        "ssl_protocols": {
                            "TLSv1": 398232,
                            "TLSv1.1": 12532236,
                            "TLSv1.2": 2447136,
                            "TLSv1.3": 10483332,
                            "none": 781263
                        },
                        "http_status": {
                            "200": 13496983,
                            "301": 283,
                            "400": 187936,
                            "402": 1828,
                            "404": 1293
                        }
                    },
                    "bandwidth": {
                        "all": 213867451,
                        "cached": 113205063,
                        "uncached": 113205063,
                        "content_type": {
                            "css": 237421,
                            "html": 1231290,
                            "javascript": 123245,
                            "gif": 1234242,
                            "jpeg": 784278
                        },
                        "country": {
                            "US": 123145433,
                            "AG": 2342483,
                            "GI": 984753
                        },
                        "ssl": {
                            "encrypted": 37592942,
                            "unencrypted": 237654192
                        },
                        "ssl_protocols": {
                            "TLSv1": 398232,
                            "TLSv1.1": 12532236,
                            "TLSv1.2": 2447136,
                            "TLSv1.3": 10483332,
                            "none": 781263
                        }
                    },
                    "threats": {
                        "all": 23423873,
                        "country": {
                            "US": 123,
                            "CN": 523423,
                            "AU": 91
                        },
                        "type": {
                            "user.ban.ip": 123,
                            "hot.ban.unknown": 5324,
                            "macro.chl.captchaErr": 1341,
                            "macro.chl.jschlErr": 5323
                        }
                    },
                    "pageviews": {
                        "all": 5724723,
                        "search_engine": {
                            "googlebot": 35272,
                            "pingdom": 13435,
                            "bingbot": 5372,
                            "baidubot": 1345
                        }
                    },
                    "uniques": {
                        "all": 12343
                    }
                },
                "timeseries": [
                {
                "since": "2015-01-01T12:23:00Z",
                "until": "2015-01-02T12:23:00Z",
                "requests": {
                "all": 1234085328,
                "cached": 1234085328,
                "uncached": 13876154,
                "content_type": {
                "css": 15343,
                "html": 1234213,
                "javascript": 318236,
                "gif": 23178,
                "jpeg": 1982048
                },
                "country": {
                "US": 4181364,
                "AG": 37298,
                "GI": 293846
                },
                "ssl": {
                "encrypted": 12978361,
                "unencrypted": 781263
                },
                "ssl_protocols": {
                "TLSv1": 398232,
                "TLSv1.1": 12532236,
                "TLSv1.2": 2447136,
                "TLSv1.3": 10483332,
                "none": 781263
                },
                "http_status": {
                "200": 13496983,
                "301": 283,
                "400": 187936,
                "402": 1828,
                "404": 1293
                }
                },
                "bandwidth": {
                "all": 213867451,
                "cached": 113205063,
                "uncached": 113205063,
                "content_type": {
                "css": 237421,
                "html": 1231290,
                "javascript": 123245,
                "gif": 1234242,
                "jpeg": 784278
                },
                "country": {
                "US": 123145433,
                "AG": 2342483,
                "GI": 984753
                },
                "ssl": {
                "encrypted": 37592942,
                "unencrypted": 237654192
                },
                "ssl_protocols": {
                "TLSv1": 398232,
                "TLSv1.1": 12532236,
                "TLSv1.2": 2447136,
                "TLSv1.3": 10483332,
                "none": 781263
                }
                },
                "threats": {
                "all": 23423873,
                "country": {
                "US": 123,
                "CN": 523423,
                "AU": 91
                },
                "type": {
                "user.ban.ip": 123,
                "hot.ban.unknown": 5324,
                "macro.chl.captchaErr": 1341,
                "macro.chl.jschlErr": 5323
                }
                },
                "pageviews": {
                "all": 5724723,
                "search_engine": {
                "googlebot": 35272,
                "pingdom": 13435,
                "bingbot": 5372,
                "baidubot": 1345
                }
                },
                "uniques": {
                "all": 12343
                }
                }
                ]
            },
            "query": {
                "since": "2015-01-01T12:23:00Z",
                "until": "2015-01-02T12:23:00Z",
                "time_delta": 60
            }
        }
    """.data(using: .utf8)!
    
    public let requestsData: Data = """
        {
          "data": {
            "viewer": {
              "zones": [
                {
                  "firewallEventsAdaptive": [
                    {
                      "action": "get",
                      "clientAsn": "5089",
                      "clientCountryName": "AU",
                      "clientIP": "220.253.122.100",
                      "clientRequestPath": "/%3Cscript%3Ealert()%3C/script%3E",
                      "clientRequestQuery": "",
                      "datetime": "2020-08-26T06:34:20+0000",
                      "source": "waf",
                      "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36"
                    },
                    {
                      "action": "log",
                      "clientAsn": "5089",
                      "clientCountryName": "GB",
                      "clientIP": "203.0.113.69",
                      "clientRequestPath": "/%3Cscript%3Ealert()%3C/script%3E",
                      "clientRequestQuery": "",
                      "datetime": "2020-04-24T10:11:03Z",
                      "source": "waf",
                      "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36"
                    },
                    {
                      "action": "post",
                      "clientAsn": "5089",
                      "clientCountryName": "US",
                      "clientIP": "203.0.113.233",
                      "clientRequestPath": "/%3Cscript%3Ealert()%3C/script%3E",
                      "clientRequestQuery": "",
                      "datetime": "2020-04-24T09:12:49Z",
                      "source": "waf",
                      "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36"
                    },
                    {
                      "action": "get",
                      "clientAsn": "5089",
                      "clientCountryName": "US",
                      "clientIP": "203.0.113.233",
                      "clientRequestPath": "/%3Cscript%3Ealert()%3C/script%3E",
                      "clientRequestQuery": "",
                      "datetime": "2020-04-24T09:11:24Z",
                      "source": "waf",
                      "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36"
                    },
                    {
                      "action": "allow",
                      "clientASNDescription": "ASN-TELSTRA Telstra Corporation Ltd",
                      "clientAsn": "1221",
                      "clientCountryName": "AU",
                      "clientIP": "2001:8003:d4c0:5f00:62a4:4cff:fe5c:b8e0",
                      "clientRequestHTTPHost": "jwrc.me",
                      "clientRequestHTTPMethodName": "GET",
                      "clientRequestHTTPProtocol": "HTTP/2",
                      "clientRequestPath": "/updatepackages",
                      "clientRequestQuery": "?token=26760d07c7b06da3ac7d27946b4853e0665c50e0a8b705269b2cfd48f061de2b",
                      "datetime": "2020-08-28T06:00:01Z",
                      "rayName": "5c9bcf425b05fe80",
                      "ruleId": "47520303b099459194235bdf4ebcd3a2",
                      "source": "firewallrules",
                      "userAgent": "curl/7.58.0",
                      "matchIndex": 0,
                      "metadata": [
                        {
                          "key": "filter",
                          "value": "9ad6a60213524589bb74aed55d908dd0"
                        },
                        {
                          "key": "type",
                          "value": "customer"
                        }
                      ],
                      "sampleInterval": 1
                    }
                  ]
                }
              ]
            }
          },
          "errors": null
        }
    """.data(using: .utf8)!
    
    let dnsData: Data = """
        {
            "success": true,
            "errors": [],
            "messages": [],
            "result": [
                {
                    "id": "372e67954025e0ba6aaa6d586b9e0b59",
                    "type": "A",
                    "name": "example.com",
                    "content": "198.51.100.4",
                    "proxiable": true,
                    "proxied": false,
                    "ttl": 120,
                    "locked": false,
                    "zone_id": "023e105f4ecef8ad9ca31a8372d0c353",
                    "zone_name": "example.com",
                    "created_on": "2014-01-01T05:20:00.12345Z",
                    "modified_on": "2014-01-01T05:20:00.12345Z",
                    "data": {},
                    "meta": {
                        "auto_added": true,
                        "source": "primary"
                    }
                },
                {
                    "id": "372e67954025e0ba6aaa6d586b9e0b59",
                    "type": "CNAME",
                    "name": "google.com",
                    "content": "216.58.200.110",
                    "proxiable": true,
                    "proxied": false,
                    "ttl": 120,
                    "locked": false,
                    "zone_id": "023e105f4ecef8ad9ca31a8372d0c353",
                    "zone_name": "example.com",
                    "created_on": "2014-01-01T05:20:00.12345Z",
                    "modified_on": "2014-01-01T05:20:00.12345Z",
                    "data": {},
                    "meta": {
                        "auto_added": true,
                        "source": "primary"
                    }
                },
                {
                    "id": "372e67954025e0ba6aaa6d586b9e0b59",
                    "type": "CNAME",
                    "name": "instagram.com",
                    "content": "52.22.200.157",
                    "proxiable": true,
                    "proxied": false,
                    "ttl": 120,
                    "locked": false,
                    "zone_id": "023e105f4ecef8ad9ca31a8372d0c353",
                    "zone_name": "example.com",
                    "created_on": "2014-01-01T05:20:00.12345Z",
                    "modified_on": "2014-01-01T05:20:00.12345Z",
                    "data": {},
                    "meta": {
                        "auto_added": true,
                        "source": "primary"
                    }
                },
                {
                    "id": "372e67954025e0ba6aaa6d586b9e0b59",
                    "type": "CNAME",
                    "name": "rmit.edu.au",
                    "content": "131.170.0.105",
                    "proxiable": true,
                    "proxied": false,
                    "ttl": 120,
                    "locked": false,
                    "zone_id": "023e105f4ecef8ad9ca31a8372d0c353",
                    "zone_name": "example.com",
                    "created_on": "2014-01-01T05:20:00.12345Z",
                    "modified_on": "2014-01-01T05:20:00.12345Z",
                    "data": {},
                    "meta": {
                        "auto_added": true,
                        "source": "primary"
                    }
                },
            ]
        }
    """.data(using: .utf8)!

    let updateDnsResponse: Data = """
        {
          "success": true,
          "errors": [],
          "messages": [],
          "result": {
            "id": "372e67954025e0ba6aaa6d586b9e0b59",
            "type": "A",
            "name": "example.com",
            "content": "198.51.100.4",
            "proxiable": true,
            "proxied": false,
            "ttl": 120,
            "locked": false,
            "zone_id": "023e105f4ecef8ad9ca31a8372d0c353",
            "zone_name": "example.com",
            "created_on": "2014-01-01T05:20:00.12345Z",
            "modified_on": "2014-01-01T05:20:00.12345Z",
            "data": {},
            "meta": {
              "auto_added": true,
              "source": "primary"
            }
          }
        }
    """.data(using: .utf8)!
}
