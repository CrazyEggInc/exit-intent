# Exit intent

## Prerequisites

To install Elm follow these [steps](https://guide.elm-lang.org/install.html)

## Usage

* Define the critical parts of the exit intent modal:

  1. headline
  2. content
  3. actions
  4. image


  All this four keys are expected by the ExitIntent class to be passed.

  * `headline`, `content` and `image` are hashes (key-value) while `actions` is an array of hashes. Each hash can have the keys `styles` & `className` for all the previous keys.
  * `headline` & `content` must contain also the key `text` which value must be a string
  * actions must have the key `location` which will be the `href` for the action link.

Samples:

```
const headline = {
  text: 'Feeling lost?',
  className: '',
  styles: {}
};

content = {
  text: '',
  className: '',
  styles: {}
};

const actions = [
  {
    text: 'Take me to the Free Plan',
    location: 'https://google.com',
    styles: [
      ["box-shadow", "0px 2px 0px #00548C"],
      ["background-color", "#0086E6"]
    ]
  },
  {
    text: "I'm not interested",
    location: 'https://google.com',
    styles: [
      ["box-shadow", "0px 2px 0px #768EA1"],
      ["background-color", "#A2B9CA"]
    ]
  }
]

const image = {
  source: 'https://ww.crazyegg.com/assets/images/recordings/astronaut@2x.png',
  styles: {}
};

const modalContent = {
  headline: headline,
  content: content,
  actions: actions,
  image: image,
  globalConfig: {
    'font-family': 'proxima-nova',
    color: 'white',
    'background-color': '#0055B1',
    'background-image': 'url(https://www.crazyegg.com/assets/images/recordings/stars-lower.svg)'
  }
};

document.addEventListener('DOMContentLoaded', function() {
  // Create a new modal with content
  const modal = new ExitIntent(modalContent);

  modal.show();
});

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
