# ------------------------------------------------------------------
# TokenInput

$ ->
	$( '#post_tag_names' ).tokenInput( '/manage/tags.json', { crossDomain: false, allowCreation: true, theme: 'facebook', prePopulate: $( '#post_tag_names' ).data( 'pre' ) } )