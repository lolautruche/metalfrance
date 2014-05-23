{def $aStandardAccounts = array( '', 'standard', 'ezpublish', 'legacy' )}
{if $aStandardAccounts|contains( $object.data_map.account_type.content )|not}
    {include uri="design:user/social_user.tpl" user=$object}
{else}
    {include uri="design:user/standard_user.tpl" user=$object}
{/if}
