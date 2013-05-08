SoundCloud Play List Application
======================
A SoundCloud play list application which allows you to search, play, manage play list of songs in SoundCloud.
It has 2 pages with the following functionalities:
* Search result page.
 * When first opened, it shows default result having the highest 'hotness'
 * To do a keyword search, use a search box located in top-right
 * To display play list page by clicking on the button in top-right
 * To play a song, clicking on [Play] button located in the left of each song list item
 * To add to play list, clicking on [Add] button located in the right of each song list item
* Play list page.
 * To play a song in the play list, click on [Play] button located in the left of each play list items
 * To remove a song from the play list, click on [Remove] button located in the right of each play list item
 * To reorganize the order of play list, do drag & drop
 * To go back to the song list page, click on [Song List] button located in top-left
 
Usage
------
* Just open index.html with a browser
 * Or access to the hosted version : http://kotaroshima.github.com/playlist/

Development
------
* Do the following to checkout Backpack.js:
```
git submodule update --init
```
* For compiling CoffeeScript files, you need CoffeeScript installed:
```
npm install -g coffee-script
```
* To build JS files, run:
```
cake build
```

Libraries Used
--------
* [jQuery](http://jquery.com/)
* [jQuery UI](http://jqueryui.com/)
* [jQuery UI Touch Punch](http://touchpunch.furf.com//)
* [Underscore.js](http://underscorejs.org/)
* [Backbone.js](http://backbonejs.org/)
* [Require.js](http://http://requirejs.org/)
* [Sass](http://sass-lang.com/)
* [SoundCloud API/SDK](http://developers.soundcloud.com/docs/api/)

----------
Copyright &copy; 2013 Kotaro Shima