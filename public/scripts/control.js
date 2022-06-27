"use strict"

class Control extends React.Component {
    constructor(props) {
        super(props)
        this.handleSizeChange = this.handleSizeChange.bind(this)
        this.slider = React.createRef()
    }

    handleSizeChange(e) {
        this.props.onSizeChange(this.calculateArea(this.slider.current.value))
    }

    componentDidMount() {
        this.handleSizeChange()
    }

    calculateArea(value) {
		var initialArea = 200000;
		var minp = 0;
		var maxp = 100;
		var minv = Math.log(0.1);
		var maxv = Math.log(3);

		var scale = (maxv - minv) / (maxp - minp)
		var o = Math.exp(minv + scale * (value - minp))

		return Math.round(initialArea * o)
	}

    render() {
        return (
            <section id="control">
                <span className="bold">Size</span>
                <div id="slider_container">
                    <input ref={this.slider} type="range" min="0" max="100" defaultValue="50" step="10" className="slider" id="size" onInput={() => this.handleSizeChange(this)}></input>
                </div>
                <article>
                    <span className="bold">Hits </span>{this.props.count}
                </article>
            </section>
        )
    }
}