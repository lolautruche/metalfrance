{* Categorie Analytics *}
{ezpagedata_set( 'categorie_analytics', 'Recherche' )}
{def $libelleSearchBox = 'Tapez votre recherche'|i18n( 'extension/metalfrance/search' )
     $limit = ezini( 'SearchSettings', 'ListLimit', 'metalfrance.ini' )
     $filterParameters = fetch( 'ezfind', 'filterParameters' )
     $activeFacetParameters = array()
     $facets = fetch( 'mf', 'searchFacets' )
     $baseURI = concat( '/content/search?SearchText=', $search_text )}
{if ezhttp_hasvariable( 'activeFacets', 'get' )}
    {set $activeFacetParameters = ezhttp( 'activeFacets', 'get' )}
{/if}

{def $search = fetch( 'ezfind', 'search', hash( 
                                                'query', $search_text,
                                                'offset', $view_parameters.offset,
                                                'limit', $page_limit,
                                                'filter', $filterParameters,
                                                'sort_by', hash( 'score', 'desc', 'published', 'desc' ),
                                                'class_id', ezini( 'SearchSettings', 'SearchClassList', 'metalfrance.ini' ),
                                                'spell_check', array( true() ),
                                                'facet', $facets
                                              ) )}
          <h2 class="mf-title">/// {'Recherche'|i18n( 'extension/metalfrance/search' )}<span class="mf-sprite-header mf-sprite-recherche"></span></h2>
          
          <section class="mf-recherche">
            <div class="content-search">
              <form action={"/content/search/"|ezurl} method="get">
                <fieldset>
                    <legend>{'Rechercher sur Metal France'|i18n( 'extension/metalfrance/search' )}</legend>
                    <input type="text" class="searchbox{if $search_text|eq( '' )} searchempty{/if}" name="SearchText" value="{$search_text}" title="{$libelleSearchBox}" />
                    <input type="submit" class="searchbutton" name="SearchButton" value="{'Search'|i18n('design/ezwebin/content/search')}" />
                    
                  {if and( $search.SearchCount, $search.SearchExtras.facet_fields )}
                    <h4>{'Affinez votre recherche :'|i18n( 'extension/metalfrance/search' )}</h4>
                    <ul id="facet-list">
                    {foreach $search.SearchExtras.facet_fields as $i => $facetData}
                      {if $facetData.field|eq( 'class' )}
                        {def $classNameMap = ezini( 'SearchSettings', 'FacetClassNameMap', 'metalfrance.ini' )}
                        {debug-log var=$classNameMap}
                        {foreach $facetData.nameList as $j => $facetName}
                        <li>
                            {if is_set( $classNameMap[$facetName] )}{set $facetName = $classNameMap[$facetName]}{/if}
                            <a href={concat( $baseURI, '&filter[]=', $facetData.queryLimit[$j]|wash )|ezurl}>{$facetName}</a> ({$facetData.countList[$j]})
                        </li>
                        
                        {/foreach}
                        {undef $classNameMap}
                      {/if}
                    {/foreach}
                    </ul>
                  {/if}
                </fieldset>
              </form>
            </div>
          </section>
          
          {if $search.SearchCount}<h3 class="mf-recherche-nb-resultats">{'%nombre résultat(s) trouvé(s)'|i18n( 'extension/metalfrance/search',, hash( '%nombre', $search.SearchCount ) )}</h3>{/if}
          
{* Résultats sponsorisés Amazon, uniquement sur la première page de résultats *}
{if $view_parameters.offset|eq( 0 )}
	{cache-block keys=array( 'amazonSearch', 'sponsored', $search_text ) ignore_content_expiry}
	    {def $browseNodeMP3Album = ezini( 'AdSettings', 'AmazonMP3AlbumBrowseNode', 'metalfrance.ini' )
	         $amazonItems = fetch( 'amazonadvertising', 'item_search', hash(
		         'keywords', $search_text|wash,
		         'search_index', 'MP3Downloads',
		         'raw_params', hash( 'BrowseNode', $browseNodeMP3Album ) ) )}
		{if $amazonItems|count|gt( 0 )}
		  <section class="mf-result-sponsored">
		    <h4 class="mf-result-sponsored-title">{'Albums à télécharger :'|i18n( 'extension/metalfrance/search' )}</h3>
		  {def $sponsoredLimit = ezini( 'AdSettings', 'AmazonSponsoredSearchLimit', 'metalfrance.ini' )
		       $amazonItemIndex = 0}
		  {foreach $amazonItems as $amazonItem}
		    {if $amazonItemIndex|lt( $sponsoredLimit )}
		      {debug-log var=$amazonItem}
		      <div class="sponsored">
		        <a href={$amazonItem.url|ezurl} target="_blank" title="{"Télécharger l'album %album"|i18n( 'extension/metalfrance/search',, hash( '%album', $amazonItem.title|wash ) )}">
		          <img src={$amazonItem.image.thumbnail.url|ezurl} alt="{"Pochette de %album"|i18n( 'extension/metalfrance/search',, hash( '%album', $amazonItem.title|wash ) )}" />
		        </a>
		      </div>
		    {else}
		        {break}
		    {/if}
		    {set $amazonItemIndex = $amazonItemIndex|inc()}
		  {/foreach}
		    <div class="mf-clear"></div>
		  </section>
		{/if}
	{/cache-block}
{/if}
        
        {if $search.SearchCount}
          {debug-log var=$search.SearchExtras.facet_fields msg='SearchFacetFields'}
          <ul class="mf-list mf-chroniques">
          {foreach $search.SearchResult as $concert}
            {cache-block keys=array( 'list_item', $concert.node_id ) subtree_expiry=$review.node_id expiry=0}
              {node_view_gui content_node=$concert view='line'}
              
            {/cache-block}
            
          {/foreach}              
          </ul>

          {def $aPageUriSuffix = array( 
                                          concat( 'SearchText=', $search_text|urlencode )
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
          <h3 class="mf-recherche-concerts no-result">{'Aucun résultat ne correspond à votre recherche...'|i18n( 'extension/metalfrance/search' )}</h3>
        {/if}