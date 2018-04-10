import Elm from './elm/Main.elm';

class ExitIntent {
  constructor(modalContent = {}) {
    let parsedModalContent = this.parseContent(modalContent);

    const modal = Elm.Main.fullscreen();

    modal.ports.modalContent.send(parsedModalContent);

    this.modal = modal;
  }

  actionEvent(eventHandler) {
    this.modal.ports.actionEvent.subscribe(eventHandler);
  }

  didMount(eventHandler) {
    this.modal.ports.closeEvent.subscribe(eventHandler);
  }

  parseContent(contentProps) {
    for (let prop in contentProps) {
      let currentProp = contentProps[prop];

      if (Array.isArray(currentProp)) {
        for (let item in currentProp) {
          // currentProp[item] is a hash of style properties
          item = this.parseHashContent(currentProp[item]);
        }
      } else {
        currentProp = this.parseHashContent(currentProp);
      }
    }

    return contentProps;
  }

  parseHashContent(hash) {
    if (Object.keys(hash).includes('styles')) {
      hash.styles = this.mapStylesToArray(hash.styles);
    }

    return hash;
  }

  // -> styles: { width: '10px;', height: '20px;' }
  // <- [ ["width" , "10px"], ["height", "20px"] ]
  mapStylesToArray(props) {
    let result = [];

    Object.keys(props).forEach(function (prop) {
      if (Object.keys(prop).length !== 0) {
        result.push([prop, props[prop]]);
      }
    });

    return result;
  }

  show() {
    this.modal.ports.modalVisible.send(true);
  }

  hide() {
    this.modal.ports.modalVisible.send(false);
  }
}

export default ExitIntent;
