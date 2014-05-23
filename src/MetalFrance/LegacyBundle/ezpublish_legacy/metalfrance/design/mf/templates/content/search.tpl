{def $mode = 'regular'}
{if ezhttp_hasvariable( 'mode', 'get' )}{set $mode = ezhttp( 'mode', 'get' )}{/if}
{switch match=$mode}
    {case match='concert'}{include uri="design:search/concert.tpl"}{/case}
    {case}{include uri="design:search/regular.tpl"}{/case}
{/switch}