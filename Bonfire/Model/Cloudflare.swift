//
//  Cloudflare.swift
//  Bonfire
//
//  Copyright © 2020 ipse. All rights reserved.
//

import Foundation

struct Cloudflare {
    
    init(email: String, apiKey: String) {}
    
    public func getZones() -> [Zone] {
        let retVal: [Zone] = [
            Zone(name: "example.com", id: "023e105f4ecef8ad9ca31a8372d0c353"),
            Zone(name: "test.com", id: "353c0d2738a13ac9da8fece4f501e320"),
            Zone(name: "a.site", id: "853e105f4ecef8ad9ca31a8372d0c432")
        ]
        
        return retVal
    }
    
    public func getAnalytics(zoneId: String) -> [String: Any]? {
        let data: Data = """
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
        
        let json: [String: Any]
        do {
            json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        } catch {
            return nil
        }
        
        guard let results = json["result"] as? [String: Any],
            let totals = results["totals"] as? [String: Any],
            let requests = totals["requests"] as? [String: Any],
            let requests_cached = requests["cached"] as? Int,
            let requests_uncached = requests["uncached"] as? Int,
            let top_countries = requests["country"] as? [String: Int],
            let threats = totals["threats"] as? [String: Any],
            let threats_all = threats["all"] as? Int,
            let pageviews = totals["pageviews"] as? [String: Any],
            let pageviews_all = pageviews["all"] as? Int
        else {
            return nil
        }
        
        return [
            "requests_cached": requests_cached,
            "requests_uncached": requests_uncached,
            "top_countries": top_countries,
            "threats": threats_all,
            "pageviews": pageviews_all
        ]
    }
}
