# ------------------------------------------------------------------
# Page Preview Functions

preview_in_colorbox = (content) -> 
	$.colorbox({ html: content, transition: 'fade', width: 960, height: '100%' })

# ------------------------------------------------------------------
# Page Preview Events

$ ->

	# POST /page/preview with the content field's current value and preview
	# the returned HTML.
	$( 'a#page_preview' ).click( () ->
		textile_content = $( '#page_content' ).val()

		$.ajax({
			type: 		"POST"
			url: 			'/manage/page/preview'
			data: 		{ textile_content: textile_content }
			dataType: 'json'
			success:  (converted) -> preview_in_colorbox( converted.content )
		}) 
	)

# ------------------------------------------------------------------
# Page Content Textile Helper Functions

# Add a Textile-formatted image link to the content field with the given image link.
appendImageLink = (image_link) ->
	field = $( '#page_content' )
	field.val( field.val() + "!" + image_link + "!" )

# Adds Insert links to /images/index.html.
addInsertLinks = () ->
	# Hide heading links.
	$( '.heading_links' ).hide()
	
	$( '.image' ).each( (index) ->
		# Get the image's original URL from the data-original attribute of the image.
		image_source = $( this ).children( 'img' ).attr( 'data-original' )
		
		# Create a dynamic Insert link using the URL.
		insert_link = '<a class="insert_link" href="' + image_source + '">Insert</a>'
		
		# Replace the image's Delete link with the dynamic Insert link.
		$( this ).children( '.links' ).children( '.delete' ).replaceWith( insert_link )
	)
	
	# Add a click event which will close the Colorbox and
	# append the URL to the page content field.
	$( 'a.insert_link' ).click( () ->
		appendImageLink( $( this ).attr( 'href' ) )
		$.fn.colorbox.close()
		return false
	)

# ------------------------------------------------------------------
# Page Content Textile Helper Events

$ ->
	
	# Replace Insert Image link, since this function doesn't work without JS.
	$( 'a#insert_image' ).attr( 'href', '/manage/images' )
	$( 'a#insert_image' ).colorbox({ width: 980, height: '100%', onComplete: () -> addInsertLinks() })