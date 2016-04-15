check\_http.rb
==============

A mackerel-agent (or Nagios) plugin for HTTP

Usage
-----

```
$ check_http.rb [-d MIN_DAYS] URL
```

`MIN_DAYS` is minimum number of days a certificate has to be valid.
If the certificate is not valid after `MIN_DAYS`, a warning alert will be reported.

`URL` is the url to be checked.
If an error occurs or the response code is not 2XX, a critical alert will be reported.

mackerel-agent configuration
----------------------------

Add the following configuration to mackerel-agent.conf:

```
[plugin.checks.tdiary]
command = "/path/to/check_http.rb -d 60 https://shugo.net/jit/"
notification_interval = 60
max_check_attempts = 2
```
