# lita-lunch

[![Build Status](https://travis-ci.org/neilang/lita-lunch.png?branch=master)](https://travis-ci.org/neilang/lita-lunch)
[![Coverage Status](https://coveralls.io/repos/neilang/lita-lunch/badge.png)](https://coveralls.io/r/neilang/lita-lunch)

A lita handler to help you pick where to go for lunch.

Populate Lita with a list of of your favourite lunch places, so next next time someone asks "where should I go for lunch?" you get a useful suggestion.

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
You: lita lunch add the taco hut
Lita: taco hut has been added

You: lita lunch add Korean BBQ
Lita: Korean BBQ has been added

You: lita lunch add :hamburger:
Lita: :hamburger: has been added
```

Then you can get a lunch suggestion:

```
You: where should I go for lunch?
Lita: How about the taco hut?

You: lita lunch suggestion
Lita: How about :hamburger:?
```

You can list all stored places:

```
You: lita lunch places
Lita: taco hut
      Korean BBQ
      :hamburger:
```

And remove unwanted places:

```
You: lita lunch remove the taco hut
Lita: taco hut has been removed
```
