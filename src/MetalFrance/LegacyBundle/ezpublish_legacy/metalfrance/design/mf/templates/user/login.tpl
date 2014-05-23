<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="attribute-header">
    <a id="loginForm"></a>
    <h2 class="mf-title mf-noicon">{"Connexion à Metal France"|i18n( "extension/metalfrance/user" )}</h1>
</div>

<div class="user-login mf-body">

  <form method="post" action={"/user/login/"|ezurl} name="loginform">
	
	<div class="attribute-header mf-top">
	    {*<h3 class="long">{"Connectez-vous depuis votre réseau social préféré"|i18n("extension/metalfrance/user")}</h3>*}
	</div>
	{include uri="design:janrain/embeddedscript.tpl"}
	
	{if $User:warning.bad_login}
	<div class="warning">
	<h3>{"Could not login"|i18n("design/ezwebin/user/login")}</h3>
	<ul>
	    <li>{"A valid username and password is required to login."|i18n("design/ezwebin/user/login")}</li>
	</ul>
	</div>
	{else}
	
	{if $site_access.allowed|not}
	<div class="warning">
	<h3>{"Access not allowed"|i18n("design/ezwebin/user/login")}</h3>
	<ul>
	    <li>{"You are not allowed to access %1."|i18n("design/ezwebin/user/login",,array($site_access.name))}</li>
	</ul>
	</div>
	{/if}
	
	{/if}
	
	<div class="attribute-header mf-top">
	    <h3>{"Utiliser un compte classique (nécessite une inscription)"|i18n( "extension/metalfrance/user" )}</h3>
	</div>
	
	<div class="block">
		<label for="id1">{"Pseudo ou adresse mail"|i18n( "extension/metalfrance/user" )} :</label><div class="labelbreak"></div>
		<input class="halfbox mf-input" type="text" size="10" name="Login" id="id1" value="{$User:login|wash}" tabindex="1" />
	</div>
	
	<div class="block">
		<label for="id2">{"Password"|i18n("design/ezwebin/user/login")} :</label><div class="labelbreak"></div>
		<input class="halfbox mf-input" type="password" size="10" name="Password" id="id2" value="" tabindex="1" />
	</div>
	{if ezini( 'SiteSettings', 'AdditionalLoginFormActionURL' )}
	<div class="block">
		<label for="id3">{"Log in to the eZ Publish Administration Interface"|i18n("design/ezwebin/user/login")}</label><div class="labelbreak"></div>
		<input type="checkbox" size="10" name="AdminSiteaccessURI" id="id3" value="" tabindex="1" onclick="AdminSiteaccessCheckbox(this);" />
	</div>
	
	{*
	    Set URL for login form action
	    site.ini.[SiteSettings].AdditionalLoginFormActionURL
	    If empty then checkbox will not appear
	*}
	<script type="text/javascript">
	<!--
	
	var loginForm = document.loginform;
	var loginFormDefaultAction = loginForm.action;
	
	function AdminSiteaccessCheckbox( val )
	{ldelim}
	
	    if( val.checked )
	        loginForm.action = '{ezini( 'SiteSettings', 'AdditionalLoginFormActionURL' )}';
	    else 
	        loginForm.action = loginFormDefaultAction;
	
	{rdelim} 
	
	-->
	</script>
	{/if}
	{if ezini( 'Session', 'RememberMeTimeout' )}
	<div class="block">
	    <input type="checkbox" tabindex="1" name="Cookie" id="id4" /><label for="id4" style="display:inline;">{"Remember me"|i18n("design/ezwebin/user/login")}</label>
	</div>
	{/if}
	
	<div class="buttonblock">
	    <input class="defaultbutton mf-button" type="submit" name="LoginButton" value="{'Connexion'|i18n( 'extension/metalfrance/user' )}" tabindex="1" />
	{if ezmodule( 'user/register' )}
	    <input class="button mf-button" type="submit" name="RegisterButton" id="RegisterButton" value="{"S'inscrire"|i18n( 'extension/metalfrance/user' )}" tabindex="1" />
	{/if}
	</div>
	
    <p><a href={'/user/forgotpassword'|ezurl}>{'Forgot your password?'|i18n( 'design/ezwebin/user/login' )}</a></p>
	
	{def $redirectURI = $User:redirect_uri|wash
	     $referer = server( 'http_referer' )
	     $siteDomain = str_replace( 'www', '', ezini( 'SiteSettings', 'SiteURL' ) )}
	{if and( $redirectURI|not, $referer|contains( $siteDomain ) )}{set $redirectURI = $referer}{/if}
	<input type="hidden" name="RedirectURI" value="{$redirectURI|wash}" />
	
	{if and( is_set( $User:post_data ), is_array( $User:post_data ) )}
	  {foreach $User:post_data as $key => $postData}
	     <input name="Last_{$key}" value="{$postData}" type="hidden" /><br/>
	  {/foreach}
	{/if}

  </form>

</div>
<script type="text/javascript">document.location = document.location + '#loginForm';</script>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>