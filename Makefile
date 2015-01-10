all:
	coffee -b -p main.coffee > main.js
	phantomjs main.js
