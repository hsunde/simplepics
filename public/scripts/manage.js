var SIMPLEPICS = SIMPLEPICS || {};
SIMPLEPICS.manage = {
	activate: function(category) {
		var form = document.querySelector('form');
		form.setAttribute('tag', category)
		form.querySelector('input[type="text"]').setAttribute('placeholder', category);
	},

	change: function(e) {
		// event.preventDefault();
		var tag = e.getAttribute('tag');
		input = e.querySelector('input[type="text"]');
	
		var data = new FormData();
		data.append('tag', tag);
		data.append('category', input.value);
	
		fetch('/admin/tags/change', {
			method: 'POST',
			body: data
		}).then(function(r) {
			location = "/admin/tags";
		})
	}
}