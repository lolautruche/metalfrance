<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc">


<div class="attribute-header">
<h1 class="long mf-title mf-noicon">{"Change password for user"|i18n("design/ezwebin/user/password")} <em>{$userAccount.login}</em></h1>
</div>

<div class="mf-body user-login">

    <div class="mf-top"></div>

	<form action={concat($module.functions.password.uri,"/",$userID)|ezurl} method="post" name="Password">
	
	{if $message}
	{if or( $oldPasswordNotValid, $newPasswordNotMatch, $newPasswordTooShort )}
	    {if $oldPasswordNotValid}
	        <div class="warning">
	            <h2>{'Please retype your old password.'|i18n('design/ezwebin/user/password')}</h2>
	        </div>
	    {/if}
	    {if $newPasswordNotMatch}
	        <div class="warning">
	            <h2>{"Password didn't match, please retype your new password."|i18n('design/ezwebin/user/password')}</h2>
	        </div>
	    {/if}
	    {if $newPasswordTooShort}
	        <div class="warning">
	            <h2>{"The new password must be at least %1 characters long, please retype your new password."|i18n( 'design/ezwebin/user/password','',array( ezini('UserSettings','MinPasswordLength') ) )}</h2>
	        </div>
	    {/if}
	
	{else}
	    <div class="feedback">
	        <h2>{'Password successfully updated.'|i18n('design/ezwebin/user/password')}</h2>
	    </div>
	{/if}
	
	{/if}
	
	<table>
	  <tr>
		<td>
			{if $oldPasswordNotValid}*{/if}
			<label for="oldPassword">{"Old password"|i18n("design/ezwebin/user/password")}</label>
		</td>
		<td>
		    <input class="mf-input" type="password" name="oldPassword" id="oldPassword" size="11" value="{$oldPassword|wash}" />
		</td>
	  </tr>
		
	  <tr>
		<td>
			{if $newPasswordNotMatch}*{/if}
			<label for="newPassword">{"New password"|i18n("design/ezwebin/user/password")}</label>
		</td>
		<td>
			<input class="mf-input" type="password" name="newPassword" id="newPassword" size="11" value="{$newPassword|wash}" />
		</td>
	  </tr>
	  <tr>
	    <td>
			{if $newPasswordNotMatch}*{/if}
			<label for="confirmPassword">{"Retype password"|i18n("design/ezwebin/user/password")}</label>
		</td>
		<td>
			<input class="mf-input" type="password" name="confirmPassword" id="confirmPassword" size="11" value="{$confirmPassword|wash}" />
		</td>
	  </tr>
	</table>
	<div class="break"></div>
	
	<div class="buttonblock">
	<input class="defaultbutton" type="submit" name="OKButton" value="{'OK'|i18n('design/ezwebin/user/password')}" />
	<input class="button" type="submit" name="CancelButton" value="{'Cancel'|i18n('design/ezwebin/user/password')}" />
	</div>
	
	</form>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>