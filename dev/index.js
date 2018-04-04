const actions = [
  {text: 'Yes Please!', location: 'https://google.com', track: false},
  {text: 'Yes Please!', location: 'https://google.com', track: false}
];

const content = {
  headline: 'hello',
  subHeadline: 'Uruuay',
  actions: actions,
  image: null
};

document.addEventListener('DOMContentLoaded', function() {
  const modal = new ExitIntent(content);

  modal.show();
});
