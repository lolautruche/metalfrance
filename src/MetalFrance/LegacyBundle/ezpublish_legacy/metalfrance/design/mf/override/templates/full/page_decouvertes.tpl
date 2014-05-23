{def $pageChroniques = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'Reviews', 'metalfrance.ini' ) ) )}
{redirect( $pageChroniques.url_alias, 301 )}