Title: Gather Windows on Ubuntu
Categories: hacks, localhost, linux, ubuntu
Date: 18 February 2016 09:10

# Gather Windows on Ubuntu

On my Ubuntu laptop, I found that when the display goes to sleep, I would
consistantly have this issue where some of my active windows would end up on a
hidden workspace. Super annoying, especially because I found myself having to
kill the app to get them back. After a little googling, I found those following
script, which when coupled with a custom keybinding did the trick.

I placed the following file in `$HOME/bin`, which I already have added to my
path, and named it `gather`.

```bash
#!/bin/bash
# From: https://github.com/mezga0153/offscreen-window-restore

width=`xrandr | grep current | awk {'print $8'}`

`wmctrl -l -G | awk -v w=$width '{
	if ($8 != "unity-dash" && $8 != "Hud") {
		if ($3 >= w || $3 < 0) {
			system("wmctrl -i -r " $1 " -e 0," sqrt($3*$3) % w ",-1,-1,-1");
		}
	}
}'`
```

I then ensured that it was executable with `chmod 755 $HOME/bin/gather`. Once done,
I added a keybind, for me `Super-g`, via **System Settings > Keyboard >
Shortcuts > Custom Shortcuts**.

**Note:**

I had to install `wmctrl` as well for this to work, with:

```bash
apt-get install -y wmctrl
```

Enjoy!
