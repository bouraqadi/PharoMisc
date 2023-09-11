# BooleanExpressions
This package introduces extensions to collections to make it easy to write usual expressions.
The goal is to avoid writing long sequences of logic messages such as:
```Smalltalk
exp1 or: [ exp2 or: [exp3 or: [exp4]]
exp1 and: [ exp2 and: [exp3 and: [exp4]]
```

# Install
```Smalltalk
Metacello new
  baseline: 'BooleanExpressions';
  repository: 'github://bouraqadi/PharoMisc';
  load
```

# Usage
`{[exp1]. [exp2]. [exp3]. [exp4]} anyTrue; allTrue; anyFalse; allFalse`

Note that boolean expressions are inside blocks to allow for delayed evaluation.
But, this is of course not mandatory.
