{if is_unset( $class )}{def $class = 'warning'}{/if}
{if and( $validation.processed, $collection_attributes )}
  {if $validation.attributes}
      <div class="{$class|wash}">
	      <h3>{"Missing or invalid input"|i18n("design/standard/node/view")}</h3>
	      <ul>
	      {foreach $validation.attributes as $item}
	        <li>{$item.name|wash}: {$item.description}</li>
	      {/foreach}
	      </ul>
      </div>

  {/if}

{/if}
