"use strict";

class HeaderUserControl extends React.Component {
    render() {
        if (this.props.user) {
            return [
                <a key="upload" className="header__button" href="/file/add">Upload</a>,
                <a key="user" className="header__button" href={"/user/" + this.props.user}>{this.props.user}</a>,
                <a key="logout" className="header__button" href="/logout">Log out</a>
            ];
        }

        return (
            <a className="header__button" href="/login">Login</a>
        );
    }
}

class Header extends React.Component {
    render() {
        return (
            <header className="header">
                <div className="header__logo">Simplepics</div>
                <div className="header__user-control">
                    <HeaderUserControl user={this.props.user} />
                </div>
            </header>
        );
    }
}