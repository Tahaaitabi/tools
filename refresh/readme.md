# REFRESH
---
## Description:
This script will simulate pressing ctrl+shift+r in firefox, when you're in a development server.
It's pretty crude but it does what I need it to, which is to provide me with a similar tool to the one offered in VS-CODE called "Live-Server" by Ritwick Dey.

You need to  make sure you have: 
    - `python3`. => for the http.server module.
    - `firefox`. => the browser.
    - `xdotool`. => for sending keypresses to firefox.

I'm running it on a barebones arch system with DWM (Dynamic Window Manager) as the window manager. 
I initially tried using it with the Brave browser, but `xdotool` wouldn't pick up the right window, so I switched to Firefox instead. 
It may be a problem with my OS and not with `xdotool`, but I don't currently have the time to look into exactly why it doesn't work for me.

I haven't had any issues with Firefox so far. 

Im using regular vim as my text editor, adding the following in my `.vimrc` helped a tonne:
    - `autocmd InsertLeave,TextChanged,InsertChange * silent! wa` to simulate autosaving.
    >Note: Sometimes it can play up, so you can try different options or simply manually save.

That's it. It's simple and faff free.
I will test on other systems and try to imporove portability soon.
