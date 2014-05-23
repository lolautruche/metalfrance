<div id="{$id}" class="ui-tabs-panel"{if $node.data_map.image.has_content} style="background: black url({$node.data_map.image.content.carrousel.url|ezurl( 'no' )}) no-repeat center center"{/if}>
     <div class="info">
        <h3><a href={str_replace( '/layout/set/rss', '', $node.url_alias|ezurl )}>{'Interview'|i18n( 'extension/metalfrance' )} : {$node.data_map.artiste.content|wash}</a></h3>

        <p>
            
            <a href={str_replace( '/layout/set/rss', '', $node.url_alias|ezurl )} rel="nofollow">{"Lire l'interview"|i18n( 'extension/metalfrance' )}</a>
        </p>
     </div>
     <div class="content">
        <p>{$node.data_map.introduction.content.output.output_text|striptags|trim|simplify|shortenw( 400 )}</p>
     </div>
</div>