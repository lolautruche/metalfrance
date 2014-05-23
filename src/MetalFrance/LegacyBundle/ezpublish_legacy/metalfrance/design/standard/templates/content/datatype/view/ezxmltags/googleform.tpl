{if or( is_unset( $width ), eq( $width, '' ) )}
    {def $width=614}
{/if}
{if or( is_unset( $height ), eq( $height, '' ) )}
    {def $height=700}
{/if}
{if $formEmbedUrl}
    {def $currentUser = fetch( 'user', 'current_user' )}
    {if $currentUser.is_logged_in}{set $formEmbedUrl = concat( $formEmbedUrl, '&amp;entry_0=', $currentUser.contentobject.name, '&amp;entry_1=', $currentUser.email )}{/if}
	<div class="embedded-google-form">
	   <iframe src="{$formEmbedUrl}" width="{$width}" height="{$height}" frameborder="0" marginheight="0" marginwidth="0">Loading...</iframe>
	</div>
{/if}