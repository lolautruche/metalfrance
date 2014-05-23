{def $styles = str_replace( '|#', ', ', $node.data_map.styles.content.keyword_string )
     $title = concat( '[Chronique] '|i18n( 'extension/metalfrance/rss' ), $node.name|wash )}
{if $styles|ne( '' )}{set $title = concat( $title, ' // ', $styles )}{/if}
	<item>
	  <title>{$title|shorten( 140 )}</title>
	  <link>{str_replace( '/layout/set/rss', '', $node.url_alias|ezurl( 'no', 'full' ) )}</link>
	  <description>{$node.data_map.introduction.content|wash|trim|simplify|shortenw( 400 )}</description>
	  <pubDate>{$node.object.published|datetime( 'custom', '%r' )}</pubDate>
	  <guid isPermaLink="false">{concat( 'content/view/full/', $node.node_id )}</guid>
	</item>
