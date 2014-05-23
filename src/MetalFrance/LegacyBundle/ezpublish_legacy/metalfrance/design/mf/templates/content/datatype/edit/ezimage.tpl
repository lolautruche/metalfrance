{default attribute_base='ContentObjectAttribute'}
{let attribute_content=$attribute.content}

{* Current image. *}
<div class="block">
    <p>{'Taille maximum : %taille'|i18n( 'extension/metalfrance/user',, hash( '%taille', $attribute.contentclass_attribute.data_int1||mul( 1024, 1024 )|si( 'byte', 'mega' ) ) )}</p>
	<label>{'Current image'|i18n( 'design/standard/content/datatype' )} :</label>
	{if $attribute_content.original.is_valid}
	
	  <div class="mf-clear">
	    {attribute_view_gui image_class=ezini( 'ImageSettings', 'DefaultEditAlias', 'content.ini' ) attribute=$attribute}
	  </div>
	{else}
	<p>{'There is no image file.'|i18n( 'design/standard/content/datatype' )}</p>
	{/if}
	
	{if $attribute_content.original.is_valid}
	<input class="button" type="submit" name="CustomActionButton[{$attribute.id}_delete_image]" value="{'Remove image'|i18n( 'design/standard/content/datatype' )}" />
	{else}
	<input class="button-disabled" type="submit" name="CustomActionButton[{$attribute.id}_delete_image]" value="{'Remove image'|i18n( 'design/standard/content/datatype' )}" disabled="disabled" />
	{/if}
</div>

{* New image file for upload. *}
<div class="block">
    <input type="hidden" name="MAX_FILE_SIZE" value="{$attribute.contentclass_attribute.data_int1|mul( 1024, 1024 )}" />
    <label for="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_file">{'New image file for upload'|i18n( 'design/standard/content/datatype' )} :</label>
    <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_file" class="box ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" name="{$attribute_base}_data_imagename_{$attribute.id}" type="file" />
</div>

{/let}
{/default}


