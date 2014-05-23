<div id="{$id}" class="ui-tabs-panel"{if $node.data_map.image.has_content} style="background: black url({$node.data_map.image.content.carrousel.url|ezurl( 'no' )}) no-repeat center center"{/if}>
     <div class="info">
        <h3><a href={str_replace( '/layout/set/rss', '', $node.url_alias|ezurl )}>{'Live'|i18n( 'extension/metalfrance' )} : {$node.data_map.manifestation.content|wash}</a></h3>

        <p>
            {def $dateConcert = $node.data_map.date.content.timestamp|l10n( 'shortdate' )}
            {'Concert du %dateconcert'|i18n( 'extension/metalfrance',, hash( '%dateconcert', $dateConcert ) )} - {$node.data_map.lieu.content|wash}
            <a href={str_replace( '/layout/set/rss', '', $node.url_alias|ezurl )} rel="nofollow">{'Lire le live report'|i18n( 'extension/metalfrance' )}</a>
        </p>
     </div>
     <div class="content">
        <p>{$node.data_map.contenu.content.output.output_text|striptags|trim|simplify|shortenw( 400 )}</p>
     </div>
</div>