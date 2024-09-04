# REFRESH
## Description
This script will simulate pressing ctrl+shift+r in firefox, when you're in a development server. 
I've designed it so it works with vim.

Useful if you're writing frontend code (html css and js) in vim.

You need to make sure you have: 
- `bash`.
- `python3`.
- `firefox`.
- `xdotool`.
- `md5sum`.

To see if you have them install just run them in your package manager to see if you have them.

### Distros Tested:
- Arch linux.
- Android running Termux (One Plus 7pro).
> Everything seems to be working fine.

I initially tried using it with the Brave browser, but `xdotool` wouldn't pick up the right window, so I switched to Firefox instead. 

Its probably just a personal skill issue or a problem with the way I've config'd my OS, not with `xdotool`, but since I don't currently have the time to look into exactly why it doesn't work for me. I just went with good o'l firefox.

No issues with Firefox so far. 

On Desktop I'm using regular vim as my text editor(VIM Version 9.1), adding the following in your `.vimrc` will make it so you don't have to keep saving your work everytime to trigger the reload.
- `autocmd InsertLeave,TextChanged,InsertChange * silent! wa`.
> Note: Sometimes it can play up, so you can try different options or just revert back to manually saving your work.

The script monitors whatever directory you call it from. It looks for an "index" file and then hashes the contents of your directory, by running a simple `ls` command, to keep track of any changes. 

Any change in the directory will trigger the reload of the browser. You can adjust how often the script checks for a change in your directory by adjusting the first sleep parameter in the `hash_check` function(You'll see a comment next to it).

### How to use
I recommed you create an `alias` to the script which you can then call from anywhere in your bash terminal.

I created one called:
- 'devstart="~/git/tools/refresh/refresh.sh"' 
> Note: Make sure you change the path to wherever you decide to clone this repo.

If I'm working on a website or project then I'll go to the top of that directory where the index.html is located and call `devstart` to run the script. 

Choose a port to work with; I usually go with port 3000.

> Note: You need to make sure you have a **`<title>`(some title in here)`</title>` tag**. The script looks for the value of the first title tag you have set in the index file and uses it to load the project. It also uses whatever you've set in that title as the identifier for the window to send signals to with `xdotool`. 

>**MAKE SURE YOU SET IT!!**

Once you're done with the server, you need to close it in order to liberate that port or it will remain open.

I usually just run a `pgrep python3` to get the PID and then I kill it. 

That's it! 

An extremely light, simple and faff free way to live view your code in the browser, enjoy!

**If you're using TERMUX on Android use the version `termux-refresh.sh`**
