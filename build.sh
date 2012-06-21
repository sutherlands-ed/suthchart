#! /bin/bash

# Build all the CoffeeScript source files into a single JavaScript output file...

coffee --join target/suthchart.js --compile \
	src/main/coffee/Element.coffee \
	src/main/coffee/Circle.coffee \
	src/main/coffee/Curve.coffee \
	src/main/coffee/Line.coffee \
	src/main/coffee/Oval.coffee \
	src/main/coffee/Text.coffee \
	src/main/coffee/Drawing.coffee \
	src/main/coffee/SVGRenderer.coffee \
	src/main/coffee/VMLRenderer.coffee

# Use the Google closure compiler to minify the resulting code.
# To install the Google closure compiler on a Mac with Homebrew just enter: `brew install closure-compiler`.

closure-compiler --js_output_file target/suthchart.min.js target/suthchart.js

