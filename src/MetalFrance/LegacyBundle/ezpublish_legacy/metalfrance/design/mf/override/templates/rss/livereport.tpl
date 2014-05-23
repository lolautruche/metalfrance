	<item>
	  <title>{'[Live Report]'|i18n( 'extension/metalfrance/rss' )} {$node.name|wash}</title>
	  <link>{str_replace( '/layout/set/rss', '', $node.url_alias|ezurl( 'no', 'full' ) )}</link>
	  <description>
	   {def $description = $node.data_map.contenu.content.output.output_text|striptags|trim|simplify|shortenw( 400 )}
	   {str_replace( '&nbsp;', ' ', $description )}
	  </description>
	  <pubDate>{$node.object.published|datetime( 'custom', '%r' )}</pubDate>
	  <guid isPermaLink="false">{concat( 'content/view/full/', $node.node_id )}</guid>
	</item>
