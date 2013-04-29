NodeNav
=======

Node Visualization & Navigation [[[pre-alpha, look away;]]]

[![Build Status](https://travis-ci.org/harlantwood/nodenav.png?branch=master)](https://travis-ci.org/harlantwood/nodenav)

Basics
-----

With node.js 0.8 or later installed:

    npm install

Local Dev Server
----------------

    http-server
    
Build JSON from CSV
-------------------

    bin/csv2json.coffee source.csv target.json 

or if you prefer:

    node bin/csv2json.js source.csv target.json 

Run Tests
---------
    
    npm install -g grunt-cli   # (the first time only)
    grunt -v
    
    