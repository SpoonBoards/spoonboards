# SpoonBoards Style Guide

## Logos

* SPBS.png
* spoonflower_powered_by_logo_vector_transparent.png

## Colors

* $soft-white: #fdfdfd;
* $background-color: #f9f9f9;
* $mint-green: #39E9D2;
* $grey: #888;
* $dark-grey: #626262;

## Fonts:

#### Titles

###### Merriweather 300, 400, 700

```
<link href="https://fonts.googleapis.com/css?family=Merriweather:400,700,300" rel="stylesheet" type="text/css">
```

```
font-family: 'Merriweather', sans-serif;
```

#### Body & Headings

###### Lato 300, 400, 700:

```
<link href="https://fonts.googleapis.com/css?family=Lato:400,700,300" rel="stylesheet" type="text/css">
```

```
font-family: 'Lato', sans-serif;
```

## CSS Naming Conventions

###### Classes:
To prevent CSS naming and inheritance conflicts, use page-specific and element-specific conventions for class names.  Format the class names into multiple parts separated by a hyphen a.k.a kabob case.

```
class="page-classname"
```

Where 'page' is based on the Ruby on Rails assets pipeline naming scheme, and 'classname' refers to the HTML element(s) being styled.

###### Ex: class="boards-index-card-image"

In the example above the page is 'boards-index', and the classname is 'card-image'.
