# ------------------------------------------------------------------
# TokenInput

$ ->
	token_preferences = {
		crossDomain: 	 false 
		allowCreation: true 
		theme: 				 'facebook'
		prePopulate: 	 $( '#post_tag_names' ).data( 'pre' )
	}
	
	$( '#post_tag_names' ).tokenInput( '/manage/tags.json', token_preferences )