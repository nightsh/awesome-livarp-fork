## Awesome WM config

### Forked from Livarp's config, made by Aphelion https://github.com/Aphelion/awesome-livarp-conf

This is a bundle of config files forked from the Livarp project. Since it used 
an old version of Awesome (3.4) and there were some API changes implemented into
3.5, I took it and ported to the new code requirements.

#### Why this is not a GitHub fork?

Beacause I altered it a bit more than I had to, and pull request wasn't an 
option anymore. This is not Aphelion's original configuration anymore, even 
though it's heavily based on it.

### Features

* widgets for: MPD, calendar, battery, cpu, memory, disk space and a lot 
  of other things (look at the config.lua file)
* broken down config for every part, so it's easier to maintain
* Awesome 3.5 compatibility
* highly responsive, real time widgets for easier system monitoring
* show/hide toggle key bindings for both the top and bottom wibox
* a lot more, try it and see for yourself ;-)

### Screenshots

![Screenshot 1](https://raw.github.com/nightsh/awesome-livarp-fork/master/screens/1.png "Screenshot 1")
![Screenshot 3](https://raw.github.com/nightsh/awesome-livarp-fork/master/screens/3.png "Screenshot 3")

### What works?

Pretty much everything, *but* only in graph widget mode. See config.lua for 
options regarding widgets. There might be some more options in there that 
might cause carious crashes once changed, anyway.

I'll also migrate the remaining codebase to awesome 3.5 API requirements, once 
I'll have the proper time to do it. So far, I only took care of my working 
environment, and the other(s) will be following at some point.

### How to help?

First, port the remaining 3.4 code to the current version. This means changing 
the config.lua file, firing up a mode that doesn't work properly, and then 
follow the debug information. Indications about how to fix the errors are 
detailed in Awesome's wiki: 
    http://awesome.naquadah.org/wiki/Awesome_3.4_to_3.5

Of course, looking at the working configs alo works :-)
