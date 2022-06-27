var SIMPLEPICS = SIMPLEPICS || {};
SIMPLEPICS.upload = function(e) {
	var sequence = document.querySelector('#upload_sequence').checked
	var tags = document.querySelector('#upload_tags').value
	var data = new FormData()

	data.append('tags', tags);
	data.append('sequence', sequence);

	Array.from(e.files).forEach(function(file, i) {
		data.append('files[]', file);
	})

	fetch('/upload', {
		method: 'POST',
		body: data
	})
}