{def $pageConcerts = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'Agenda', 'metalfrance.ini' ) ) )
     $aConcerts = fetch( 'content', 'tree', hash(
            'parent_node_id', $pageConcerts.node_id,
            'class_filter_type', 'include',
            'class_filter_array', array( 'mf_concert_francebillet' ),
            'limit', 5,
            'sort_by', array( 
                              array( 'attribute', true(), 'mf_concert_francebillet/date_to' ),
                              array( 'attribute', true(), 'mf_concert_francebillet/date_from' ),
                            )
     ) )}
        <section id="mf-agenda" class="mf-section">
          <h4 class="mf-title">/// {'Agenda concert'|i18n( 'extension/metalfrance' )}<span class="mf-sprite-header mf-sprite-agenda"></span></h4>
          <ul class="mf-list">
          {foreach $aConcerts as $concert}
            {def $dateFrom = $concert.data_map.date_from.content
                 $dateTo = $concert.data_map.date_to.content
                 $titre = $concert.data_map.name.content|wash|downcase|upfirst
                 $lien = concat( '/mf/gateway/', $concert.data_map.link.data_int )}
            <li>
              <h3><a href={$lien|ezurl} target="_blank" title="{'Billets pour le concert %concert'|i18n( 'extension/metalfrance/agenda',, 
                                                                                                                                   hash( '%concert', $titre ) )}">{$titre}</a></h3>
              <span>{$concert.data_map.place.content|wash|downcase|upfirst}</span><br />
              {if or( 
                      and( $concert.data_map.date_from.has_content, $dateFrom.timestamp|eq( $dateTo.timestamp ) ),
                      $concert.data_map.date_to.has_content|not 
                    )}
              <span>{'Le %date'|i18n( 'extension/metalfrance/agenda',, hash( '%date', $dateFrom.timestamp|l10n( 'shortdate' ) ) )}</span>
              {elseif and( $concert.data_map.date_from.has_content|not, $concert.data_map.date_to.has_content )}
              <span>{'Le %date'|i18n( 'extension/metalfrance/agenda',, hash( '%date', $dateTo.timestamp|l10n( 'shortdate' ) ) )}</span>
              {else}
              <span>{'Du %datefrom au %dateto'|i18n( 'extension/metalfrance/agenda',, hash( '%datefrom', $dateFrom.timestamp|l10n( 'shortdate' ),
                                                                                            '%dateto', $dateTo.timestamp|l10n( 'shortdate' ) ) )}</span>
              {/if}
            </li>
            {undef $dateFrom $dateTo $titre $lien}
          {/foreach}
          </ul>
          <p><a href={$pageConcerts.url_alias|ezurl}>{'Voir toutes les dates de concert'|i18n( 'extension/metalfrance/agenda' )}</a></p>
        </section>