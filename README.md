# gridgame

example tdd ruby console game, nethack-like

it's an example of a few things to do with tdd:
- how you can tdd a console application by having a console object/adapter and faking it
- how you can use meaningful high level tests to drive right from start
- how unit tests can arrive a little later as the design gets driven out

so it could be viewed that it should have more unit (class isolation) tests, but this there
would be a shift to more of them as it developed from here... i may take it further and show more of this.

## how to run

after clone...

### if you can wrangle ruby environments

install appropriate ruby (see `.ruby-version`) and rake (see `Gemfile`) then:

```
bundle install
rake run
```

### if ruby environment wrangling is not fun for you

let's write a Dockerfile - open an issue or pull request :)

## how to dev

after bundle install has been run,
to run tests

```
rake test
```

or actually it is the default task so just

```
rake
```

should suffice
