# ------------------------------------------------------------------
# TokenInput

$ ->
	$( '#post_tag_names' ).tokenInput( '/manage/tags.json', { crossDomain: false, allowNewItems: true, prePopulate: $( '#post_tag_names' ).data( 'pre' ) } )