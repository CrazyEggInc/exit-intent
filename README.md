# Exit intent

## Prerequisites

To install Elm follow these [steps](https://guide.elm-lang.org/install.html)

## Usage

```
// Create a new modal with content
var modal = new ExitIntent({});

// Show modal
model.show();

// Hide modal
model.hide();

// Listen for events
model.on('close', function() {
  // Code
});
```


## Installation

* `git clone https://github.com/CrazyEggInc/exit-intent.git`
* `cd exit-intent`

## Running

* compile with `elm-make ExitIntent.elm --output=dist/exit_intent.js`
  and open `index.html`

  or

* run `elm-reactor`
  and open `localhost:8000/index.html`

## Further Reading / Useful Links

* [elm guides](https://guide.elm-lang.org/)
