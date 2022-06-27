'use strict';

class FilterActiveTag extends React.Component {
	constructor(props) {
		super(props)
		this.handleFilterTagRemove = this.handleFilterTagRemove.bind(this)
	}

	handleFilterTagRemove(e) {
		this.props.onFilterTagRemove(e)
	}

	render() {
		return (
			<span>
				<span>{this.props.operator}</span>
				<span onClick={() => this.handleFilterTagRemove(this)}> {this.props.tag}</span>
			</span>
		)
	}
}

class FilterOperator extends React.Component {
	constructor(props) {
		super(props)
		this.handleOperatorChange = this.handleOperatorChange.bind(this)
	}

	handleOperatorChange(e) {
		this.props.onOperatorChange(e)
	}

	render() {
		return (
			<div operator={this.props.operator} className={(this.props.active ? "active" : "")} onClick={() => this.handleOperatorChange(this)}>{this.props.operator}</div>
		)
	}
}

class FilterTagCategory extends React.Component {
	render() {
		const tags = []
		const onFilterTagAdd = this.props.onFilterTagAdd
		const active_tags = this.props.active_tags

		this.props.tags.forEach(function(tag) {
			tags.push(
				<FilterTag key={tag["name"]} tag={tag["name"]} active={tag["name"] in active_tags} onFilterTagAdd={onFilterTagAdd}/>
			)
		})
	
		return  (
			<section className="tagCategory">
				<div className="header">{this.props.name}</div>
				<section className="availableTags">
					{tags}
				</section>
			</section>
		)
	}
}

class FilterTag extends React.Component {
	constructor(props) {
		super(props)
		this.handleFilterTagAdd = this.handleFilterTagAdd.bind(this)
	}

	handleFilterTagAdd(e) {
		this.props.onFilterTagAdd(e)
	}

	render() {
		return (
			<div className={"filterTag" + (this.props.active ? " active" : "")} onClick={() => this.handleFilterTagAdd(this)}>
				{this.props.tag}
			</div>
		)
  }
}

class Filter extends React.Component {
	constructor(props) {
		super(props)
		this.state = {
			tags: null,
			active_tags: {},
			operator: "or",
		}

		this.operators = ["or", "and", "not"]

		this.handleFilterTagAdd = this.handleFilterTagAdd.bind(this)
		this.handleFilterTagRemove = this.handleFilterTagRemove.bind(this)
		this.handleFilterChange = this.handleFilterChange.bind(this)
		this.handleOperatorChange = this.handleOperatorChange.bind(this)

		fetch("/test/tags")
		.then(result => result.json())
		.then(result => {
			this.setState(
				{tags: result}
			)
		})
	}

	handleOperatorChange(e) {
		this.setState(
			{operator: e.props.operator},
		)
	}

	handleFilterTagAdd(e) {
		const new_active_tags = {...this.state.active_tags, [e.props.tag]: this.state.operator}
		this.handleFilterChange(new_active_tags)
	}

	handleFilterTagRemove(e) {
		const new_active_tags = {...this.state.active_tags}
		delete new_active_tags[e.props.tag]

		this.handleFilterChange(new_active_tags)
	}

	handleFilterChange(new_state) {
		this.setState({
				active_tags: new_state
			}, () => {
				this.get(this.state.active_tags)
			})
	}

	componentDidMount() {
		this.get(this.state.active_tags)
	}

	get(tags) {
        var data = new FormData();
		data.append('active', JSON.stringify(tags));
	
		fetch('/filter', {
			method: 'POST',
			body: data
		})
        .then(result => result.json())
        .then(result => {
            // this.setState({
            //     files: result
            // })
			this.props.onFilterChange(result)
		})


		// var data = new FormData();
		// data.append('active', JSON.stringify(tags));
	
		// fetch('/filter', {
		// 	method: 'POST',
		// 	body: data
		// }).then(function(response) {
		// 	return response.text()
		// })
		// .then(function(html) {
		// 	document.querySelector('main').innerHTML = html;		
		// 	SIMPLEPICS.next(1);
		// })
	}

	render() {
		// wait for fetch to get available tags
		if (!this.state.tags) {
			return null;
		}

		const categoryElements = []
		for (const [category, tags] of Object.entries(this.state.tags)) {
			categoryElements.push(
				<FilterTagCategory name={category} key={category} tags={tags} active_tags={this.state.active_tags} onFilterTagAdd={this.handleFilterTagAdd} />
			)
		}

		const operatorElements = []
		this.operators.forEach(o => {
			operatorElements.push(
				<FilterOperator key={o} operator={o} onOperatorChange={this.handleOperatorChange} active={o == this.state.operator} />
			)
		});

		const activeTagElements = []
		if (Object.keys(this.state.active_tags).length > 0) {
			for (const [tag, operator] of Object.entries(this.state.active_tags)) {
				activeTagElements.push(
					<FilterActiveTag key={tag} tag={tag} operator={operator} onFilterTagRemove={this.handleFilterTagRemove} />
				)
			}
		} else {
			activeTagElements.push(<span className="filter--header" key="header">No filters</span>)
		}

		return (
			<nav>
				<section id="current_filters">
					{activeTagElements}
				</section>
				<div className="operators">
					{operatorElements}
				</div>
				{categoryElements}
			</nav>
		)
	}
}