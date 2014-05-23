{* Colonne de droite *}
{ezpagedata_set( 'right_column', array( 'gallery', 'livereport' ) )}
{* Categorie Analytics *}
{ezpagedata_set( 'categorie_analytics', 'Concerts' )}
{def $limit = ezini( 'ConcertSettings', 'ListLimit', 'metalfrance.ini' )
     $aConcerts = fetch( 'content', 'tree', hash(
            'parent_node_id', $node.node_id,
            'class_filter_type', 'include',
            'class_filter_array', array( 'mf_concert_francebillet' ),
            'offset', $view_parameters.offset,
            'limit', $limit,
            'sort_by', array( 
                              array( 'attribute', true(), 'mf_concert_francebillet/date_to' ),
                              array( 'attribute', true(), 'mf_concert_francebillet/date_from' ),
                            )
     ) )
     $concertCount = fetch( 'content', 'tree_count', hash(
            'parent_node_id', $node.node_id,
            'class_filter_type', 'include',
            'class_filter_array', array( 'mf_concert_francebillet' )
     ) )
     $libelleSearchBox = 'Nom du groupe, ville, N° département...'|i18n( 'extension/metalfrance/agenda' )}
          <h1 class="mf-title">/// {'Agenda concert'|i18n( 'extension/metalfrance' )}<span class="mf-sprite-header mf-sprite-agenda"></span></h1>
          
          <section class="mf-recherche-concerts">
            <div class="content-search">
              <form action={"/content/search/"|ezurl} method="get">
                <fieldset>
                    <legend>{'Rechercher un concert'|i18n( 'extension/metalfrance/agenda' )}</legend>
	                <input type="hidden" name="mode" value="concert" />
	                <input type="text" class="searchbox searchempty" name="SearchText" value="{$libelleSearchBox}" title="{$libelleSearchBox}" />
	                <input type="submit" class="searchbutton" name="SearchButton" value="{'Search'|i18n('design/ezwebin/content/search')}" /><br />
	                <input type="checkbox" name="Localize" id="searchlocalize" value="1" />
	                <label for="searchlocalize">{'Chercher des concerts dans ma région (désactive le champ de recherche)'|i18n( 'extension/metalfrance/agenda' )}</label>
                </fieldset>
              </form>
            </div>
          </section>
          
          <ul class="mf-list mf-chroniques mf-concerts">
          {foreach $aConcerts as $concert}
            {cache-block keys=array( 'list_item', $concert.node_id ) subtree_expiry=$review.node_id expiry=0}
              {node_view_gui content_node=$concert view='line'}
              
            {/cache-block}
            
          {/foreach}              
          </ul>
          
          {include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri=$node.url_alias
                     item_count=$concertCount
                     view_parameters=$view_parameters
                     item_limit=$limit}
