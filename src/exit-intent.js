import Elm from './elm/Main.elm';

class ExitIntent {
  constructor(modalContent = {}) {
    let parsedModalContent = this.parseContent(modalContent);

    const modal = Elm.Main.fullscreen();

    modal.ports.modalContent.send(modalContent);

    this.modal = modal;
  }

  parseContent(contentProps) {
    let parsedContentProps = contentProps;

    for(let prop in contentProps) {
      let currentProp = contentProps[prop];

      if (Object.keys(currentProp).includes('styles')) {
        parsedContentProps[prop].styles = this.mapStylesToArray(currentProp.styles);
      }
    }

    return parsedContentProps;
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
