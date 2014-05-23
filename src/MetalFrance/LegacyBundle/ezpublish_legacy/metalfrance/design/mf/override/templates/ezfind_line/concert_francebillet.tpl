{def $dateFrom = $node.data_map.date_from.content
     $dateTo = $node.data_map.date_to.content
     $lien = concat( '/mf/gateway/', $node.data_map.link.data_int )}
{* Definition du formatage de la date *}
{if or(
        and( $concert.data_map.date_from.has_content, $dateFrom.timestamp|eq( $dateTo.timestamp ) ),
        $concert.data_map.date_to.has_content|not
      )}
  {def $dateString = $dateFrom.timestamp|l10n( 'shortdate' )}
{elseif and( $concert.data_map.date_from.has_content|not, $concert.data_map.date_to.has_content )}
  {def $dateString = $dateTo.timestamp|l10n( 'shortdate' )}
{else}
  {def $dateString = 'Du %datefrom au %dateto'|i18n( 'extension/metalfrance/agenda',, hash( '%datefrom', $dateFrom.timestamp|l10n( 'shortdate' ),
                                                                                            '%dateto', $dateTo.timestamp|l10n( 'shortdate' ) ) )}
{/if}
{* Definition du lieu *}
{def $place = $node.data_map.place.content|wash|downcase|upfirst}
{if and( $node.data_map.region.has_content, $node.data_map.region.content|gt( 0 ) )}{set $place = concat( $place, ' - ', $node.data_map.region.content|wash )}{/if}
{def $aSummary = array(
        $place,
        $dateString,
        $node.data_map.price.content.inc_vat_price|l10n( 'currency' )
     )}
<article>
  <div class="mf-related concert-fb">
    <h5 class="concert-fb-title"><span>{'Concert'|i18n( 'extension/metalfrance' )}</span> <a href={$lien|ezurl} target="_blank">{$node.name}</a></h4>
    <p>
      <a href={$lien|ezurl}>
        {$aSummary|implode( ', ' )}
      </a>
    </p>
  </div>
</article>