import Elm from './elm/Main.elm';

class ExitIntent {
  constructor(modalContent = {}) {

    const modal = Elm.Main.fullscreen();

    modal.ports.modalContent.send(modalContent);

    this.modal = modal;
  }

  show() {
    this.modal.ports.modalVisible.send(true);
  }

  hide() {
    this.modal.ports.modalVisible.send(false);
  }
}

export default ExitIntent;
