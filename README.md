# ELPH

## [Elixir XPath Tester Online](http://elph.tg.pl)

## Elixir XPath tester

This application is made mostly for a learning purposes, hence it is overcomplicated (for example, it uses channels to communicate - simple AJAX would be enough). When started, it generates UUID on the client side and use it to start a private channel to the server, so channel is private for each client. Server starts `:temporary` supervised application to compute XPath (SweetXML is in charge of that) and sends the output (or fail message) back to the client.

Take a look at the source code!

## Author
This software is written by Tomek 'Grych' Gryszkiewicz. Do not hestitate to contact me at mailto:grych@tg.pl or visit [my web page](http://www.tg.pl).

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
