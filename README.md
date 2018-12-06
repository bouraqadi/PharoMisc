# PharoMisc
Small utilities and libraries for Pharo. All under MIT Licence.
Each project is in a dedicated folder with a Readme file.

To install any of the projects below evaluate the following expression in a Playground
```Smalltalk
Metacello new
  baseline: '<PROJECT_NAME>';
  repository: 'github://bouraqadi/PharoMisc';
  load
 ```

# Table of Contents
## A
- [AppMaker](/AppMaker): I turn a development image into a ready to use app. I disable development menus and shortcuts. Image is locked so users can only interact via UI kept open.

## B
- [BooleanExpressions](/BooleanExpressions): This package introduces extensions to collections to make it easy to write usual expressions. The goal is to avoid writing long sequences of logic messages `and:` and `or:`

## C
- [Concurrency](/Concurrency): I introduce simple and easy to use concurrency library
- [CsvToPillarConverter](/CsvToPillarConverter): Converts CSV to Pillar, ready to display on web page. Used for generating Pillar for ESUG website based on CSV obtained from registration server.

## E
- [EasyUI](/EasyUI): Small library to quickly make GUI that responds to user interactions. 
- [Equals](/Equals): Defines an equality method `=` that is general to apply to different applications. 
