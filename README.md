# ELPH

## [Elixir XPath Tester Online](https://tg.pl/elph)

## Elixir XPath tester

This application is made mostly for a learning purposes, hence it is overcomplicated (for example, it uses channels to communicate - simple AJAX would be enough). When started, it generates UUID on the client side and use it to start a private channel to the server, so channel is private for each client. Server starts `:temporary` supervised application to compute XPath (SweetXML is in charge of that) and sends the output (or fail message) back to the client.

Take a look at the source code!

## Installation
First, have Erlang and Elixir installed. Then install hex

    mix local.hex

Download and install ELPH:

    git clone git@github.com:grych/elph.git
    cd elph
    mix deps.get

Get node.js and npm. Then install brunch packages:

    npm install && node node_modules/brunch/bin/brunch build

If delopying production version, create `config/prod.secret.exs` (it is not under git) and compile all:

    MIX_ENV=prod mix compile
    node_modules/brunch/bin/brunch build --production
    MIX_ENV=prod mix phoenix.digest

Start the server

    mix phoenix.server

On production

    PORT=6502 MIX_ENV=prod mix phoenix.server


## Author
This software is written by Tomek 'Grych' Gryszkiewicz. Do not hestitate to contact me at grych@tg.pl or visit [my web page](http://www.tg.pl).

## License
The MIT License (MIT)

Copyright (c) 2016 Tomek "Grych" Gryszkiewicz <grych@tg.pl>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
