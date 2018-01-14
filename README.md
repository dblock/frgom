# Your First Ruby Gem of Many

[![Build Status](https://travis-ci.org/dblock/frgom.svg?branch=master)](https://travis-ci.org/dblock/frgom)

## What's This?

![Flatiron School](fs.png)

A gem live-coded from scratch at [Flatiron School](https://flatironschool.com) in January, 2018.

* [Slides from the Lecture](SLIDES.pdf)
* [Live Code Walk Through](LIVE.md)

## Usage

Install `frgom`, add the following to `Gemfile`.

```ruby
gem 'frgom'
```

### Splines

#### Frgom::Splines::B

This is a B-spline that can be reticulated.

```ruby
spline = Frgom::Splines::B.new
spline.reticulated? # false
spline.reticulate!
spline.reticulated? # true
```

### Command Line Interface

You can reticulate splines on the command line.

```
frgom --verbose reticulate
```

Use `frgom help` for detailed syntax.

## License

Copyright (c) 2018 Daniel Doubrovkine and Contributors

MIT License, see [LICENSE](LICENSE.md) for details.
