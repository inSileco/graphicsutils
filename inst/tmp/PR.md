:book: documentation
:hammer: function
:wrench: method
:shield: tests
:floppy_disk: data
:wastebasket: delete
:arrow_up: new version
:bug: bug

## addibiboxplot

:book: add a LICENSE.
:book: add a Code of Conduct.
:book: review and standardize documentation of arguments, *i.e.* always starts by a lower case letter, use
\code{}, every time a value is mentioned and \link{} anytime a function is mentioned.
:hammer: `frameit()` renamed `frameIt()` for the sack of naming consistency.
:hammer: `compassRose1()` and `compassRose2()` respectively renamed `compassRoseCardinal()` and `compassRose()`.
:hammer: `layout2()` renamed `interactiveLayout()` to better reflect what it does.
:hammer: In `pickColors()` the color of the text giving the characteristics of the
selected color depends on the current selection to improve readability.
:hammer: a new set of functions is introduced: `contrastColors` to easily contract colors
:shield: test for `darken` family functions.
:shield: test for `contrastColors` family functions.
:arrow_up: Switch to version 1.2-0.
