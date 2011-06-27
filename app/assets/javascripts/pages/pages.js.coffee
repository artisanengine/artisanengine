$ ->
	$( 'a#page_preview' ).click( () ->
		field_text = $( '#page_content' ).val()
		
		$.ajax({
			type: 		"POST"
			url: 			'/preview'
			data: 		{ page_content: field_text }
			dataType: 'script' 
		}) 
	)
	