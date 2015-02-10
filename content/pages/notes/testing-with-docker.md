Title: Testing with Docker 
Categories: notes, docker, linux 
Date: 10 Fedruary 2015 13:25

# Testing with Docker

Docker, amoung it's many strengths, allows for easily testing applications or application code on various different version's of that codes interperter.

## Examples

### Node.js / io.js

    :::bash
    host $ docker pull node:latest
    host $ cd /path/to/project
    host $ docker run --rm -it -v $(pwd):/src node:latest \
            bash -lc 'cd /src && rm -rf node_modules && npm install && npm test'
  
### Ruby

    :::bash
    host $ docker pull ruby:latest
    host $ cd /path/to/project
    host $ docker run --rm -it -v $(pwd):/src node:latest \
            bash -lc 'cd /src && bundle install && bundle exec rake test'

These examples can easily be repeated for anything from Go, to Python, to Perl, etc., etc.

Enjoy!
