2.5.1 (July 19th, 2018)
 - BUGFIX: typo in application.rb regarding template name

 2.5.0 (July 18th, 2018)
 - Change fog dependency to fog-aws

2.4.0 (July 17th, 2018)
 - Add 'private_template' option for securely passing git credentials.

2.3.3 (January 19th, 2016)
 - BUGFIX: Explicitly specify Jekyll output directory within
   temporary directory

2.3.2 (January 13th, 2016)
 - Gave stevenson a coke habit

2.3.0 (December 30th, 2015)
 - Fix zip creation
 - Add ability to specify zip filename
 - Pass CLI options to Output Filters

2.2.2 (December 11th, 2015)
 - Add a clearer error message to Template message
 - Refactor user directory fetch to try ENV (or default to root on
   failure)

2.2.1 (December 10th, 2015)
 - Better capture and present Stevenson vs Ruby errors

2.2.0 (October 9th, 2015)
 - Add subdirectory option to Git template

2.1.0 (October 3rd, 2015)
 - Add deployer logic
 - Add S3 deployer class for sending compiled projects to S3 buckets

2.0.0 (September 30th, 2015)
 - Add template aliases as dotfile
 - Remove individual template config logic and inputs
 - Refactor processing logic from templates, with data files, and through output filters
