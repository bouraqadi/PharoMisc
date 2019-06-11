# PharoMisc
Small utilities and libraries for Pharo. All under MIT Licence.
Each project is in a dedicated folder with a Readme file.

To install any of the projects below evaluate the following expression in a Playground
```Smalltalk
Metacello new
  baseline: 'PROJECT_NAME';
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
- [Equals](/Equals): Defines an equality method `=` that is general and apply to different kinds of objects. Comparison is based on IVs, and it is easily customizable. Also includes a generic `hash` method that matches the `=` implementation, which is mandatory when using hashed collections such as sets.

## L
- [LightweightObserver](/LightweightObserver): Lightweight alternative to Announcement. Subclasses of subject automatically generate method wrappers to generate events notifying changes of observed IVs. When IVs reference collections, events can be generated on accessing collection elements. [Read full description](https://noury.tech/tutorials/lightweight-observer-pharo/)

## N
- [NetworkExtras](/NetworkExtras): Provides classes that wrap the basic sockets to ease networking

## S
- [StateMachine](/StateMachine): Defines automaton, states and transition. 
