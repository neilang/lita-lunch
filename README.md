# lita-lunch

[![Build Status](https://travis-ci.org/neilang/lita-lunch.png?branch=master)](https://travis-ci.org/neilang/lita-lunch)
[![Coverage Status](https://coveralls.io/repos/neilang/lita-lunch/badge.png)](https://coveralls.io/r/neilang/lita-lunch)

A lita handler for helping you pick where to go for lunch today!

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
lita lunch places add the taco hut
lita lunch places add Korean BBQ
```

Then you can get a lunch suggestion:

```
lita lunch suggestion
where should I go for lunch?
```

You can list all stored places:

```
lita lunch places
```

And remove unwanted places:

```
lita lunch places remove the taco hut
```
