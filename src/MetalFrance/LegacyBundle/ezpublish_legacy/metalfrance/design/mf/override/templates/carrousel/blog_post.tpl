<h4><a href={$node.url_alias|ezurl}>{$node.object.published|l10n( 'shortdate' )} - {$node.data_map.title.content|wash}</a> :</h4>
<p><a rel="nofollow" href={$node.url_alias|ezurl}>{$node.data_map.body.content.output.output_text|strip_tags|simplify|shortenw( 150 )}</a></p>