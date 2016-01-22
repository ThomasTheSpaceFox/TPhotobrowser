#!/bin/bash

ABOUTTEXT="TPhotobrowser is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

TPhotobrowser is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with TPhotobrowser.  If not, see <http://www.gnu.org/licenses/>"
TABGUIDE="Main View: 
 -this is the main image view.

File select:
 -this is where you select an image file to view.

 -In the FILE SELECT tab, Choose an image file, and click OK.

 -Note that file select and view modes are remembered until you close 
the program.

Properties: 
 -some basic info in the image.

Help: 
 -here you will find the help section."
TOOLBARGUIDE="Top toolbar:
 -the entry box shows the full path of the current file. however it
is not used to open files.

 -the text to the right of the entry box is the current view mode.

Bottom Toolbar:
 -the checkboxes alow to change to a few larger view modes. 
check one, and click OK to change the view mode. see the top 
toolbar for the current view mode.

 -OK: click OK when you  select an image in the File select 
tab, or change view modes.

 -Cancel: click CANCEL to close the program."
# Config section.

# starting/ fallback dir:
FILEPATHCONF=$(dirs)
# full path to a fallback image
IMGCONF=/root/root.png

#end config sectipn.
CHOOSER="$IMGCONF"
FILENAMEDEF=$(basename "$CHOOSER")
FILEPATHCOSMET=$(dirname "$CHOOSER")
EXIT=nul
CHECKBOX1=nul
CHECKBOX2=nul
CHECKBOX3=nul
CHECKBOX4=nul
CHECKBOX5=nul
IMGSIZE=400
IMGSIZEH=300
FILEPATHDEF="$FILEPATHCONF"
FILEPATHTEMP="$FILEPATHCONF"
IMGPATHTEMP="$IMGCONF"
VIEWTXT="normal view"
until [[ "$EXIT" = "Cancel" || "$EXIT" = "abort" ]]; do
export DIALOG='
<window title="TPhotobrowser '${FILENAMEDEF}'">
  <vbox>
    <hbox>
      <entry editable="false">
        <default>"'${CHOOSER}'"</default>
      </entry>
      <text>
        <label>'${VIEWTXT}'</label>
      </text>
    </hbox>
    <notebook labels="Main View|File select|Properties|Help">
      <vbox>
        <pixmap>
          <input file>'${CHOOSER}'</input>
          <width>'${IMGSIZE}'</width>
          <height>'${IMGSIZEH}'</height>
        </pixmap>
      </vbox>
      <vbox>
        <chooser>
          <height>300</height><width>600</width>
          <variable>CHOOSER</variable>
          <default>'${FILEPATHDEF}'</default>
        </chooser>
      </vbox>
      <vbox>
        <hbox>
          <pixmap>
            <input file>'${CHOOSER}'</input>
            <width>64</width>
            <height>64</height>
          </pixmap>
          <text>
            <label>"'${FILENAMEDEF}'  Properties:"</label>
          </text>
        </hbox>
        <text>
          <label>"Name:"</label>
        </text>
        <entry editable="false">
          <default>"'${FILENAMEDEF}'"</default>
        </entry>
        <text>
          <label>"Location:"</label>
        </text>
        <entry editable="false">
          <default>"'${FILEPATHCOSMET}'"</default>
        </entry>
        <text>
          <label>"Full Path:"</label>
        </text>
        <entry editable="false">
          <default>"'${CHOOSER}'"</default>
        </entry>
      </vbox>
      <vbox>
        <notebook labels="Tab Guide|Toolbar Guide|Links|About">
          <vbox>
            <text>
              <label>"The Tabs:"</label>
            </text>
            <edit editable="false">
              <variable>EDITOR</variable>
              <width>450</width><height>200</height>
              <default>"'${TABGUIDE}'"</default>
            </edit>
          </vbox>
          <vbox>
            <text>
              <label>"The Toolbars:"</label>
            </text>
            <edit editable="false">
              <variable>EDITOR</variable>
              <width>450</width><height>200</height>
              <default>"'${TOOLBARGUIDE}'"</default>
            </edit>
          </vbox>
          <vbox>
            <text>
              <label>"TPhotobrowser v1.1.4"</label>
            </text>
          </vbox>
          <vbox>
            <text>
              <label>"TPhotobrowser v1.1.4"</label>
            </text>
            <text>
              <label>"(c) 2016 Thomas Leathers"</label>
            </text>
            <edit editable="false">
              <variable>EDITOR</variable>
              <width>450</width><height>200</height>
              <default>"'${ABOUTTEXT}'"</default>
            </edit>
          </vbox>
        </notebook>
      </vbox>
    </notebook>
    <hbox>
      <checkbox>
        <label>800x600</label>
        <variable>CHECKBOX5</variable>
      </checkbox>
      <checkbox>
        <label>640x480</label>
        <variable>CHECKBOX4</variable>
      </checkbox>
      <checkbox>
        <label>normal view</label>
        <variable>CHECKBOX2</variable>
      </checkbox>
      <button ok></button>
      <button cancel></button>
    </hbox>
  </vbox>
</window>'

I=$IFS; IFS=""
for STATEMENTS in  $(gtkdialog --program DIALOG); do
  eval $STATEMENTS
done
IFS=$I
  if [ $CHECKBOX5 = "true" ]; then
  IMGSIZE=800
  IMGSIZEH=600
  VIEWTXT="800x600"
  fi
  if [ $CHECKBOX4 = "true" ]; then
  IMGSIZE=640
  IMGSIZEH=480
  VIEWTXT="640x480"
  fi
  if [ $CHECKBOX2 = "true" ]; then
  IMGSIZE=600
  IMGSIZEH=300
  VIEWTXT="normal view"
  fi
  if test -e "$CHOOSER"; then
  FILEPATHDEF=$(dirname "$CHOOSER")
  FILEPATHCOSMET=$(dirname "$CHOOSER")
  FILENAMEDEF=$(basename "$CHOOSER")
  IMGPATHTEMP="$CHOOSER"
  FILEPATHTEMP="$FILEPATHDEF" 
  else
    CHOOSER="$IMGPATHTEMP"
    FILEPATHDEF="$FILEPATHTEMP"
  fi
done