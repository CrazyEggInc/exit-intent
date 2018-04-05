// TODO
// - Refactor Elm to allow external styles (Chris)
// - Create set of modal items  (Fabian)
// - Refactor Wrapper to convert Object/Hash to Array [Key Value] pairs for styles (Fabian)
// - Create event ports that wrapper can listen for based on action taken (Chris)

// Next Step

// const actions = [
//   {text: 'Take me to the Free Plan', location: 'https://google.com', styles: {}, className: 'CTA-1'},
//   {text: "I'm not interested", location: 'https://google.com', styles: {}}
// ];

// const image = {
//   source: 'https://www.crazyegg.com/assets/images/recordings/astronaut@2x.png',
//   styles: {}
// };

// const modalContent = {
//   headline: {
//     text: "Hi",
//     className: "",
//     styles: {}
//   },
//   content: {
//     text: "I am the body.",
//     className: "",
//     styles: {}
//   },
//   actions: actions,
//   image: image,
//   backgroundImage: backgroundImage,
//   globalStyles: {}
// }

// const modal = new ExitIntent(modalContent);

// modal.addEventListener('closed', function (event) {
//   $.ajax('/metrics');
// });

// modal.addEventListener('actionTaken', function (event) {
//   $.ajax('/metrics');
//   navigator.location = event.location;
// });

// document.addEventListener('DOMContentLoaded', function() {
//   const modal = new ExitIntent(content);
//
//   modal.show();
// });


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
];

const image = {
  source: 'https://www.crazyegg.com/assets/images/recordings/astronaut@2x.png',
  styles: {
    width: '10px',
    height: '15px'
  }
};

const headline = {
  text: 'Feeling lost?',
  className: "",
  styles: {}
};

content = {
  text: 'Not sure which plan to pick? Try our Free Plan to get a taste of what Crazy Egg has to offer and see how we can improve your website, instantly.No credit card required.',
  className: "",
  styles: {}
};


const modalContent = {
  headline: headline,
  content: content,
  actions: actions,
  image: image,
  globalStyles: {
    'font-family': 'proxima-nova',
    color: 'white',
    'background-color': '#0055B1',
    'background-image': 'url(https://www.crazyegg.com/assets/images/recordings/stars-lower.svg)'
  }
};

document.addEventListener('DOMContentLoaded', function() {
  const modal = new ExitIntent(modalContent);

  modal.show();
});
