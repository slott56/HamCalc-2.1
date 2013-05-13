randnum -- Random Number Generator
----------------------------------

This is misnamed; it's really just a shuffle algorithm.

Analysis
~~~~~~~~~

This has two modes:

1.  Shuffle 49 numbers and pick the last 7 as the "Lotto 649 pick".

2.  Shuffle N numbers.

Implementation
~~~~~~~~~~~~~~~

This is entirely a feature of Python's :mod:`random` module.

Nothing more needs to be done.

Which raises a subtle question of what to test and how to test it.

Legacy Quirks
~~~~~~~~~~~~~~

The name is misleading, otherwise there's nothing quirky here.

