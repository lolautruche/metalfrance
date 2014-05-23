<div class="attribute-header">
  <h2 class="long mf-title mf-noicon">{"Mon profil"|i18n( "extension/metalfrance/user" )}</h2>
</div>

{def $attributesToEdit = ezini( 'UserSettings', 'ProfileFieldsMFUser', 'metalfrance.ini' )}
<div class="mf-body">
  <form enctype="multipart/form-data" method="post" action={concat( '/content/edit/', $object.id, '/', $edit_version, '/', $edit_language|not|choose( concat( $edit_language, '/' ), '/' ), $is_translating_content|not|choose( concat( $from_language, '/' ), '' ) )|ezurl}>
    <div class="user-edit">
        {include uri='design:content/edit_validation.tpl'}

      {foreach $attributesToEdit as $field}
        {def $attribute = $object.data_map[$field]}
        <div class="block">
          {if $attribute.display_info.edit.grouped_input}
            <fieldset>
	            <legend{if $attribute.has_validation_error} class="message-error"{/if}>
	                {$attribute.contentclass_attribute.name|wash}{if $attribute.is_required}<span class="required">*</span>{/if}
	            </legend>
	            {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters}
	            <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
            </fieldset>
          {else}
            <label{if $attribute.has_validation_error} class="message-error"{/if}>
                {$attribute.contentclass_attribute.name|wash}{if $attribute.is_required}<span class="required">*</span>{/if}:
            </label>
            {attribute_edit_gui attribute=$attribute attribute_base=$attribute_base view_parameters=$view_parameters}
            <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
          {/if}
        </div>
        {undef $attribute}
      {/foreach}
        
        <div class="buttonblock">
		    <input class="defaultbutton" type="submit" name="PublishButton" value="{'Enregistrer'|i18n( 'extension/metalfrance/user' )}" />
		    <input class="button" type="submit" name="DiscardButton" value="{'Annuler'|i18n( 'extension/metalfrance/user' )}" />
		    <input type="hidden" name="DiscardConfirm" value="0" />
		    <input type="hidden" name="RedirectIfDiscarded" value={"/user/edit"|ezurl} />
		    <input type="hidden" name="RedirectURIAfterPublish" value={"/user/edit"|ezurl} />
	    </div>
    </div>
  </form>
</div>
