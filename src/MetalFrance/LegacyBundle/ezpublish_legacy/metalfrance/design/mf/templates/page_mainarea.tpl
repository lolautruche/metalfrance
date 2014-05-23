{def $mainSectionClasses = array()
     $aUriWithoutGlobalSection = ezini( 'GeneralSettings', 'URIWithoutGlobalSectionTag', 'metalfrance.ini' )}
{if is_set( $module_result.content_info.persistent_variable['main_section_classes'] )}
    {set $mainSectionClasses = $module_result.content_info.persistent_variable['main_section_classes']}
    {if $mainSectionClasses|is_array|not}{set $mainSectionClasses = array( $mainSectionClasses )}{/if}
{/if}
    <div id="mf-content" class="mf-clear">
      <div class="mf-col-first">
{* 
    La plupart des pages ont besoin d'un tag <section class="mf-section"> global
    Sauf certaines pages plus complexes (homepage notamment)
*}
      {if $aUriWithoutGlobalSection|contains( $module_result.uri )}
          {$module_result.content}
      {else}
        <section class="mf-section{if $mainSectionClasses|count} {$mainSectionClasses|implode( ' ' )}{/if}">
          {$module_result.content}
        </section>        
      {/if}
      </div>

{cache-block keys=array( $module_result.uri, 'right_column' )}      
      {include uri="design:page_right_column.tpl"}
{/cache-block}
    </div>