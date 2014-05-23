<div id="searchbox">
  <form action={"/content/search"|ezurl} method="get">
    <label for="searchtext" class="hide">{'Search text:'|i18n('design/ezwebin/pagelayout')}</label>
    <div id="ezautocomplete" class="yui-ac">
        <input id="searchtext" class="yui-ac-input" name="SearchText" type="text" value="" />
        <input id="searchbutton" class="button mf-hidden" type="submit" value="{'Search'|i18n('design/ezwebin/pagelayout')}" />
        <div id="ezautocompletecontainer" class="yui-ac-container"></div>
        <div class="searchbuttonfield" id="searchbuttonfield"></div>
    </div>
    {if eq( $ui_context, 'browse' )}
     <input name="Mode" type="hidden" value="browse" />
    {/if}
    
  </form>
</div>

{*if $pagedata.is_edit|not()}

{ezscript_require( array('ezjsc::jquery', 'ezjsc::yui3', 'ezajax_autocomplete.js') )}
<script type="text/javascript">

jQuery('#ezautocompletecontainer').css('width', jQuery('input#searchtext').width() + 60);

var ezAutoHeader = eZAJAXAutoComplete();
ezAutoHeader.init({ldelim}

    url: "{'ezjscore/call/ezfind::autocomplete'|ezurl('no')}",
    inputid: 'searchtext',
    containerid: 'ezautocompletecontainer',
    minquerylength: {ezini( 'AutoCompleteSettings', 'MinQueryLength', 'ezfind.ini' )},
    resultlimit: {ezini( 'AutoCompleteSettings', 'Limit', 'ezfind.ini' )}

{rdelim});
</script>

{/if*}
