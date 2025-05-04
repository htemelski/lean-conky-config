#!/bin/bash

# This file includes code from https://github.com/Madh93/conky-spotify
# Copyright (C) 2016 Madh93
# Licensed under the GNU General Public License, version 3 (GPLv3)
# See <https://www.gnu.org/licenses/gpl-3.0.html> for details.

# Modifications by htemelski, 2025

id_current=$(cat  ~/data/code/lean-conky-config/lib/components/spotify/current/current.txt)
id_new=`~/data/code/lean-conky-config/lib/components/spotify/scripts/id.sh`
cover=
imgurl=
dbus=`busctl --user list | grep "spotify"`

if [ "$dbus" == "" ]; then
       `cp  ~/data/code/lean-conky-config/lib/components/spotify/empty.jpg ~/data/code/lean-conky-config/lib/components/spotify/current/current.jpg`
	echo "" >  ~/data/code/lean-conky-config/lib/components/spotify/current/current.txt
else
	if [ "$id_new" != "$id_current" ]; then

		echo $id_new >  ~/data/code/lean-conky-config/lib/components/spotify/current/current.txt
		imgname=`cat  ~/data/code/lean-conky-config/lib/components/spotify/current/current.txt | cut -d '/' -f5`

		cover=`ls  ~/data/code/lean-conky-config/lib/components/spotify/covers | grep "$id_new"`

		if grep -q "${imgname}" <<< "$cover"
		then
			`cp  ~/data/code/lean-conky-config/lib/components/spotify/covers/$imgname.jpg  ~/data/code/lean-conky-config/lib/components/spotify/current/current.jpg`
		else
			imgurl=` ~/data/code/lean-conky-config/lib/components/spotify/scripts/imgurl.sh`
			`wget -q -O  ~/data/code/lean-conky-config/lib/components/spotify/covers/$imgname.jpg $imgurl &> /dev/null`
			`touch  ~/data/code/lean-conky-config/lib/components/spotify/covers/$imgname.jpg`
			`cp  ~/data/code/lean-conky-config/lib/components/spotify/covers/$imgname.jpg  ~/data/code/lean-conky-config/lib/components/spotify/current/current.jpg`
			# clean up covers folder, keeping only the latest X amount, in below example it is 10
			rm -f `ls -t  ~/data/code/lean-conky-config/lib/components/spotify/covers/* | awk 'NR>10'`
			rm -f wget-log #wget-logs are accumulated otherwise
		fi
	fi
fi