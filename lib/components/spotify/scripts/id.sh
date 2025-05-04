#!/bin/bash

# This file includes code from https://github.com/Madh93/conky-spotify
# Copyright (C) 2016 Madh93
# Licensed under the GNU General Public License, version 3 (GPLv3)
# See <https://www.gnu.org/licenses/gpl-3.0.html> for details.

# Modifications by htemelski, 2025

id=`dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' 2>/dev/null | grep spotify/track | cut -d '"' -f2`
echo $id