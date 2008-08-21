function markInputsWithErrors(name, messages) {
	console.log(messages);
	
	$$('.fieldWithErrors input').each(function (input) {
		input.parentNode.appendChild(createErrorDiv(messages[input.id.gsub(name + '_', '')]));
	});
}

function createErrorDiv(message) {
	var div = document.createElement('div');
	div.addClassName('input-error');
	div.innerHTML = message;
	div.style.display = 'none';
	div.appear();
	return div;
}
