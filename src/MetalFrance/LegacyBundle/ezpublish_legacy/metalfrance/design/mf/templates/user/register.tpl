<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="attribute-header">
    <a id="loginForm"></a>
    <h2 class="mf-title mf-noicon">{"Inscription"|i18n( "extension/metalfrance/user" )}</h2>
</div>

<div class="user-register user-edit mf-body">

	<div class="mf-top">
	  <h3 class="long">{"Connectez-vous depuis votre réseau social préféré :"|i18n("extension/metalfrance/user")}</h3>
	  {include uri="design:janrain/embeddedscript.tpl"}

	  <p>&nbsp;</p>
	  <h3 class="long">{"Ou créez un compte :"}</h3>
      <form enctype="multipart/form-data"  action={"/user/register/"|ezurl} method="post" name="Register">

		{if and( and( is_set( $checkErrNodeId ), $checkErrNodeId ), eq( $checkErrNodeId, true() ) )}
		    <div class="message-error">
		        <h3><span class="time">[{currentdate()|l10n( shortdatetime )}]</span> {$errMsg}</h3>
		    </div>
		{/if}

		{if $validation.processed}

		    {if $validation.attributes|count|gt(0)}
		        <div class="warning">
		        <h3>{"Input did not validate"|i18n("design/ezwebin/user/register")}</h3>
		        <ul>
		        {foreach $validation.attributes as $attribute}
		            <li>{$attribute.name}: {$attribute.description}</li>
		        {/foreach}
		        </ul>
		        </div>
		    {else}
		        <div class="feedback">
		        <h3>{"Input was stored successfully"|i18n("design/ezwebin/user/register")}</h3>
		        </div>
		    {/if}

		{/if}

		{if count($content_attributes)|gt(0)}
		  {def $attributesToEdit = ezini( 'UserSettings', 'ProfileFieldsMFUser', 'metalfrance.ini' )}
          {set $attributesToEdit = $attributesToEdit|append( 'captcha' )}
		  {foreach $content_attributes as $attribute}
		    {if $attributesToEdit|contains( $attribute.contentclass_attribute_identifier )}
		    <div class="block">
		      {if $attribute.display_info.edit.grouped_input}
	            <fieldset>
	                <legend{if $attribute.has_validation_error} class="message-error"{/if}>
	                    {$attribute.contentclass_attribute.name|wash}{if $attribute.is_required}<span class="required">*</span>{/if}
	                </legend>
	                {attribute_edit_gui attribute=$attribute view_parameters=$view_parameters}
	                <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
	            </fieldset>
	          {else}
	            <label{if $attribute.has_validation_error} class="message-error"{/if}>
	                {$attribute.contentclass_attribute.name|wash}{if $attribute.is_required}<span class="required">*</span>{/if}:
	            </label>
	            {attribute_edit_gui attribute=$attribute view_parameters=$view_parameters}
	            <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
	          {/if}
		    </div>
		    {/if}
		  {/foreach}

		    <div class="buttonblock">
		         <input class="button" type="hidden" name="UserID" value="{$content_attributes[0].contentobject_id}" />
		    {if and( is_set( $checkErrNodeId ), $checkErrNodeId )|not()}
		        <input class="button" type="submit" id="PublishButton" name="PublishButton" value="{'Register'|i18n('design/ezwebin/user/register')}" onclick="window.setTimeout( disableButtons, 1 ); return true;" />
		    {else}
		           <input class="button" type="submit" id="PublishButton" name="PublishButton" disabled="disabled" value="{'Register'|i18n('design/ezwebin/user/register')}" onclick="window.setTimeout( disableButtons, 1 ); return true;" />
		    {/if}
		    <input class="button" type="submit" id="CancelButton" name="CancelButton" value="{'Discard'|i18n('design/ezwebin/user/register')}" onclick="window.setTimeout( disableButtons, 1 ); return true;" />
		    </div>
		{else}
		    <div class="warning">
		         <h3>{"Unable to register new user"|i18n("design/ezwebin/user/register")}</h3>
		    </div>
		    <input class="button" type="submit" id="CancelButton" name="CancelButton" value="{'Back'|i18n('design/ezwebin/user/register')}" onclick="window.setTimeout( disableButtons, 1 ); return true;" />
		{/if}
	  </form>
	</div>

</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>

{literal}
<script type="text/javascript">
<!--
    function disableButtons()
    {
        document.getElementById( 'PublishButton' ).disabled = true;
        document.getElementById( 'CancelButton' ).disabled = true;
    }
-->
</script>
<script type="text/javascript">document.location = document.location + '#loginForm';</script>
{/literal}
