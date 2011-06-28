# Page Functions

preview_in_colorbox = (content) -> 
	$.colorbox({ html: content, transition: 'fade', width: 960, height: '100%' })

# Page Events

$ ->
	$( 'a#page_preview' ).click( () ->
		textile_content = $( '#page_content' ).val()
		
		$.ajax({
			type: 		"POST"
			url: 			'/page/preview'
			data: 		{ textile_content: textile_content }
			dataType: 'json'
			success:  (converted) -> preview_in_colorbox( converted.content )
		}) 
	)
	
	

	