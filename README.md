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
* `yarn install`

## Running

Run `yarn run start`, this will boot a development server that compiles the library and makes it available at `http://localhost:8080/exit-intent.js`

## Build
`ExitIntent` is distributed as a NPM package. Run `yarn run build` to build a new version of the library. Commit and push the change, then update the projects that use `ExitIntent`.

## Further Reading / Useful Links

* [elm guides](https://guide.elm-lang.org/)
