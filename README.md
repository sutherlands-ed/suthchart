# suthchart

> This library is in early development and is not suitable for use at the current time!

This JavaScript library (written in CoffeeScript) is designed to assist in creating SVG and VML graphics that run efficiently on IE8.

The [Raphaël](http://raphaeljs.com/) JavaScript library provides a very effective library for creating identical looking SVG/VML graphics with support for interactivity but performance on IE8 for complex graphs can be sufficiently slow to rule it out from production use for applications that require good IE8 support.  The underlying performance issue with Raphaël on IE8 is the very slow performance of IE8 JavaScript DOM manipulation.  The architecture of Raphaël does not lend itself being optimised for VML as it is designed around ongoing DOM manipulation.

`suthdraw` is designed to generate an object model of the graphic before, at the very last moment, rendering this to a single, complete and compact VML or SVG String which can be inserted as a single operation into the web page.

A further wrapper is provided to wrap around a selected element to allow subsequent runtime modification of elements independent of whether they are rendered in SVG or VML.

`suthchart` (which incorporates `suthdraw`) is a thinner layer of functions to facilitate the creation of graphs: titles, axis, grids, etc.