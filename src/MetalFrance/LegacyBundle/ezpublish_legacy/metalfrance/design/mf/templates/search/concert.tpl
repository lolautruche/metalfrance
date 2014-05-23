{* Colonne de droite *}
{ezpagedata_set( 'right_column', array( 'gallery', 'livereport' ) )}
{* Categorie Analytics *}
{ezpagedata_set( 'categorie_analytics', 'Concerts' )}
{def $libelleSearchBox = 'Nom du groupe, ville, N° département...'|i18n( 'extension/metalfrance/agenda' )
     $limit = ezini( 'ConcertSettings', 'ListLimit', 'metalfrance.ini' )
     $filterParameters = array()
     $doLocalize = ezhttp_hasvariable( 'Localize', 'get' )}
{if $doLocalize}
    {def $ip = fetch( 'sqligeoloc', 'remote_ip', hash() )}
    {if ezini( 'ConcertSettings', 'SearchDebug', 'metalfrance.ini' )|eq( 'enabled' )}
        {set $ip = ezini( 'ConcertSettings', 'SearchDebugIP', 'metalfrance.ini' )}
    {/if}
    {def $geoInfo = fetch( 'sqligeoloc', 'ip_info', hash( 'mode', 'city',
                                                          'ip', $ip ) )}
    {if and( $geoInfo.country_code|eq( 'FR' ), $geoInfo.region_name )}
        {if ezini_hasvariable( concat( 'Region_', $geoInfo.region_name ), 'Departements', 'sqligeoloc.ini' )}
            {def $departements = ezini( concat( 'Region_', $geoInfo.region_name ), 'Departements', 'sqligeoloc.ini' )}
            {set $filterParameters = $filterParameters|append( 'or' )}
            {foreach $departements as $departement}
                {set $filterParameters = $filterParameters|append( concat( 'mf_concert_francebillet/region:', $departement ) )}
            {/foreach}
        {/if}
    {elseif and( $geoInfo.country_code|ne( 'FR' ), $geoInfo.country_code|ne( 'RD' ) )}{* Ni France, ni "réservé" *}
        {set $filterParameters = $filterParameters|append( concat( 'mf_concert_francebillet/country:', $geoInfo.country_code ) )}
    {/if}
{/if}
{def $search = fetch( 'ezfind', 'search', hash( 
                                                'query', $search_text,
                                                'offset', $view_parameters.offset,
                                                'limit', $page_limit,
                                                'sort_by', hash(
                                                                  'mf_concert_francebillet/date_to', 'asc',
                                                                  'mf_concert_francebillet/date_from', 'asc'
                                                               ),
                                                'filter', $filterParameters,
                                                'class_id', array( 'mf_concert_francebillet' )
                                              ) )}
          <h2 class="mf-title">/// {'Recherche de concerts'|i18n( 'extension/metalfrance/agenda' )}<span class="mf-sprite-header mf-sprite-agenda"></span></h2>
          
          <section class="mf-recherche-concerts">
            <div class="content-search">
              <form action={"/content/search/"|ezurl} method="get">
                <fieldset>
                    <legend>{'Rechercher un concert'|i18n( 'extension/metalfrance/agenda' )}</legend>
                    <input type="hidden" name="mode" value="concert" />
                    <input type="text" class="searchbox{if $search_text|eq( '' )} searchempty{/if}" name="SearchText" value="{$search_text}" title="{$libelleSearchBox}"{if $doLocalize} disabled="disabled"{/if} />
                    <input type="submit" class="searchbutton" name="SearchButton" value="{'Search'|i18n('design/ezwebin/content/search')}" /><br />
                    <input type="checkbox" name="Localize" id="searchlocalize" value="1"{if $doLocalize} checked="checked"{/if} />
                    <label for="searchlocalize">{'Chercher des concerts dans ma région (désactive le champ de recherche)'|i18n( 'extension/metalfrance/agenda' )}</label>
                </fieldset>
              </form>
            </div>
          </section>
          
        {if $search.SearchCount}
          <h3 class="mf-recherche-concerts">{'%nombre concert(s) trouvé(s)'|i18n( 'extension/metalfrance/agenda',, hash( '%nombre', $search.SearchCount ) )}</h3>
          <ul class="mf-list mf-chroniques mf-concerts">
          {foreach $search.SearchResult as $concert}
            {cache-block keys=array( 'list_item', $concert.node_id ) subtree_expiry=$review.node_id expiry=0}
              {node_view_gui content_node=$concert view='line'}
              
            {/cache-block}
            
          {/foreach}              
          </ul>

		  {def $aPageUriSuffix = array( 
		                                  concat( 'SearchText=', $search_text|urlencode ),
		                                  'mode=concert' 
		                              )}
		  {if $doLocalize}{set $aPageUriSuffix = $aPageUriSuffix|append( 'Localize=1' )}{/if}
          {include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri='/content/search'
                     page_uri_suffix=concat( '?', $aPageUriSuffix|implode( '&' )  )
                     item_count=$search.SearchCount
                     view_parameters=$view_parameters
                     item_limit=$limit}
        {else}{* Pas de résultat *}
          <h3 class="mf-recherche-concerts no-result">{'Aucun concert ne correspond à votre recherche...'|i18n( 'extension/metalfrance/agenda' )}</h3>
        {/if}