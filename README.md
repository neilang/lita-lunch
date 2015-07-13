# lita-lunch

[![Build Status](https://travis-ci.org/neilang/lita-lunch.png?branch=master)](https://travis-ci.org/neilang/lita-lunch)
[![Coverage Status](https://coveralls.io/repos/neilang/lita-lunch/badge.png)](https://coveralls.io/r/neilang/lita-lunch)

A lita handler to help you pick where to go for lunch.

## Installation

Add lita-lunch to your Lita instance's Gemfile:

``` ruby
gem "lita-lunch"
```

## Configuration

There is no additional configuration.

## Usage

First you will to add some of your favorite lunch places:

```
lita lunch add the taco hut
lita lunch add Korean BBQ
```

Then you can get a lunch suggestion:

```
where should I go for lunch?
lita lunch suggestion
```

You can list all stored places:

```
lita lunch places
```

And remove unwanted places:

```
lita lunch remove the taco hut
```
