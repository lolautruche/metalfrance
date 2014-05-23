<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<form action={concat($module.functions.edit.uri,"/",$userID)|ezurl} method="post" name="Edit">

<div class="attribute-header">
  <h2 class="long mf-title mf-noicon">{"Mon profil"|i18n( "extension/metalfrance/user" )}</h2>
</div>

<div class="user-edit mf-body">
	
	<div class="attribute-header mf-top"></div>
	{def $user = fetch( 'user', 'current_user' )}
	
	{content_view_gui content_object=$user.contentobject view="full"}

</div>

</form>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>