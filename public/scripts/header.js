class HeaderUserControl extends React.Component {
    render() {
        if (this.props.user) {
            return [
                <a key="upload" href="/upload">Upload</a>,
                <a key="user" href={"/user/" + this.props.user}>{this.props.user}</a>,
                <a key="logout" href="/logout">Log out</a>
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
                <div id="logo">Simplepics</div>
                <div id="usercontrol">
                    <HeaderUserControl user={this.props.user} />
                </div>
            </header>
        )
    }
}