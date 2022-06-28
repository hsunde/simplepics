"use strict";

class PageButton extends React.Component {
    constructor(props) {
        super(props);
        this.handlePageChange = this.handlePageChange.bind(this);
    }

    handlePageChange(e) {
        this.props.onPageChange(e);
    }

    render() {
        return (
            <article className={"pages__button" + (this.props.active ? " pages__button--active" : "")} onClick={() => this.handlePageChange(this)}>
                {this.props.page}
            </article>
        );
    }
}

class Pages extends React.Component {
    render() {
        const pageCount = Math.ceil(this.props.count / this.props.perPage);

        if (this.props.count == 0 || pageCount == 1) {
            return null;
        }

        // const pageCount = Math.ceil(this.props.count / this.props.perPage);
        const pageElements = [];
        for (let i = 1; i <= pageCount; i++) {
            pageElements.push(
                <PageButton key={i} page={i} active={this.props.currentPage == i} onPageChange={this.props.onPageChange} />
            );
        }

        return (
            <section className="pages">
                {pageElements}
            </section>            
        );
    }
}