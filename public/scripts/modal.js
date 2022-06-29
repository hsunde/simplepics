"use strict";

class Modal extends React.Component {
    constructor(props) {
        super(props);
    }

    handleHideFullscreen(e) {
        this.props.onHideFullscreen(e);
    }

    render() {
        if (!this.props.active) {
            return null;
        }

        return (
            <div className="modal" onClick={() => this.handleHideFullscreen()}>
                <img className="modal__media" src={"/file/get/" + this.props.src}></img>
                <video className="modal__media" autoPlay muted loop playsInline></video>
            </div>
        );
    }
}