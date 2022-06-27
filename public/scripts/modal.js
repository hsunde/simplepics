class Modal extends React.Component {
    constructor(props) {
        super(props)
        this.handleHideFullscreen = this.handleHideFullscreen.bind(this)
    }

    handleHideFullscreen(e) {
        this.props.onHideFullscreen(e)
    }

    render() {
        if (!this.props.active) {
            return null;
        }

        return (
            <div id="modal" onClick={() => this.handleHideFullscreen(this)}>
                <img src={"get/" + this.props.src}></img>
                <video autoPlay muted loop playsInline></video>
            </div>
        )
    }
}