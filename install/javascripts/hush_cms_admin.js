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


Event.observe(window, 'load', function() {
	// Make children of elements marked .hoverable aquire .hover on :hover
	$$('.hoverable > *').each(function (e) {
		console.log(e);
		
		Event.observe(e, 'mouseover', function() {
		  Element.addClassName(e, 'hover');
		});  
		
		Event.observe(e, 'mouseout', function() {  
		  Element.removeClassName(e, 'hover');  
		});
	});
});