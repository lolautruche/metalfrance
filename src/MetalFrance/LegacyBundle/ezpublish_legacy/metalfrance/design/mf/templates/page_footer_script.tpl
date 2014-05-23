{* Load JavaScript dependencys + JavaScriptList *}
{def $jsList = ezini( 'JavaScriptSettings', 'JavaScriptFooterList', 'design.ini' )}
{ezscript_require( $jsList )}

{*if $pagedesign.data_map.footer_script.has_content}
<script language="javascript" type="text/javascript">
<!--

    {$pagedesign.data_map.footer_script.content}

-->
</script>
{/if*}
{* Override this template and place javascript based statestics here (like Google Analytics) *}
{include uri='design:janrain/modalscript.tpl'}

{* Google +1 *}
<script type="text/javascript" src="http://apis.google.com/js/plusone.js">
  {ldelim}lang: 'fr', parsetags: 'explicit'{rdelim}
</script>