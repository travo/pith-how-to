---
layout: "/_layout.html.haml"
...

# Pith: tools all the way down.

While we're all trying to work in [craftsman's time](http://www.lukew.com/ff/entry.asp?1603), it's equally important for us to use, develop and integrate tools into our work which help us focus on the real problems we're trying to solve.

Beginners can find using these tools cumbersome, unwieldy and sometimes a frustrating diversion from practicing the fundamental aspects of their work. Experienced developers look for or develop tools which can help elevate them from the repetition of basics and back into the realm of the core problem.

[Pith](http://github.com/mdub/pith) is a tool written by an experienced developer who got frustrated by not feeling elevated from the drudgery of maintaining his own website. Mike sought to combine some existing tools that he enjoyed using and as a result has created something new that allowed him (and us) to easily manage and quickly publish websites.

As developers, it is natural for us to want to be close to the core elements of our website, but not so close to the nuts and bolts that we become distracted from the writing, design and core communication that we want to engage in.

Pith is a powerful and light-weight website publishing tool. It combines SASS, HAML and Markdown (among a few other handy template formats) into a single Ruby Gem. Pith makes it easy for web developers to rapidly build out websites with multiple layouts and demanding information architecture.

You can use Pith for a range of applications; from wire framing and prototyping to managing and structuring the development of large projects. But best of all, I especially like using Pith to build websites.

If you're a fancy-pants developer, you can do a bunch of very clever things with Pith. By writing your own Ruby scripts you can start to explore dynamism and drawing content from API's and other sources. We'll explore how we might do something like that later.

When you're working with Pith, you can build your templates on demand. You can tell Pith to watch your working directory and build your templates as they're changed. More exciting still, Pith includes a small web-server, and you can tell Pith to serve your templates via a small local web server while you're changing and editing your code.

Once you're done, you can drop the contents of your generated work straight onto your production web server. Home in time for nuts and beer. Let's get started.

## Bootstrapping (nerd speak for getting-started)

In your favourite Ruby environment;

    $ gem install pith

Now you can follow the instructions on the helpful Pith website to get your environment set up. You'll need Ruby for sure, but once you install Pith, it comes with all the nifty bits and bobs to help you rapidly build out your ideas.

The flexibility granted by using Pith is one of its greatest features. You can structure your website in any way you prefer, all your work is copied into the _out directory, completely unchanged. Any files you name with an extension that Pith recognises are processed and then published as well. Any folders and file names which are prefixed with an underscore `_` are ignored.

You can create a starting directory for your project, say `my-site` and inside that you add some files.

    my-site/
      _pith/
      images/
        logo.png
      index.html.haml

Notice the _pith directory? That's there to hold any configuration files or Ruby scripts you might want to create later. It doesn't get included in your output directory. I promise I'll tell you how to use the `_pith` directory at the end.

Once you've edited your files, you can run the `pith build` command to generate your website.

    $ pith -i my-site build
    Generating to "my-site/_out"
    --(copy)-->   images/logo.png
    --(haml)-->   index.html

The sauce that makes Pith great is the inclusion of other great tools which make web development more fun!

### SASS

SASS *is* awesome. It is such a nifty way to work with, extend and rock CSS. Last year, David Demaree wrote a wonderful [getting started guide to sass](http://www.alistapart.com/articles/getting-started-with-sass/) on A List Apart, and you should totally read it. The best bits though are being able to  include variables and mixins into your css awesome!

You can use variables to declare things like colours

    $corporate-red: #AF1210

And you can declare mixins so you can avoid repeating yourself over and over again

    @mixin fade-to-corporate-red
      background-color: $corporate-red
      -webkit-transition: background-color 0.25s ease-in-out
      -moz-transition: background-color 0.25s ease-in-out
      -o-transition: background-color 0.25s ease-in-out
      transition: background-color 0.25s ease-in-out

### HAML

HAML doesn't get quite as much press as SASS, but it is no less awesome. It uses a strict nesting pattern, like SASS, yet using it doesn't feel like working for an angry boss — using HAML is *fun*. I like to use it because my HTML templates are much nicer to look at. Shallow I know — but hey, if I have to look at this stuff all the time, I might as well enjoy it.

[Don't Repeat Yourself](http://en.wikipedia.org/wiki/Don't_repeat_yourself) is a simple mantra, and it can require a bit of discipline to follow. Tools like HAML encourage you to practice a little DRY coding, simply by not having to close your tags and using strict indenting.

    %section.container
      %h1 Coding is awesome
      %h2 When you're using HAML
        .content
          There are some great examples of using HAML, you
          should check them out.
        #video-box

There is a lot to take in here.

Tags are prefixed with a percent character, you can append those tags with a dot-chained list of the classes that those tags will use.

HAML will assume that you mean `<div class="content">` if you start a block of code with `.content`. HAML will also assume that you mean '<div id="video-box">` if you start a block of code with `#video-box` — so cool. Less typing, more fun.


## Taking names and kickin' butt

### Layouts

Pith allows you to set much of your designs in layouts, which then can wrap your individual pages.

By creating a `my-layout.haml` document and then inserting the following extra information (meta-data) in the top of your template your page will be processed with that layout.

    ---
    layout: "/my-layout.haml"
    ...

### Partials

By using partials and pulling out common chunks of code you can keep your templates nice and tidy.

    %nav.horizontal
      %ul
        %li
          %a{ href: "index.html" } Home
        %li
          %a{ href: "about.html" } About Us
        %li
          %a{ href: "monkeys.html" } Our Monkeys

Instead of pasting that on all your pages, you can extract that code out into a partial — a file named "_navigation.haml" placed in a folder called "common" and easily include in your templates it by writing;

    = include "common/navigation"

C'mon! — that's fun. You can do the same with your SASS (as you always have with CSS) to prevent them from becoming 3000 line behemoths by breaking them up into concise 200 line files of readable code.


## Getting clever: Ruby

Okay, as promised, this is how we use the `_pith` directory.

In your `_pith` directory you can place a config.rb file into which you can include a number of nifty helper methods which can run when the partials are generated.

Here's a simple example;

    project.helpers do

      def published_note
        time_now = Time.now()
        "Published on #{time_now.strftime("%d %B %Y")}"
      end

    end

Which you can then include in your HAML templates;


    %footer

      %p
        Written by Travis Winters.
        %span= published_note


## Doing great things quickly

There's a lot to take in here. I've assumed that you're the kind of experienced and capable developer who is on the look out for useful tools. Tools that help you rise above the drudgery of your work and back into the space that allows you to think of real problems, not ones like, "OMG how am I going to manage this sprawling website and it's content".

There are other tools like Pith out there, such as [Jeckyll](http://jekyllrb.com/). Many tend to live in the realm of nerds, and bless 'em all. The reason I like Pith is that it's more oriented to fulfilling a complex need, simply — publishing websites quickly, using your favourite tools.

