# Inheritance Example
## Cucumber File Location

Every element of a gherkin file, e.g. a `Scenario`, a `Step`, has a location.

Here is a file: `inheritance.feature`

```gherkin
Feature: Learning classical inheritance

  Scenario: Starting with a concrete class
    Given we have a concrete class
    And we want to add some behaviour
    When we add new code to the concrete class
    And embed multiple types
    Then we should consider refactoring to an inheritance hierarchy
```

The `Step`: `Given we have a concrete class` has the location:
`inheritance.feature:4`.

Cucumber allows you to run specific scenarios by passing it a file and
line number when you run it, effectively passing it a location.

To allow cucumber to find the correct elements based on a location, we
have `Location` objects which can match themselves against other
objects.

```ruby
a_location        = Location.new("my_file.feature", 1)
the_same_location = Location.new("my_file.feature", 1)
another_location  = Location.new("my_file.feature", 5)

a_location.match?(the_same_location) # => true
a_location.match?(another_location)  # => false
```

You will find this class and it's specs in this directory.

It is able to match locations that have the same file and line number.

Unfortunately cucumber also needs to be able to run whole files, so we
need to be able to match a wildcard location to a precise location.

Please extend the existing class to accomodate this.

```ruby
a_location        = Location.new("my_file.feature", 1)
wildcard_location = WildcardLocation.new("my_file.feature")

a_location.match?(wildcard_location) # => true
```
