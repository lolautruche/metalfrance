{*
    Les blocs de droite doivent être passés depuis les templates de vue :
    {ezpagedata_set( 'right_column', array( 'block1', 'block2', ... ) )}
    
    Le template du block doit se situer dans design:right_column/
    Ex.: extension/metalfrance/design/mf/templates/right_column/block1.tpl
*}
{def $rightColumnBlocks = ezini( 'RightColumnSettings', 'DefaultBlocks', 'metalfrance.ini' )}
{if is_set( $module_result.content_info.persistent_variable['right_column'] )}
    {set $rightColumnBlocks = $module_result.content_info.persistent_variable['right_column']}
    {if $rightColumnBlocks|is_array|not}{set $rightColumnBlocks = array( $rightColumnBlocks )}{/if}
{/if}
      <div class="mf-col-last">
        {include uri="design:parts/right_column/advertisement.tpl"}
      
      {foreach $rightColumnBlocks as $block}
        {include uri=concat( 'design:parts/right_column/', $block, '.tpl' )}
        
      {/foreach}
      </div>