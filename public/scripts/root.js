'use strict'

class Root extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            files: [],
            show_modal: false,
            modal_src: null,
            area: null,
            page: 1,
            user: null
        }

        this.perPage = 20;

        this.handleFilterChange = this.handleFilterChange.bind(this);
        this.handleFullscreen = this.handleFullscreen.bind(this);
        this.handleHideFullscreen = this.handleHideFullscreen.bind(this);
        this.handleSizeChange = this.handleSizeChange.bind(this);
        this.handlePageChange = this.handlePageChange.bind(this);
    }

    componentDidMount() {
        fetch("/username")
        .then(result => result.text())
        .then(result => {
            this.setState({
                user: result
            })
        })
    }

    handlePageChange(e) {
        this.setState({
            page: e.props.page
        })
    }

    handleSizeChange(area) {
        this.setState({
            area: area
        })
    }

    handleFilterChange(files) {
        this.setState({
            files: files,
            page: 1
        })
    }

    handleFullscreen(e) {
        this.setState({
            show_modal: !this.state.show_modal,
            modal_src: e.props.hash
        })
    }

    handleHideFullscreen(e) {
        this.setState({
            show_modal: false
        })
    }

    render() {
        return (
            <div>
                <Modal active={this.state.show_modal} src={this.state.modal_src} onHideFullscreen={this.handleHideFullscreen} />
                <Header user={this.state.user} />
                <Filter onFilterChange={this.handleFilterChange} />
                <Control count={this.state.files.length} onSizeChange={this.handleSizeChange} />
                <Content area={this.state.area} files={this.state.files} page={this.state.page} perPage={this.perPage} onFullscreen={this.handleFullscreen} />
                <Pages perPage={this.perPage} count={this.state.files.length} currentPage={this.state.page} onPageChange={this.handlePageChange} />
            </div>
        )
    }
}

const rootContainer = document.querySelector("#root")
const root = ReactDOM.createRoot(rootContainer);
root.render(<Root />);