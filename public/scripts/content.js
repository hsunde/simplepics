"use strict"

class ContentMedia extends React.Component {
    constructor(props) {
        super(props)
        this.id = this.props.hash
        this.handleFullscreen = this.handleFullscreen.bind(this)
    }

    handleFullscreen(e) {
        this.props.onFullscreen(e)
    }

    render() {
		const ratio = parseInt(this.props.x) / parseInt(this.props.y);
		const sqrt = Math.sqrt(this.props.area);

        const x = Math.round(sqrt * ratio);
		const margin = Math.round(sqrt / 50);
		const radius = Math.round(sqrt / 50);

        return (
            <article className="content">
                <section className="media">
                    <img className="media_content" src={"/thumb/" + this.props.hash} style={{width: x, margin: margin, borderRadius: radius}} onClick={() => this.handleFullscreen(this)}></img>
                </section>
                <section className="info"></section>
            </article>
        )
    }
}

class Content extends React.Component {
    render() {
        const fileElements = []
        const files = this.props.files.slice(this.props.perPage * (this.props.page - 1), this.props.perPage * (this.props.page - 1) + this.props.perPage)
        files.forEach((f) => {
            fileElements.push(
                <ContentMedia 
                    key={f["id"]} 
                    type={f["type"]} 
                    hash={f["hash"]}
                    x={f["x"]}
                    y={f["y"]}
                    onFullscreen={this.props.onFullscreen}
                    area={this.props.area}
                />
            )
        })

        return (
            <main>
                {fileElements}
            </main>
        )
    }
}