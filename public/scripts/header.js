class HeaderUserControl extends React.Component {
    render() {
        if (this.props.user) {
            return [
                <a key="upload" class="button" href="/upload">Upload</a>,
                <a key="user" class="button" href={"/user/" + this.props.user}>{this.props.user}</a>,
                <a key="logout" class="button" href="/logout">Log out</a>
            ]
        }

        return (
            <a href="/login">Login</a>
        )
    }
}

class Header extends React.Component {
    render() {
        return (
            <header>
                <div className="f24 semibold">Simplepics</div>
                <div id="user_control" className="f18 semibold">
                    <HeaderUserControl user={this.props.user} />
                </div>
            </header>
        )
    }
}