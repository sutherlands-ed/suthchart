#! /bin/bash

# Build all the CoffeeScript source files into a single JavaScript output file...

suthdrawLibs="src/main/coffee/suthdraw/Element.coffee \
	src/main/coffee/suthdraw/Circle.coffee \
	src/main/coffee/suthdraw/Curve.coffee \
	src/main/coffee/suthdraw/Group.coffee \
	src/main/coffee/suthdraw/Line.coffee \
	src/main/coffee/suthdraw/Oval.coffee \
	src/main/coffee/suthdraw/Text.coffee \
	src/main/coffee/suthdraw/Drawing.coffee \
	src/main/coffee/suthdraw/SVGRenderer.coffee \
	src/main/coffee/suthdraw/VMLRenderer.coffee"

suthchartLibs="src/main/coffee/suthchart/Chart.coffee"

coffee --join target/suthdraw.js --compile $suthdrawLibs

coffee --join target/suthchart.js --compile $suthdrawLibs $suthchartLibs

# Use the Google closure compiler to minify the resulting code.
# To install the Google closure compiler on a Mac with Homebrew just enter: `brew install closure-compiler`.

closure-compiler --js_output_file target/suthdraw.min.js target/suthdraw.js

closure-compiler --js_output_file target/suthchart.min.js target/suthchart.js

