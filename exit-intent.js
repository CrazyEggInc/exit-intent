document.addEventListener("DOMContentLoaded", function (event) {
  const modal = Elm.Main.fullscreen();
  const actions = [
    { text: 'Stay!', location: 'https://google.com', track: false },
    { text: 'Take me out, please', location: 'https://google.com', track: false }
  ];

  const content = {
    headline: "This is awesome!",
    subHeadline: "Some awesome sub-headline.",
    actions: actions,
    image: null
  };

  modal.ports.modalContent.send(content);

  document.addEventListener('mouseleave', function (event) {
    modal.ports.modalVisible.send(true);
  });
});
