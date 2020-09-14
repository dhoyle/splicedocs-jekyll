PDF Notes
Last updated: 9-14-20

This is the Jekyll theme we currently use to generate the Splice Machine documentation: 
https://idratherbewriting.com/documentation-theme-jekyll/

This theme uses Prince to generate a PDF file from the HTML output: 
https://www.princexml.com/

If you are running Prince on a recent version of Mac OS X, you should use the latest version posted here: 
https://www.princexml.com/latest/ (prince-20200812)

This is to avoid the following Prince error when attempting to generate PDF output:
"prince: warning: disabled parallel downloads due to unsupported SSL backend"
Which is described in more detail on this page: 
https://www.princexml.com/forum/topic/3168/naming-and-encoding-behavior-for-embedded-font
(Recent versions of MacOS X use SecureTransport instead of OpenSSL)