{def $page_limit=10
     $col_count=2
     $sub_children=0
     $newsID = ezini( 'NodeSettings', 'News', 'metalfrance.ini' )
     $reviewsID = ezini( 'NodeSettings', 'Reviews', 'metalfrance.ini' )
     $concertsID = ezini( 'NodeSettings', 'Agenda', 'metalfrance.ini' )
     $photosID = ezini( 'NodeSettings', 'Photos', 'metalfrance.ini' )
     $liveReportsID = ezini( 'NodeSettings', 'LiveReports', 'metalfrance.ini' )
     $interviewsID = ezini( 'NodeSettings', 'Interviews', 'metalfrance.ini' )
     $children = fetch( 'content', 'node', hash( 'node_id', array( $newsID, $reviewsID, $concertsID, $photosID, $liveReportsID, $interviewsID ) ) )}
<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-sitemap">

<div class="attribute-header">
    <h1 class="long mf-title mf-noicon">{"Site map"|i18n("design/ezwebin/view/sitemap")} "{$node.name|wash}"</h1>
</div>

<div class="mf-body">
  <div class="mf-top">
	<table width="100%" cellspacing="0" cellpadding="4">
		<tr>
		{foreach $children as $key => $child}
		    <td>
		    <h2><a href={$child.url_alias|ezurl}>{$child.name}</a></h2>
		    {if $child.class_identifier|eq( 'event_calendar' )}
		        {set $sub_children=fetch('content','list',hash( 'parent_node_id', $child.node_id, 
		                                                        'limit', $page_limit,
		                                                        'sort_by', array( 'attribute', false(), 'event/from_time' ) ) )}
		    {else}
		        {set $sub_children=fetch('content','list',hash( 'parent_node_id', $child.node_id,
		                                                        'limit', $page_limit,
		                                                        'sort_by', $child.sort_array))}
		    {/if}
		    <ul>
		    {foreach $sub_children as $sub_child}
		    <li><a href={$sub_child.url_alias|ezurl}>{$sub_child.name}</a></li>
		    {/foreach}
		    </ul>
		    </td>
		    {if ne( $key|mod($col_count), 0 )}
		</tr>
		<tr>
		    {/if}
		{/foreach}
		</tr>
	</table>
  </div>
</div>

</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>