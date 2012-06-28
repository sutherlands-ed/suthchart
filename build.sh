#! /bin/bash

# Compile all the CoffeeScript source files...

coffee --compile --output target/lib src/main/coffee

# Merge the js files together...

suthdrawLibs=" \
	   target/lib/suthdraw/Element.js \
       target/lib/suthdraw/Circle.js \
       target/lib/suthdraw/Curve.js \
       target/lib/suthdraw/Group.js \
       target/lib/suthdraw/Line.js \
       target/lib/suthdraw/Oval.js \
       target/lib/suthdraw/Rectangle.js \
       target/lib/suthdraw/Text.js \
       target/lib/suthdraw/Drawing.js \
       target/lib/suthdraw/ActiveElement.js \
       target/lib/suthdraw/SVGElement.js \
       target/lib/suthdraw/VMLElement.js \
       target/lib/suthdraw/SVGRenderer.js \
       target/lib/suthdraw/VMLRenderer.js"

suthchartLibs="target/lib/suthchart/Chart.js"

cat $suthdrawLibs > target/suthdraw.js
cat $suthdrawLibs $suthchartLibs > target/suthchart.js

# Use the Google closure compiler to minify the resulting code, but background this to return quickly once the main
# compile and concat is complete.

# To install the Google closure compiler on a Mac with Homebrew just enter: `brew install closure-compiler`.

(
	closure-compiler --js_output_file target/suthdraw.min.js target/suthdraw.js
	closure-compiler --js_output_file target/suthchart.min.js target/suthchart.js
) &

