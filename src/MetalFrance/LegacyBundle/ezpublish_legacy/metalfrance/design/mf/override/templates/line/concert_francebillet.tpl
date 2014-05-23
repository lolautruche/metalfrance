{def $dateFrom = $node.data_map.date_from.content
     $dateTo = $node.data_map.date_to.content
     $titre = $node.data_map.name.content|wash|downcase|upfirst
     $lien = concat( '/mf/gateway/', $node.data_map.link.data_int )}
{* Definition du formatage de la date *}
{if or( 
        and( $node.data_map.date_from.has_content, $dateFrom.timestamp|eq( $dateTo.timestamp ) ),
        $node.data_map.date_to.has_content|not 
      )}
  {def $dateString = $dateFrom.timestamp|l10n( 'shortdate' )}
{elseif and( $node.data_map.date_from.has_content|not, $node.data_map.date_to.has_content )}
  {def $dateString = $dateTo.timestamp|l10n( 'shortdate' )}
{else}
  {def $dateString = 'Du %datefrom au %dateto'|i18n( 'extension/metalfrance/agenda',, hash( '%datefrom', $dateFrom.timestamp|l10n( 'shortdate' ),
                                                                                            '%dateto', $dateTo.timestamp|l10n( 'shortdate' ) ) )}
{/if}
            <li>
              <article class="concert-fb">
	              <a href={$lien|ezurl} target="_blank">
	                <img src={$node.data_map.image_medium.content|ezurl} alt="{"Concert %concert"|i18n( 'extension/metalfrance/agenda',, hash( '%agenda', $node.name ) )}" />
	              </a>
	              <h3 class="concert-fb-title"><a href={$lien|ezurl} target="_blank">{$node.name}</a></h3>
	              <p><b>{'Date :'|i18n( 'extension/metalfrance/agenda' )}</b> {$dateString} - <a href={$lien|ezurl} target="_blank">{'Réserver ma place'|i18n( 'extension/metalfrance/agenda' )}</a></p>
	              <p><b>{'Lieu :'|i18n( 'extension/metalfrance/agenda' )}</b> {$node.data_map.place.content|wash|downcase|upfirst}{if and( $node.data_map.region.has_content, $node.data_map.region.content|ne( 0 ) )} - {$node.data_map.region.content|wash}{/if}</p>
	              <p><b>{'Pays :'|i18n( 'extension/metalfrance/agenda' )}</b> {$node.data_map.country.content|wash}</p>
	              <p><b>{'Prix :'|i18n( 'extension/metalfrance/agenda' )}</b> {$node.data_map.price.content.inc_vat_price|l10n( 'currency' )}</p>
	              <footer><a href={$lien|ezurl} target="_blank">{'Aller voir le concert %concert'|i18n( 'extension/metalfrance/agenda',, hash( '%concert', $node.name ) )}</a></footer>
	          </article>
            </li>