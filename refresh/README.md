# REFRESH
## Description
---
This script will simulate pressing ctrl+shift+r in firefox, when you're in a development server. Usefull if you're writing html css and js in vim.

You need to  make sure you have: 
- `python3`. => for the http.server module.
- `firefox`. => the browser.
- `xdotool`. => for sending keypresses to firefox.

I initially tried using it with the Brave browser, but `xdotool` wouldn't pick up the right window, so I switched to Firefox instead. 
It may be a problem with my OS and not with `xdotool`, but I don't currently have the time to look into exactly why it doesn't work for me.
No issues with Firefox so far. 

Im using regular vim as my text editor(VIM Version 9.1), adding the following in my `.vimrc` will make it so you don't have to keep saving your work everytime to trigger the reload.
- `autocmd InsertLeave,TextChanged,InsertChange * silent! wa` to simulate autosaving.
> Note: Sometimes it can play up, so you can try different options or just revert back to manually saving your work.

The script monitors whatever directory you call it from. It looks for an "index" file and then hashes the contents of your directory to keep track of any changes. 

Any change in the directory will trigger the reload of the browser. You can adjust how often the script checks for a change in your directory by adjusting the sleep parameter in the `hash_check` function.
### How to use
---
I recommed you create an `alias` to the script which you can then call from anywhere in your bash terminal.
I created one called:
- 'devstart="~/git/tools/refresh/refresh.sh"' 
> Note: Make sure you change the path to wherever you decide to clone this repo.

If I'm working on a website or project then I'll go to the top of that directory where the index.html is located and call `devstart` to run the script. 

Choose a port to work with; I usually go with port 3000.

> Note: You need to make sure you have a `<title>`(some title in here)`</title>` tag. The script looks for the value of the first title tag you have set in the index file and uses it to load the project. It also uses whatever you've set in that title as the identifier for the window to send signals to with `xdotool`. 

>MAKE SURE YOU SET IT!!

Once you're done with the server, you need to close it in order to liberate that port or it will remain open.
I usually just run a `pgrep python3` to get the PID and then I kill it. 
That's it. An extremely light, simple and faff free way to live view your code in the browser.

If you're using TERMUX on Android use the version `termux-refresh.sh`
